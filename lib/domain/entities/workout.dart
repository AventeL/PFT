import 'package:equatable/equatable.dart';
import 'workout_exercise.dart';

/// Workout entity - Domain layer
/// Represents a workout plan with exercises
class Workout extends Equatable {
  final String id;
  final String name;
  final String? description;
  final List<WorkoutExercise> exercises;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isTemplate;

  const Workout({
    required this.id,
    required this.name,
    this.description,
    required this.exercises,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.isTemplate = false,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        exercises,
        notes,
        createdAt,
        updatedAt,
        isTemplate,
      ];

  /// Create a copy of this workout with modified fields
  Workout copyWith({
    String? id,
    String? name,
    String? description,
    List<WorkoutExercise>? exercises,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isTemplate,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      exercises: exercises ?? this.exercises,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isTemplate: isTemplate ?? this.isTemplate,
    );
  }
}
