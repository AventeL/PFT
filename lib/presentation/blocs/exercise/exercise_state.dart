import 'package:equatable/equatable.dart';

import '../../../domain/entities/exercise.dart';
import '../../../domain/entities/exercise_enums.dart';

/// Base class for Exercise states
abstract class ExerciseState extends Equatable {
  const ExerciseState();

  @override
  List<Object?> get props => [];
}

/// Initial state before any action
class ExerciseInitial extends ExerciseState {
  const ExerciseInitial();
}

/// Loading state
class ExerciseLoading extends ExerciseState {
  const ExerciseLoading();
}

/// State when exercises are successfully loaded
class ExercisesLoaded extends ExerciseState {
  final List<Exercise> allExercises;
  final List<Exercise> filteredExercises;
  final String searchQuery;
  final Set<MuscleGroup> selectedMuscleGroups;
  final Set<ExerciseCategory> selectedCategories;
  final Set<EquipmentType> selectedEquipmentTypes;

  const ExercisesLoaded({
    required this.allExercises,
    List<Exercise>? filteredExercises,
    this.searchQuery = '',
    this.selectedMuscleGroups = const <MuscleGroup>{},
    this.selectedCategories = const <ExerciseCategory>{},
    this.selectedEquipmentTypes = const <EquipmentType>{},
  }) : filteredExercises = filteredExercises ?? allExercises;

  /// Convenience getter for backward compatibility
  List<Exercise> get exercises => filteredExercises;

  /// Check if any filters are active
  bool get hasActiveFilters =>
      searchQuery.isNotEmpty ||
      selectedMuscleGroups.isNotEmpty ||
      selectedCategories.isNotEmpty ||
      selectedEquipmentTypes.isNotEmpty;

  /// Get the count of filtered results
  int get resultCount => filteredExercises.length;

  /// Copy with method for updating state
  ///
  /// Uses a sentinel pattern to distinguish between "not provided" and "explicitly null/empty".
  /// If a parameter is not provided, the current value is preserved.
  /// If a parameter is provided (even if empty), the new value is used.
  ExercisesLoaded copyWith({
    Object? allExercises = _unset,
    Object? filteredExercises = _unset,
    Object? searchQuery = _unset,
    Object? selectedMuscleGroups = _unset,
    Object? selectedCategories = _unset,
    Object? selectedEquipmentTypes = _unset,
  }) {
    return ExercisesLoaded(
      allExercises: identical(allExercises, _unset)
          ? this.allExercises
          : allExercises as List<Exercise>,
      filteredExercises: identical(filteredExercises, _unset)
          ? this.filteredExercises
          : filteredExercises as List<Exercise>,
      searchQuery: identical(searchQuery, _unset)
          ? this.searchQuery
          : searchQuery as String,
      selectedMuscleGroups: identical(selectedMuscleGroups, _unset)
          ? this.selectedMuscleGroups
          : selectedMuscleGroups as Set<MuscleGroup>,
      selectedCategories: identical(selectedCategories, _unset)
          ? this.selectedCategories
          : selectedCategories as Set<ExerciseCategory>,
      selectedEquipmentTypes: identical(selectedEquipmentTypes, _unset)
          ? this.selectedEquipmentTypes
          : selectedEquipmentTypes as Set<EquipmentType>,
    );
  }

  /// Sentinel value for copyWith
  static const _Unset _unset = _Unset();

  @override
  List<Object?> get props => [
        allExercises,
        filteredExercises,
        searchQuery,
        selectedMuscleGroups,
        selectedCategories,
        selectedEquipmentTypes,
      ];
}

/// Error state
class ExerciseError extends ExerciseState {
  final String message;

  const ExerciseError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Sentinel class for copyWith method
/// Used to distinguish between "parameter not provided" vs "parameter set to null/empty"
class _Unset {
  const _Unset();
}
