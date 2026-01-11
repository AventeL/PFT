import 'package:equatable/equatable.dart';

import '../../../domain/entities/exercise.dart';
import '../../../domain/entities/exercise_enums.dart';

/// Base class for Exercise events
abstract class ExerciseEvent extends Equatable {
  const ExerciseEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load all exercises
class LoadExercises extends ExerciseEvent {
  const LoadExercises();
}

/// Event to seed exercises if database is empty
class SeedExercisesIfNeeded extends ExerciseEvent {
  const SeedExercisesIfNeeded();
}

/// Event to create a custom exercise
class CreateCustomExerciseEvent extends ExerciseEvent {
  final Exercise exercise;

  const CreateCustomExerciseEvent(this.exercise);

  @override
  List<Object?> get props => [exercise];
}

/// Event to delete a custom exercise
class DeleteCustomExerciseEvent extends ExerciseEvent {
  final String exerciseId;

  const DeleteCustomExerciseEvent(this.exerciseId);

  @override
  List<Object?> get props => [exerciseId];
}

/// Event to search exercises by query
class SearchExercisesEvent extends ExerciseEvent {
  final String query;

  const SearchExercisesEvent(this.query);

  @override
  List<Object?> get props => [query];
}

/// Event to filter exercises by muscle groups
class FilterByMuscleGroupsEvent extends ExerciseEvent {
  final Set<MuscleGroup> muscleGroups;

  const FilterByMuscleGroupsEvent(this.muscleGroups);

  @override
  List<Object?> get props => [muscleGroups];
}

/// Event to filter exercises by categories
class FilterByCategoriesEvent extends ExerciseEvent {
  final Set<ExerciseCategory> categories;

  const FilterByCategoriesEvent(this.categories);

  @override
  List<Object?> get props => [categories];
}

/// Event to filter exercises by equipment types
class FilterByEquipmentTypesEvent extends ExerciseEvent {
  final Set<EquipmentType> equipmentTypes;

  const FilterByEquipmentTypesEvent(this.equipmentTypes);

  @override
  List<Object?> get props => [equipmentTypes];
}

/// Event to clear all filters
class ClearFiltersEvent extends ExerciseEvent {
  const ClearFiltersEvent();
}
