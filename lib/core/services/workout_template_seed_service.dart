import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/workout.dart';
import '../../domain/entities/workout_exercise.dart';

/// Service to seed workout templates from JSON asset
class WorkoutTemplateSeedService {
  static const String _templatesAssetPath =
      'assets/data/workout_templates.json';

  /// Load and parse templates from JSON asset
  Future<List<Workout>> loadTemplatesFromAsset() async {
    try {
      final jsonString = await rootBundle.loadString(_templatesAssetPath);
      final jsonData = json.decode(jsonString) as Map<String, dynamic>;
      final templatesJson = jsonData['templates'] as List<dynamic>;

      return templatesJson.map((templateJson) {
        final exercisesJson = templateJson['exercises'] as List<dynamic>;
        final exercises = exercisesJson.map((exerciseJson) {
          return WorkoutExercise(
            exerciseId: exerciseJson['exerciseId'] as String,
            order: exerciseJson['orderIndex'] as int,
            targetSets: exerciseJson['targetSets'] as int,
            restTime: exerciseJson['restTime'] != null
                ? Duration(seconds: exerciseJson['restTime'] as int)
                : null,
          );
        }).toList();

        return Workout(
          id: templateJson['id'] as String,
          name: templateJson['name'] as String,
          description: templateJson['description'] as String?,
          exercises: exercises,
          notes: null,
          createdAt: DateTime.parse('2026-01-01T00:00:00.000Z'),
          updatedAt: DateTime.parse('2026-01-01T00:00:00.000Z'),
          isTemplate: true,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to load workout templates: $e');
    }
  }
}
