import 'package:uuid/uuid.dart';
import '../entities/workout.dart';
import '../repositories/workout_repository.dart';

/// Use case to import (clone) a template as a new editable workout
class ImportTemplate {
  final WorkoutRepository repository;
  final Uuid uuid = const Uuid();

  ImportTemplate({required this.repository});

  Future<Workout> call(String templateId) async {
    // Get the template
    final allWorkouts = await repository.getWorkouts();
    final template = allWorkouts.firstWhere(
      (w) => w.id == templateId && w.isTemplate,
      orElse: () => throw ArgumentError('Template not found: $templateId'),
    );

    // Create a new workout from the template
    final now = DateTime.now();
    final importedWorkout = Workout(
      id: uuid.v4(),
      name: template.name, // Keep same name, user can edit
      description: template.description,
      exercises: template.exercises, // Copy exercises list
      notes: template.notes,
      createdAt: now,
      updatedAt: now,
      isTemplate: false, // Important: not a template anymore
    );

    // Save the new workout
    return await repository.createWorkout(importedWorkout);
  }
}
