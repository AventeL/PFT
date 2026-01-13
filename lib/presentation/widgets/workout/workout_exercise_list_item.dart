import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/exercise.dart';
import '../../../domain/entities/workout_exercise.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/exercise/exercise_bloc.dart';
import '../../blocs/exercise/exercise_state.dart';

/// Extension pour accéder facilement aux traductions via context
extension _LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Widget to display a workout exercise in the builder list
class WorkoutExerciseListItem extends StatelessWidget {
  final WorkoutExercise workoutExercise;
  final int index;
  final VoidCallback onRemove;
  final Function(int) onTargetSetsChanged;
  final Function(Duration?) onRestTimeChanged;

  const WorkoutExerciseListItem({
    super.key,
    required this.workoutExercise,
    required this.index,
    required this.onRemove,
    required this.onTargetSetsChanged,
    required this.onRestTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseBloc, ExerciseState>(
      builder: (context, state) {
        Exercise? exercise;

        if (state is ExercisesLoaded) {
          try {
            exercise = state.allExercises.firstWhere(
              (e) => e.id == workoutExercise.exerciseId,
            );
          } catch (e) {
            // Exercise not found
          }
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                // Drag handle
                ReorderableDragStartListener(
                  index: index,
                  child: const Icon(
                    Icons.drag_handle,
                    color: AppColors.textSecondaryLight,
                  ),
                ),

                const SizedBox(width: 8),

                // Exercise info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Exercise name
                      Text(
                        exercise?.name ?? context.l10n.unknownExercise,
                        style: AppTextStyles.exerciseName,
                      ),

                      const SizedBox(height: 4),

                      // Muscle group badge
                      if (exercise != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.getMuscleGroupColor(
                              exercise.muscleGroup.name,
                            ).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getMuscleGroupName(
                                context, exercise.muscleGroup.name),
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.getMuscleGroupColor(
                                exercise.muscleGroup.name,
                              ),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(width: 4),

                // Target sets input
                SizedBox(
                  width: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.sets,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: workoutExercise.targetSets > 1
                                ? () => onTargetSetsChanged(
                                      workoutExercise.targetSets - 1,
                                    )
                                : null,
                            child: Icon(
                              Icons.remove_circle_outline,
                              size: 16,
                              color: workoutExercise.targetSets > 1
                                  ? AppColors.textSecondaryLight
                                  : AppColors.textDisabledLight,
                            ),
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${workoutExercise.targetSets}',
                            style: AppTextStyles.setInput,
                          ),
                          const SizedBox(width: 2),
                          InkWell(
                            onTap: () => onTargetSetsChanged(
                              workoutExercise.targetSets + 1,
                            ),
                            child: const Icon(
                              Icons.add_circle_outline,
                              size: 16,
                              color: AppColors.textSecondaryLight,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 4),

                // Delete button
                IconButton(
                  icon: const Icon(Icons.delete_outline, size: 20),
                  color: AppColors.error,
                  onPressed: onRemove,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getMuscleGroupName(BuildContext context, String muscleGroup) {
    final l10n = context.l10n;
    return switch (muscleGroup.toLowerCase()) {
      'chest' => l10n.muscleGroupChest,
      'back' => l10n.muscleGroupBack,
      'shoulders' => l10n.muscleGroupShoulders,
      'legs' => l10n.muscleGroupLegs,
      'arms' => l10n.muscleGroupArms,
      'core' => l10n.muscleGroupCore,
      'cardio' => l10n.muscleGroupCardio,
      'fullbody' || 'full body' => l10n.muscleGroupFullBody,
      _ => l10n.muscleGroupOther,
    };
  }
}
