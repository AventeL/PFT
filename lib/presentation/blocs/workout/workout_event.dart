import 'package:equatable/equatable.dart';
import '../../../domain/entities/workout.dart';

/// Base class for Workout events
abstract class WorkoutEvent extends Equatable {
  const WorkoutEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all workouts
class LoadWorkouts extends WorkoutEvent {
  const LoadWorkouts();
}

/// Event to create a new workout
class CreateWorkoutEvent extends WorkoutEvent {
  final Workout workout;

  const CreateWorkoutEvent(this.workout);

  @override
  List<Object?> get props => [workout];
}

/// Event to update an existing workout
class UpdateWorkoutEvent extends WorkoutEvent {
  final Workout workout;

  const UpdateWorkoutEvent(this.workout);

  @override
  List<Object?> get props => [workout];
}

/// Event to delete a workout
class DeleteWorkoutEvent extends WorkoutEvent {
  final String workoutId;

  const DeleteWorkoutEvent(this.workoutId);

  @override
  List<Object?> get props => [workoutId];
}

/// Event to duplicate a workout
class DuplicateWorkoutEvent extends WorkoutEvent {
  final Workout workout;

  const DuplicateWorkoutEvent(this.workout);

  @override
  List<Object?> get props => [workout];
}

/// Event to load workout templates
class LoadTemplates extends WorkoutEvent {
  const LoadTemplates();
}

/// Event to import a template as a new workout
class ImportTemplateEvent extends WorkoutEvent {
  final String templateId;

  const ImportTemplateEvent(this.templateId);

  @override
  List<Object?> get props => [templateId];
}

/// Event to seed templates if not already seeded
class SeedTemplatesIfNeeded extends WorkoutEvent {
  const SeedTemplatesIfNeeded();
}
