import 'package:equatable/equatable.dart';

import '../../../domain/entities/workout.dart';
import '../../../domain/entities/workout_session.dart';

/// Base class for ActiveWorkout events
abstract class ActiveWorkoutEvent extends Equatable {
  const ActiveWorkoutEvent();

  @override
  List<Object?> get props => [];
}

/// Event to start a new workout session
class StartWorkoutSession extends ActiveWorkoutEvent {
  final Workout? workout;

  const StartWorkoutSession({this.workout});

  @override
  List<Object?> get props => [workout];
}

/// Event to load the active session (for crash recovery)
class LoadActiveSession extends ActiveWorkoutEvent {
  const LoadActiveSession();
}

/// Event to update the current session
class UpdateSession extends ActiveWorkoutEvent {
  final WorkoutSession session;

  const UpdateSession(this.session);

  @override
  List<Object?> get props => [session];
}

/// Event to complete the current session
class CompleteSession extends ActiveWorkoutEvent {
  const CompleteSession();
}

/// Event to abandon the current session
class AbandonSession extends ActiveWorkoutEvent {
  const AbandonSession();
}
