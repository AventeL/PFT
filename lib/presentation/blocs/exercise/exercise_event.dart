import 'package:equatable/equatable.dart';
import '../../../domain/entities/exercise.dart';

/// Base class for Exercise events
abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all exercises
class LoadExercises extends ExerciseEvent {
  const LoadExercises();
}

/// Event to seed exercises if database is empty
class SeedExercisesIfNeeded extends ExerciseEvent {
  const SeedExercisesIfNeeded();
}

/// Event to create a custom exercise
class CreateCustomExerciseEvent extends ExerciseEvent {
  final Exercise exercise;

  const CreateCustomExerciseEvent(this.exercise);

  @override
  List<Object?> get props => [exercise];
}

/// Event to delete a custom exercise
class DeleteCustomExerciseEvent extends ExerciseEvent {
  final String exerciseId;

  const DeleteCustomExerciseEvent(this.exerciseId);

  @override
  List<Object?> get props => [exerciseId];
}

