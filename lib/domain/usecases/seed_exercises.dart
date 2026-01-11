import '../../core/services/exercise_seed_service.dart';

/// Use case to seed exercises if database is empty
class SeedExercises {
  final ExerciseSeedService seedService;

  SeedExercises({required this.seedService});

  Future<void> call() async {
    await seedService.seedExercisesIfNeeded();
  }
}

