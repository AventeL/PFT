import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/workout.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/exercise/exercise_bloc.dart';
import '../../blocs/exercise/exercise_state.dart';
import '../../blocs/workout/workout_bloc.dart';
import '../../blocs/workout/workout_event.dart';
import '../../blocs/workout/workout_state.dart';
import '../workout_builder/workout_builder_screen.dart';

/// Extension pour accéder facilement aux traductions via context
extension _LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Screen to preview a workout template before importing
class TemplatePreviewScreen extends StatelessWidget {
  final Workout template;

  const TemplatePreviewScreen({
    super.key,
    required this.template,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(template.name),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'TEMPLATE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Description section
          if (template.description != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              child: Text(
                template.description!,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),

          // Exercises list
          Expanded(
            child: BlocBuilder<ExerciseBloc, ExerciseState>(
              builder: (context, exerciseState) {
                if (exerciseState is! ExercisesLoaded) {
                  return const Center(child: CircularProgressIndicator());
                }

                final exercises = exerciseState.exercises;

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: template.exercises.length,
                  itemBuilder: (context, index) {
                    final workoutExercise = template.exercises[index];
                    final exercise = exercises.firstWhere(
                      (e) => e.id == workoutExercise.exerciseId,
                      orElse: () => exercises.first, // Fallback
                    );

                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(exercise.name),
                        subtitle: Text(
                          '${workoutExercise.targetSets} ${context.l10n.sets.toLowerCase()}'
                          '${workoutExercise.restTime != null ? ' • ${workoutExercise.restTime!.inSeconds}s repos' : ''}',
                        ),
                        trailing: Icon(
                          Icons.fitness_center,
                          color: Colors.grey[400],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Use template button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: BlocConsumer<WorkoutBloc, WorkoutState>(
                listener: (context, state) {
                  if (state is TemplateImported) {
                    // Capture blocs before navigation
                    final workoutBloc = context.read<WorkoutBloc>();
                    final exerciseBloc = context.read<ExerciseBloc>();

                    // Navigate to workout builder with imported workout
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MultiBlocProvider(
                          providers: [
                            BlocProvider.value(value: workoutBloc),
                            BlocProvider.value(value: exerciseBloc),
                          ],
                          child: WorkoutBuilderScreen(
                            workout: state.workout,
                          ),
                        ),
                      ),
                    );
                  } else if (state is WorkoutError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isLoading = state is WorkoutLoading;

                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<WorkoutBloc>().add(
                                    ImportTemplateEvent(template.id),
                                  );
                            },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              context.l10n.useThisTemplate,
                              style: const TextStyle(fontSize: 16),
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
