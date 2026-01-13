import 'package:equatable/equatable.dart';

import '../../../domain/entities/workout_session.dart';

/// Base class for ActiveWorkout states
abstract class ActiveWorkoutState extends Equatable {
  const ActiveWorkoutState();

  @override
  List<Object?> get props => [];
}

/// Initial state - no active session
class ActiveWorkoutInitial extends ActiveWorkoutState {
  const ActiveWorkoutInitial();
}

/// Loading state - starting or loading a session
class ActiveWorkoutLoading extends ActiveWorkoutState {
  const ActiveWorkoutLoading();
}

/// Active state - session in progress
class ActiveWorkoutActive extends ActiveWorkoutState {
  final WorkoutSession session;

  const ActiveWorkoutActive(this.session);

  @override
  List<Object?> get props => [session];
}

/// Completed state - session finished successfully
class ActiveWorkoutCompleted extends ActiveWorkoutState {
  final WorkoutSession session;

  const ActiveWorkoutCompleted(this.session);

  @override
  List<Object?> get props => [session];
}

/// Error state
class ActiveWorkoutError extends ActiveWorkoutState {
  final String message;

  const ActiveWorkoutError(this.message);

  @override
  List<Object?> get props => [message];
}
