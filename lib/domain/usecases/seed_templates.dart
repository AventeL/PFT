import '../../core/services/workout_template_seed_service.dart';
import '../repositories/workout_repository.dart';

/// Use case to seed workout templates if not already seeded
class SeedTemplates {
  final WorkoutRepository repository;
  final WorkoutTemplateSeedService seedService;

  SeedTemplates({
    required this.repository,
    required this.seedService,
  });

  Future<void> call() async {
    // Load templates from asset
    final templates = await seedService.loadTemplatesFromAsset();

    // Save all templates to database
    // The repository uses ConflictAlgorithm.replace, so missing templates will be added
    // and existing ones will be updated.
    for (final template in templates) {
      await repository.createWorkout(template);
    }
  }
}
