import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/workout.dart';
import '../../../domain/entities/workout_exercise.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/workout/workout_bloc.dart';
import '../../blocs/workout/workout_event.dart';
import '../../blocs/workout/workout_state.dart';
import '../../widgets/workout/workout_exercise_list_item.dart';

/// Extension pour accéder facilement aux traductions via context
extension _LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Screen to create or edit a workout
class WorkoutBuilderScreen extends StatefulWidget {
  final Workout? workout; // null for new workout, non-null for editing

  const WorkoutBuilderScreen({super.key, this.workout});

  @override
  State<WorkoutBuilderScreen> createState() => _WorkoutBuilderScreenState();
}

class _WorkoutBuilderScreenState extends State<WorkoutBuilderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _notesController = TextEditingController();
  final List<WorkoutExercise> _exercises = [];
  final Uuid uuid = const Uuid();

  bool get _isEditing => widget.workout != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _nameController.text = widget.workout!.name;
      _descriptionController.text = widget.workout!.description ?? '';
      _notesController.text = widget.workout!.notes ?? '';
      _exercises.addAll(widget.workout!.exercises);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _saveWorkout() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_exercises.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(context.l10n.workoutNeedsExercises),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final workout = Workout(
      id: _isEditing ? widget.workout!.id : uuid.v4(),
      name: _nameController.text.trim(),
      description: _descriptionController.text.trim().isEmpty
          ? null
          : _descriptionController.text.trim(),
      exercises: _exercises,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
      createdAt: _isEditing ? widget.workout!.createdAt : DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (_isEditing) {
      context.read<WorkoutBloc>().add(UpdateWorkoutEvent(workout));
    } else {
      context.read<WorkoutBloc>().add(CreateWorkoutEvent(workout));
    }

    Navigator.of(context).pop();
  }

  void _addExercise() {
    // TODO: Navigate to exercise picker
    // For now, show a message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exercise picker coming soon!'),
      ),
    );
  }

  void _removeExercise(int index) {
    setState(() {
      _exercises.removeAt(index);
      // Update order indices
      for (int i = 0; i < _exercises.length; i++) {
        _exercises[i] = _exercises[i].copyWith(order: i);
      }
    });
  }

  void _reorderExercises(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final exercise = _exercises.removeAt(oldIndex);
      _exercises.insert(newIndex, exercise);

      // Update order indices
      for (int i = 0; i < _exercises.length; i++) {
        _exercises[i] = _exercises[i].copyWith(order: i);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _isEditing ? context.l10n.editWorkout : context.l10n.newWorkout),
        actions: [
          TextButton(
            onPressed: _saveWorkout,
            child: Text(
              context.l10n.save,
              style: AppTextStyles.button.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: BlocListener<WorkoutBloc, WorkoutState>(
        listener: (context, state) {
          if (state is WorkoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 100, // Extra padding for FAB
            ),
            children: [
              // Workout Name
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: context.l10n.workoutName,
                  hintText: context.l10n.workoutNameHint,
                  prefixIcon: const Icon(Icons.fitness_center),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.l10n.workoutNameRequired;
                  }
                  if (value.length > 100) {
                    return context.l10n.workoutNameTooLong;
                  }
                  return null;
                },
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: context.l10n.description,
                  hintText: context.l10n.descriptionHint,
                  prefixIcon: const Icon(Icons.description),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 3,
                maxLength: 500,
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: 24),

              // Exercises Section Header
              Row(
                children: [
                  Text(
                    context.l10n.exercises,
                    style: AppTextStyles.h4,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_exercises.length}',
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.add_circle),
                    color: AppColors.primary,
                    onPressed: _addExercise,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Exercises List
              if (_exercises.isEmpty)
                _buildEmptyState()
              else
                _buildExercisesList(),

              const SizedBox(height: 24),

              // Notes Section with visible header
              Row(
                children: [
                  const Icon(Icons.note, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    context.l10n.notes,
                    style: AppTextStyles.h4,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Notes TextField
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  hintText: context.l10n.notesHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addExercise,
        icon: const Icon(Icons.add),
        label: Text(context.l10n.addExercise),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderLight,
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside,
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.fitness_center,
            size: 48,
            color: AppColors.textDisabledLight,
          ),
          const SizedBox(height: 16),
          Text(
            context.l10n.noExercisesAdded,
            style: AppTextStyles.body1.copyWith(
              color: AppColors.textSecondaryLight,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.tapToAddExercises,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textDisabledLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesList() {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _exercises.length,
      onReorder: _reorderExercises,
      itemBuilder: (context, index) {
        final exercise = _exercises[index];
        return WorkoutExerciseListItem(
          key: ValueKey(exercise.exerciseId),
          workoutExercise: exercise,
          index: index,
          onRemove: () => _removeExercise(index),
          onTargetSetsChanged: (sets) {
            setState(() {
              _exercises[index] = exercise.copyWith(targetSets: sets);
            });
          },
          onRestTimeChanged: (duration) {
            setState(() {
              _exercises[index] = exercise.copyWith(restTime: duration);
            });
          },
        );
      },
    );
  }
}
