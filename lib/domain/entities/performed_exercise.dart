import 'package:equatable/equatable.dart';

import 'set_record.dart';

/// Represents an exercise performed during a workout session
/// Contains the exercise ID, sets performed, and rest time
class PerformedExercise extends Equatable {
  /// ID of the exercise from the exercise database
  final String exerciseId;

  /// List of sets performed for this exercise
  final List<SetRecord> sets;

  /// Rest time between sets (optional)
  final Duration? restTime;

  /// Order of the exercise in the session
  final int orderIndex;

  const PerformedExercise({
    required this.exerciseId,
    required this.sets,
    this.restTime,
    required this.orderIndex,
  });

  @override
  List<Object?> get props => [exerciseId, sets, restTime, orderIndex];

  /// Create a copy with modified fields
  PerformedExercise copyWith({
    String? exerciseId,
    List<SetRecord>? sets,
    Duration? restTime,
    int? orderIndex,
  }) {
    return PerformedExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      sets: sets ?? this.sets,
      restTime: restTime ?? this.restTime,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}
