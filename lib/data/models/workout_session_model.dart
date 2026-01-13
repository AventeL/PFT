import '../../domain/entities/session_status.dart';
import '../../domain/entities/workout_session.dart';
import 'performed_exercise_model.dart';

/// Model for WorkoutSession with JSON and database serialization
class WorkoutSessionModel {
  final String id;
  final String? workoutId;
  final DateTime startTime;
  final DateTime? endTime;
  final SessionStatus status;
  final List<PerformedExerciseModel> performedExercises;
  final String? notes;

  const WorkoutSessionModel({
    required this.id,
    this.workoutId,
    required this.startTime,
    this.endTime,
    required this.status,
    required this.performedExercises,
    this.notes,
  });

  /// Convert from entity
  factory WorkoutSessionModel.fromEntity(WorkoutSession entity) {
    return WorkoutSessionModel(
      id: entity.id,
      workoutId: entity.workoutId,
      startTime: entity.startTime,
      endTime: entity.endTime,
      status: entity.status,
      performedExercises: entity.performedExercises
          .map((pe) => PerformedExerciseModel.fromEntity(pe))
          .toList(),
      notes: entity.notes,
    );
  }

  /// Convert to entity
  WorkoutSession toEntity() {
    return WorkoutSession(
      id: id,
      workoutId: workoutId,
      startTime: startTime,
      endTime: endTime,
      status: status,
      performedExercises:
          performedExercises.map((pe) => pe.toEntity()).toList(),
      notes: notes,
    );
  }

  /// Convert from JSON
  factory WorkoutSessionModel.fromJson(Map<String, dynamic> json) {
    return WorkoutSessionModel(
      id: json['id'] as String,
      workoutId: json['workoutId'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: json['endTime'] != null
          ? DateTime.parse(json['endTime'] as String)
          : null,
      status: SessionStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => SessionStatus.abandoned,
      ),
      performedExercises: (json['performedExercises'] as List)
          .map((pe) =>
              PerformedExerciseModel.fromJson(pe as Map<String, dynamic>))
          .toList(),
      notes: json['notes'] as String?,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'workoutId': workoutId,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'status': status.name,
      'performedExercises':
          performedExercises.map((pe) => pe.toJson()).toList(),
      'notes': notes,
    };
  }

  /// Convert from database map (without performed exercises - loaded separately)
  factory WorkoutSessionModel.fromDatabase(Map<String, dynamic> map) {
    return WorkoutSessionModel(
      id: map['id'] as String,
      workoutId: map['workout_id'] as String?,
      startTime: DateTime.fromMillisecondsSinceEpoch(map['start_time'] as int),
      endTime: map['end_time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['end_time'] as int)
          : null,
      status: SessionStatus.fromDatabase(map['status'] as String),
      performedExercises: [], // Loaded separately
      notes: map['notes'] as String?,
    );
  }

  /// Convert to database map
  Map<String, dynamic> toDatabase() {
    return {
      'id': id,
      'workout_id': workoutId,
      'start_time': startTime.millisecondsSinceEpoch,
      'end_time': endTime?.millisecondsSinceEpoch,
      'status': status.toDatabase(),
      'notes': notes,
    };
  }

  /// Create a copy with performed exercises
  WorkoutSessionModel copyWith({
    String? id,
    String? workoutId,
    DateTime? startTime,
    DateTime? endTime,
    SessionStatus? status,
    List<PerformedExerciseModel>? performedExercises,
    String? notes,
  }) {
    return WorkoutSessionModel(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      performedExercises: performedExercises ?? this.performedExercises,
      notes: notes ?? this.notes,
    );
  }
}
