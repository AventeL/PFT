import '../../domain/entities/performed_exercise.dart';
import 'set_record_model.dart';

/// Model for PerformedExercise with JSON and database serialization
class PerformedExerciseModel {
  final String exerciseId;
  final List<SetRecordModel> sets;
  final Duration? restTime;
  final int orderIndex;

  const PerformedExerciseModel({
    required this.exerciseId,
    required this.sets,
    this.restTime,
    required this.orderIndex,
  });

  /// Convert from entity
  factory PerformedExerciseModel.fromEntity(PerformedExercise entity) {
    return PerformedExerciseModel(
      exerciseId: entity.exerciseId,
      sets: entity.sets.map((set) => SetRecordModel.fromEntity(set)).toList(),
      restTime: entity.restTime,
      orderIndex: entity.orderIndex,
    );
  }

  /// Convert to entity
  PerformedExercise toEntity() {
    return PerformedExercise(
      exerciseId: exerciseId,
      sets: sets.map((set) => set.toEntity()).toList(),
      restTime: restTime,
      orderIndex: orderIndex,
    );
  }

  /// Convert from JSON
  factory PerformedExerciseModel.fromJson(Map<String, dynamic> json) {
    return PerformedExerciseModel(
      exerciseId: json['exerciseId'] as String,
      sets: (json['sets'] as List)
          .map((setJson) =>
              SetRecordModel.fromJson(setJson as Map<String, dynamic>))
          .toList(),
      restTime: json['restTime'] != null
          ? Duration(seconds: json['restTime'] as int)
          : null,
      orderIndex: json['orderIndex'] as int? ?? 0,
    );
  }

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'sets': sets.map((set) => set.toJson()).toList(),
      'restTime': restTime?.inSeconds,
      'orderIndex': orderIndex,
    };
  }

  /// Convert from database map (without sets - sets loaded separately)
  factory PerformedExerciseModel.fromDatabase(Map<String, dynamic> map) {
    return PerformedExerciseModel(
      exerciseId: map['exercise_id'] as String,
      sets: [], // Sets loaded separately
      restTime: map['rest_time'] != null
          ? Duration(seconds: map['rest_time'] as int)
          : null,
      orderIndex: map['order_index'] as int? ?? 0,
    );
  }

  /// Convert to database map
  Map<String, dynamic> toDatabase({required String sessionId}) {
    return {
      'session_id': sessionId,
      'exercise_id': exerciseId,
      'rest_time': restTime?.inSeconds,
      'order_index': orderIndex,
    };
  }

  /// Create a copy with sets
  PerformedExerciseModel copyWith({
    String? exerciseId,
    List<SetRecordModel>? sets,
    Duration? restTime,
    int? orderIndex,
  }) {
    return PerformedExerciseModel(
      exerciseId: exerciseId ?? this.exerciseId,
      sets: sets ?? this.sets,
      restTime: restTime ?? this.restTime,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}
