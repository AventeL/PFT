import 'package:equatable/equatable.dart';

/// WorkoutExercise entity - Domain layer
/// Represents an exercise within a workout with its configuration
class WorkoutExercise extends Equatable {
  final String exerciseId;
  final int order;
  final int targetSets;
  final Duration? restTime;

  const WorkoutExercise({
    required this.exerciseId,
    required this.order,
    required this.targetSets,
    this.restTime,
  });

  @override
  List<Object?> get props => [
        exerciseId,
        order,
        targetSets,
        restTime,
      ];

  /// Create a copy of this workout exercise with modified fields
  WorkoutExercise copyWith({
    String? exerciseId,
    int? order,
    int? targetSets,
    Duration? restTime,
  }) {
    return WorkoutExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
      targetSets: targetSets ?? this.targetSets,
      restTime: restTime ?? this.restTime,
    );
  }
}
