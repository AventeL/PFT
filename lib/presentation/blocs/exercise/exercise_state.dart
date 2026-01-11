import 'package:equatable/equatable.dart';
import '../../../domain/entities/exercise.dart';

/// Base class for Exercise states
abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action
class ExerciseInitial extends ExerciseState {
  const ExerciseInitial();
}

/// Loading state
class ExerciseLoading extends ExerciseState {
  const ExerciseLoading();
}

/// State when exercises are successfully loaded
class ExercisesLoaded extends ExerciseState {
  final List<Exercise> exercises;

  const ExercisesLoaded(this.exercises);

  @override
  List<Object?> get props => [exercises];
}

/// Error state
class ExerciseError extends ExerciseState {
  final String message;

  const ExerciseError(this.message);

  @override
  List<Object?> get props => [message];
}

