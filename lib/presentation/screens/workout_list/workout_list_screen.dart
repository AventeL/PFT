import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/exercise/exercise_bloc.dart';
import '../../blocs/workout/workout_bloc.dart';
import '../../blocs/workout/workout_event.dart';
import '../../blocs/workout/workout_state.dart';
import '../../widgets/common/shimmer_widget.dart';
import '../workout_builder/workout_builder_screen.dart';

/// Extension pour accéder facilement aux traductions via context
extension _LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Screen to display list of workouts
class WorkoutListScreen extends StatefulWidget {
  const WorkoutListScreen({super.key});

  @override
  State<WorkoutListScreen> createState() => _WorkoutListScreenState();
}

class _WorkoutListScreenState extends State<WorkoutListScreen> {
  @override
  void initState() {
    super.initState();
    // Load workouts on screen init
    context.read<WorkoutBloc>().add(const LoadWorkouts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.myWorkouts),
        elevation: 2,
      ),
      body: BlocConsumer<WorkoutBloc, WorkoutState>(
        listener: (context, state) {
          if (state is WorkoutCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.l10n.successWorkoutCreated),
                backgroundColor: AppColors.success,
              ),
            );
          } else if (state is WorkoutDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.l10n.successWorkoutDeleted),
                backgroundColor: AppColors.success,
              ),
            );
          } else if (state is WorkoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          // Loading state
          if (state is WorkoutLoading) {
            return const WorkoutListShimmer();
          }

          // Error state
          if (state is WorkoutError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 64, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(context.l10n.errorLoadingData, style: AppTextStyles.h4),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<WorkoutBloc>().add(const LoadWorkouts());
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(context.l10n.cancel),
                  ),
                ],
              ),
            );
          }

          // Loaded state
          if (state is WorkoutsLoaded) {
            final workouts = state.workouts;

            if (workouts.isEmpty) {
              return _buildEmptyState();
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: workouts.length,
              itemBuilder: (context, index) {
                final workout = workouts[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        color: AppColors.primary,
                      ),
                    ),
                    title: Text(
                      workout.name,
                      style: AppTextStyles.h5,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (workout.description != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            workout.description!,
                            style: AppTextStyles.body2.copyWith(
                              color: AppColors.textSecondaryLight,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.fitness_center,
                              size: 16,
                              color: AppColors.textSecondaryLight,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${workout.exercises.length} ${context.l10n.exercises.toLowerCase()}',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondaryLight,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Row(
                            children: [
                              const Icon(Icons.edit),
                              const SizedBox(width: 8),
                              Text(context.l10n.edit),
                            ],
                          ),
                          onTap: () {
                            // Navigate to edit screen
                            final workoutToEdit = workout;
                            Future.delayed(Duration.zero, () {
                              if (context.mounted) {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider.value(
                                          value: context.read<WorkoutBloc>(),
                                        ),
                                        BlocProvider.value(
                                          value: context.read<ExerciseBloc>(),
                                        ),
                                      ],
                                      child: WorkoutBuilderScreen(
                                        workout: workoutToEdit,
                                      ),
                                    ),
                                  ),
                                );
                              }
                            });
                          },
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              const Icon(Icons.copy),
                              const SizedBox(width: 8),
                              Text(context.l10n.duplicateWorkout),
                            ],
                          ),
                          onTap: () {
                            context
                                .read<WorkoutBloc>()
                                .add(DuplicateWorkoutEvent(workout));
                          },
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: [
                              const Icon(Icons.delete, color: AppColors.error),
                              const SizedBox(width: 8),
                              Text(
                                context.l10n.delete,
                                style: const TextStyle(color: AppColors.error),
                              ),
                            ],
                          ),
                          onTap: () {
                            // Show confirmation dialog
                            final workoutToDelete = workout;
                            Future.delayed(Duration.zero, () {
                              if (context.mounted) {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) => AlertDialog(
                                    title: Text(context.l10n.deleteWorkout),
                                    content: Text(
                                      'Êtes-vous sûr de vouloir supprimer "${workoutToDelete.name}" ?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(dialogContext).pop(),
                                        child: Text(context.l10n.cancel),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.read<WorkoutBloc>().add(
                                              DeleteWorkoutEvent(
                                                  workoutToDelete.id));
                                          Navigator.of(dialogContext).pop();
                                        },
                                        child: Text(
                                          context.l10n.delete,
                                          style: const TextStyle(
                                              color: AppColors.error),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      // TODO: Navigate to workout detail or start workout
                    },
                  ),
                );
              },
            );
          }

          // Initial state
          return _buildEmptyState();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<WorkoutBloc>(),
                  ),
                  BlocProvider.value(
                    value: context.read<ExerciseBloc>(),
                  ),
                ],
                child: const WorkoutBuilderScreen(),
              ),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: Text(context.l10n.createWorkout),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.fitness_center,
              size: 64,
              color: AppColors.textDisabledLight,
            ),
            const SizedBox(height: 16),
            Text(
              context.l10n.emptyWorkouts,
              style: AppTextStyles.h4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.emptyWorkoutsDescription,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
