import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/exercise/exercise_bloc.dart';
import '../../blocs/exercise/exercise_event.dart';
import '../../blocs/exercise/exercise_state.dart';
import '../../widgets/exercise_list_item.dart';
import '../../../domain/entities/exercise_enums.dart';

/// Screen to display list of exercises grouped by muscle group
class ExerciseListScreen extends StatefulWidget {
  const ExerciseListScreen({super.key});

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  @override
  void initState() {
    super.initState();
    // Load exercises on screen init
    context.read<ExerciseBloc>().add(const LoadExercises());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
        elevation: 2,
      ),
      body: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          if (state is ExerciseLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ExerciseError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading exercises',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ExerciseBloc>().add(const LoadExercises());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ExercisesLoaded) {
            final exercises = state.exercises;

            if (exercises.isEmpty) {
              return const Center(
                child: Text('No exercises found'),
              );
            }

            // Group exercises by muscle group
            final groupedExercises = <MuscleGroup, List>{};
            for (final exercise in exercises) {
              if (!groupedExercises.containsKey(exercise.muscleGroup)) {
                groupedExercises[exercise.muscleGroup] = [];
              }
              groupedExercises[exercise.muscleGroup]!.add(exercise);
            }

            return ListView.builder(
              itemCount: groupedExercises.length,
              itemBuilder: (context, index) {
                final muscleGroup = groupedExercises.keys.elementAt(index);
                final groupExercises = groupedExercises[muscleGroup]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Muscle group header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Text(
                        muscleGroup.displayName,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                    // Exercises in this group
                    ...groupExercises.map(
                      (exercise) => ExerciseListItem(
                        exercise: exercise,
                        onTap: () {
                          // TODO: Navigate to exercise details or select
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              },
            );
          }

          return const Center(
            child: Text('Press the button to load exercises'),
          );
        },
      ),
    );
  }
}

