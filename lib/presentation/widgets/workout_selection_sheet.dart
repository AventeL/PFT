import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/workout.dart';
import '../../../l10n/app_localizations.dart';
import '../blocs/active_workout/active_workout_bloc.dart';
import '../blocs/active_workout/active_workout_event.dart';
import '../blocs/workout/workout_bloc.dart';
import '../blocs/workout/workout_event.dart';
import '../blocs/workout/workout_state.dart';
import '../screens/active_workout/active_workout_screen.dart';

/// Extension pour accéder facilement aux traductions via context
extension _LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Bottom sheet for selecting a workout to start
class WorkoutSelectionSheet extends StatefulWidget {
  const WorkoutSelectionSheet({super.key});

  @override
  State<WorkoutSelectionSheet> createState() => _WorkoutSelectionSheetState();
}

class _WorkoutSelectionSheetState extends State<WorkoutSelectionSheet> {
  @override
  void initState() {
    super.initState();
    // Refresh workouts when sheet is opened to ensure we have the latest
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<WorkoutBloc>().add(const LoadWorkouts());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Sélectionner une séance',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),

          const SizedBox(height: 16),

          // Quick Start Option (Always visible at top)
          _buildQuickStartOption(context),

          const SizedBox(height: 16),

          // Tabs for My Workouts and Templates
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    tabs: [
                      Tab(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(context.l10n.myWorkouts),
                        ),
                      ),
                      const Tab(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text('Templates'),
                        ),
                      ),
                    ],
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                  ),
                  Expanded(
                    child: BlocBuilder<WorkoutBloc, WorkoutState>(
                      builder: (context, state) {
                        if (state is WorkoutsLoaded ||
                            state is TemplatesLoaded) {
                          List<Workout> workouts = [];
                          List<Workout> templates = [];

                          if (state is WorkoutsLoaded) {
                            workouts = state.workouts
                                .where((w) => !w.isTemplate)
                                .toList();
                            templates = state.workouts
                                .where((w) => w.isTemplate)
                                .toList();
                          } else if (state is TemplatesLoaded) {
                            templates = state.templates;
                          }

                          return TabBarView(
                            children: [
                              // My Workouts Tab
                              _buildWorkoutList(context, workouts),
                              // Templates Tab
                              _buildWorkoutList(context, templates),
                            ],
                          );
                        }

                        if (state is WorkoutError) {
                          return _buildErrorState(context, state.message);
                        }

                        // Initial, WorkoutLoading, TemplatesSeeded states all show spinner
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutList(BuildContext context, List<Workout> workouts) {
    if (workouts.isEmpty) {
      return _buildEmptyState(context);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: workouts.length,
      itemBuilder: (context, index) =>
          _buildWorkoutOption(context, workouts[index]),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          'Aucune séance disponible.\nCréez-en une ou utilisez le démarrage rapide.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            TextButton(
              onPressed: () =>
                  context.read<WorkoutBloc>().add(const LoadWorkouts()),
              child: const Text('Réessayer'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStartOption(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 2,
        color: Theme.of(context).colorScheme.primaryContainer.withAlpha(60),
        child: InkWell(
          onTap: () => _startWorkout(context, null),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.flash_on,
                  size: 32,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.l10n.quickStart,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWorkoutOption(BuildContext context, Workout workout) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => _startWorkout(context, workout),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.fitness_center,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workout.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${workout.exercises.length} exercices',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _startWorkout(BuildContext context, Workout? workout) {
    // Capture blocs before navigation
    final activeWorkoutBloc = context.read<ActiveWorkoutBloc>();

    // Dispatch start event
    activeWorkoutBloc.add(StartWorkoutSession(workout: workout));

    // Close bottom sheet
    Navigator.of(context).pop();

    // Navigate to active workout screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: activeWorkoutBloc,
          child: const ActiveWorkoutScreen(),
        ),
      ),
    );
  }
}
