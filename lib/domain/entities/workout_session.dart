import 'package:equatable/equatable.dart';

import 'performed_exercise.dart';
import 'session_status.dart';

/// Represents a workout session (active, completed, or abandoned)
/// Contains session metadata and performed exercises
class WorkoutSession extends Equatable {
  /// Unique identifier (UUID)
  final String id;

  /// ID of the workout template used (null for quick start)
  final String? workoutId;

  /// When the session started
  final DateTime startTime;

  /// When the session ended (null if still active)
  final DateTime? endTime;

  /// Current status of the session
  final SessionStatus status;

  /// List of exercises performed in this session
  final List<PerformedExercise> performedExercises;

  /// Optional notes about the session
  final String? notes;

  const WorkoutSession({
    required this.id,
    this.workoutId,
    required this.startTime,
    this.endTime,
    required this.status,
    required this.performedExercises,
    this.notes,
  });

  @override
  List<Object?> get props => [
        id,
        workoutId,
        startTime,
        endTime,
        status,
        performedExercises,
        notes,
      ];

  /// Create a copy with modified fields
  WorkoutSession copyWith({
    String? id,
    String? workoutId,
    DateTime? startTime,
    DateTime? endTime,
    SessionStatus? status,
    List<PerformedExercise>? performedExercises,
    String? notes,
  }) {
    return WorkoutSession(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      performedExercises: performedExercises ?? this.performedExercises,
      notes: notes ?? this.notes,
    );
  }

  /// Calculate duration of the session
  Duration get duration {
    final end = endTime ?? DateTime.now();
    return end.difference(startTime);
  }

  /// Check if session is currently active
  bool get isActive => status == SessionStatus.active;
}
