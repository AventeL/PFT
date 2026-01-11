import '../entities/exercise.dart';
import '../entities/exercise_enums.dart';
import '../repositories/exercise_repository.dart';

/// Use case for searching and filtering exercises
///
/// Implements search by name and multi-filter logic:
/// - Between filter types: AND logic (e.g., Chest AND Compound)
/// - Within filter type: OR logic (e.g., Chest OR Back)
class SearchExercises {
  final ExerciseRepository repository;

  SearchExercises(this.repository);

  /// Execute search and filter
  ///
  /// [query] - Search query for exercise name (case-insensitive, partial match)
  /// [muscleGroups] - Filter by muscle groups (OR within, AND with other filters)
  /// [categories] - Filter by exercise categories (OR within, AND with other filters)
  /// [equipmentTypes] - Filter by equipment types (OR within, AND with other filters)
  ///
  /// Returns filtered list of exercises
  Future<List<Exercise>> call({
    String? query,
    Set<MuscleGroup>? muscleGroups,
    Set<ExerciseCategory>? categories,
    Set<EquipmentType>? equipmentTypes,
  }) async {
    // Get all exercises from repository
    final allExercises = await repository.getExercises();

    // Apply filters
    var filtered = allExercises;

    // Filter by search query (case-insensitive, partial match)
    if (query != null && query.isNotEmpty) {
      final lowerQuery = query.toLowerCase();
      filtered = filtered.where((exercise) {
        return exercise.name.toLowerCase().contains(lowerQuery);
      }).toList();
    }

    // Filter by muscle groups (OR logic)
    if (muscleGroups != null && muscleGroups.isNotEmpty) {
      filtered = filtered.where((exercise) {
        return muscleGroups.contains(exercise.muscleGroup);
      }).toList();
    }

    // Filter by categories (OR logic)
    if (categories != null && categories.isNotEmpty) {
      filtered = filtered.where((exercise) {
        return categories.contains(exercise.category);
      }).toList();
    }

    // Filter by equipment types (OR logic)
    if (equipmentTypes != null && equipmentTypes.isNotEmpty) {
      filtered = filtered.where((exercise) {
        return equipmentTypes.contains(exercise.equipmentType);
      }).toList();
    }

    return filtered;
  }
}
