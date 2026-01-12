import '../../domain/entities/workout.dart';
import '../../domain/entities/workout_exercise.dart';

/// Workout model - Data layer
/// Handles serialization/deserialization for database and JSON
class WorkoutModel {
  final String id;
  final String name;
  final String? description;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isTemplate;

  const WorkoutModel({
    required this.id,
    required this.name,
    this.description,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.isTemplate = false,
  });

  /// Create WorkoutModel from JSON
  factory WorkoutModel.fromJson(Map<String, dynamic> json) {
    return WorkoutModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      isTemplate: json['isTemplate'] as bool? ?? false,
    );
  }

  /// Create WorkoutModel from database map
  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      notes: map['notes'] as String?,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at'] as int),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at'] as int),
      isTemplate: (map['is_template'] as int?) == 1,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'isTemplate': isTemplate,
    };
  }

  /// Convert to database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'notes': notes,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
      'is_template': isTemplate ? 1 : 0,
    };
  }

  /// Create WorkoutModel from Workout entity (without exercises)
  factory WorkoutModel.fromEntity(Workout workout) {
    return WorkoutModel(
      id: workout.id,
      name: workout.name,
      description: workout.description,
      notes: workout.notes,
      createdAt: workout.createdAt,
      updatedAt: workout.updatedAt,
      isTemplate: workout.isTemplate,
    );
  }

  /// Convert to Workout entity (requires exercises to be loaded separately)
  Workout toEntity(List<WorkoutExercise> exercises) {
    return Workout(
      id: id,
      name: name,
      description: description,
      exercises: exercises,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isTemplate: isTemplate,
    );
  }
}
