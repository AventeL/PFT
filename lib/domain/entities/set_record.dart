import 'package:equatable/equatable.dart';

/// Represents a single set performed during a workout
/// Contains reps, weight, RPE, and timestamp
class SetRecord extends Equatable {
  /// Set number in the exercise (1, 2, 3, etc.)
  final int setNumber;

  /// Number of repetitions performed
  final int reps;

  /// Weight used in kg
  final double weight;

  /// Rate of Perceived Exertion (1-10), optional
  final int? rpe;

  /// Timestamp when the set was completed
  final DateTime timestamp;

  const SetRecord({
    required this.setNumber,
    required this.reps,
    required this.weight,
    this.rpe,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [setNumber, reps, weight, rpe, timestamp];

  /// Create a copy with modified fields
  SetRecord copyWith({
    int? setNumber,
    int? reps,
    double? weight,
    int? rpe,
    DateTime? timestamp,
  }) {
    return SetRecord(
      setNumber: setNumber ?? this.setNumber,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      rpe: rpe ?? this.rpe,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
