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
    // Check if templates already exist
    final existingWorkouts = await repository.getWorkouts();
    final existingTemplates =
        existingWorkouts.where((w) => w.isTemplate).toList();

    if (existingTemplates.isNotEmpty) {
      // Templates already seeded, skip
      return;
    }

    // Load templates from asset
    final templates = await seedService.loadTemplatesFromAsset();

    // Save all templates to database
    for (final template in templates) {
      await repository.createWorkout(template);
    }
  }
}
