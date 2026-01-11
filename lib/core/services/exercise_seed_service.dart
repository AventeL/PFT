import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../../data/models/exercise_model.dart';

/// Service to seed initial exercises from JSON file
class ExerciseSeedService {
  final ExerciseRepository repository;

  ExerciseSeedService({required this.repository});

  /// Load exercises from JSON asset and seed database
  Future<void> seedExercisesIfNeeded() async {
    try {
      // Check if exercises already seeded
      final hasExercises = await repository.hasExercises();
      if (hasExercises) {
        return; // Already seeded
      }

      // Load JSON from assets
      final jsonString = await rootBundle.loadString('assets/data/exercises.json');
      final List<dynamic> jsonList = json.decode(jsonString);

      // Parse to Exercise entities
      final exercises = jsonList
          .map((json) => ExerciseModel.fromJson(json as Map<String, dynamic>).toEntity())
          .toList();

      // Seed database
      await repository.seedExercises(exercises);
    } catch (e) {
      // Log error but don't crash the app
      throw Exception('Failed to seed exercises: $e');
    }
  }
}

