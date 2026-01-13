import '../../domain/entities/set_record.dart';

/// Model for SetRecord with JSON and database serialization
class SetRecordModel {
  final int setNumber;
  final int reps;
  final double weight;
  final int? rpe;
  final DateTime timestamp;

  const SetRecordModel({
    required this.setNumber,
    required this.reps,
    required this.weight,
    this.rpe,
    required this.timestamp,
  });

  /// Convert from entity
  factory SetRecordModel.fromEntity(SetRecord entity) {
    return SetRecordModel(
      setNumber: entity.setNumber,
      reps: entity.reps,
      weight: entity.weight,
      rpe: entity.rpe,
      timestamp: entity.timestamp,
    );
  }

  /// Convert to entity
  SetRecord toEntity() {
    return SetRecord(
      setNumber: setNumber,
      reps: reps,
      weight: weight,
      rpe: rpe,
      timestamp: timestamp,
    );
  }

  /// Convert from JSON
  factory SetRecordModel.fromJson(Map<String, dynamic> json) {
    return SetRecordModel(
      setNumber: json['setNumber'] as int,
      reps: json['reps'] as int,
      weight: (json['weight'] as num).toDouble(),
      rpe: json['rpe'] as int?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'setNumber': setNumber,
      'reps': reps,
      'weight': weight,
      'rpe': rpe,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  /// Convert from database map
  factory SetRecordModel.fromDatabase(Map<String, dynamic> map) {
    return SetRecordModel(
      setNumber: map['set_number'] as int,
      reps: map['reps'] as int,
      weight: (map['weight'] as num).toDouble(),
      rpe: map['rpe'] as int?,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  /// Convert to database map
  Map<String, dynamic> toDatabase({required String performedExerciseId}) {
    return {
      'performed_exercise_id': performedExerciseId,
      'set_number': setNumber,
      'reps': reps,
      'weight': weight,
      'rpe': rpe,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }
}
