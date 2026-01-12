import 'package:equatable/equatable.dart';
import '../../../domain/entities/workout.dart';

/// Base class for Workout states
abstract class WorkoutState extends Equatable {
  const WorkoutState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action
class WorkoutInitial extends WorkoutState {
  const WorkoutInitial();
}

/// Loading state
class WorkoutLoading extends WorkoutState {
  const WorkoutLoading();
}

/// State when workouts are successfully loaded
class WorkoutsLoaded extends WorkoutState {
  final List<Workout> workouts;

  const WorkoutsLoaded(this.workouts);

  @override
  List<Object?> get props => [workouts];
}

/// State when a workout is successfully created
class WorkoutCreated extends WorkoutState {
  final Workout workout;

  const WorkoutCreated(this.workout);

  @override
  List<Object?> get props => [workout];
}

/// State when a workout is successfully updated
class WorkoutUpdated extends WorkoutState {
  final Workout workout;

  const WorkoutUpdated(this.workout);

  @override
  List<Object?> get props => [workout];
}

/// State when a workout is successfully deleted
class WorkoutDeleted extends WorkoutState {
  final String workoutId;

  const WorkoutDeleted(this.workoutId);

  @override
  List<Object?> get props => [workoutId];
}

/// State when templates are loaded
class TemplatesLoaded extends WorkoutState {
  final List<Workout> templates;

  const TemplatesLoaded(this.templates);

  @override
  List<Object?> get props => [templates];
}

/// Error state
class WorkoutError extends WorkoutState {
  final String message;

  const WorkoutError(this.message);

  @override
  List<Object?> get props => [message];
}
