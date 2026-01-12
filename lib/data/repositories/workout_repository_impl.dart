import 'package:uuid/uuid.dart';
import '../../domain/entities/workout.dart';
import '../../domain/repositories/workout_repository.dart';
import '../datasources/local/workout_local_datasource.dart';
import '../models/workout_model.dart';
import '../models/workout_exercise_model.dart';

/// Workout repository implementation
/// Implements workout data operations using local data source
class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutLocalDataSource localDataSource;
  final Uuid uuid = const Uuid();

  WorkoutRepositoryImpl(this.localDataSource);

  @override
  Future<List<Workout>> getWorkouts() async {
    final workoutModels = await localDataSource.getWorkouts();

    // Load exercises for each workout
    final workouts = <Workout>[];
    for (final workoutModel in workoutModels) {
      final exerciseModels =
          await localDataSource.getWorkoutExercises(workoutModel.id);
      final exercises = exerciseModels.map((e) => e.toEntity()).toList();
      workouts.add(workoutModel.toEntity(exercises));
    }

    return workouts;
  }

  @override
  Future<Workout?> getWorkoutById(String id) async {
    final workoutModel = await localDataSource.getWorkoutById(id);
    if (workoutModel == null) return null;

    final exerciseModels = await localDataSource.getWorkoutExercises(id);
    final exercises = exerciseModels.map((e) => e.toEntity()).toList();

    return workoutModel.toEntity(exercises);
  }

  @override
  Future<Workout> createWorkout(Workout workout) async {
    // Create workout model
    final workoutModel = WorkoutModel.fromEntity(workout);
    await localDataSource.createWorkout(workoutModel);

    // Create workout exercises
    final workoutExerciseModels = workout.exercises
        .map((e) => WorkoutExerciseModel.fromEntity(
              e,
              uuid.v4(),
              workout.id,
            ))
        .toList();

    await localDataSource.createWorkoutExercises(workoutExerciseModels);

    return workout;
  }

  @override
  Future<Workout> updateWorkout(Workout workout) async {
    // Update workout model
    final workoutModel = WorkoutModel.fromEntity(workout);
    await localDataSource.updateWorkout(workoutModel);

    // Update workout exercises
    final workoutExerciseModels = workout.exercises
        .map((e) => WorkoutExerciseModel.fromEntity(
              e,
              uuid.v4(),
              workout.id,
            ))
        .toList();

    await localDataSource.updateWorkoutExercises(
      workout.id,
      workoutExerciseModels,
    );

    return workout;
  }

  @override
  Future<void> deleteWorkout(String id) async {
    await localDataSource.deleteWorkout(id);
  }

  @override
  Future<List<Workout>> getTemplates() async {
    final workoutModels = await localDataSource.getTemplates();

    // Load exercises for each template
    final workouts = <Workout>[];
    for (final workoutModel in workoutModels) {
      final exerciseModels =
          await localDataSource.getWorkoutExercises(workoutModel.id);
      final exercises = exerciseModels.map((e) => e.toEntity()).toList();
      workouts.add(workoutModel.toEntity(exercises));
    }

    return workouts;
  }
}
