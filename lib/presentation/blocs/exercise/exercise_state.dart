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
    this.selectedMuscleGroups = const {},
    this.selectedCategories = const {},
    this.selectedEquipmentTypes = const {},
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
  ExercisesLoaded copyWith({
    List<Exercise>? allExercises,
    List<Exercise>? filteredExercises,
    String? searchQuery,
    Set<MuscleGroup>? selectedMuscleGroups,
    Set<ExerciseCategory>? selectedCategories,
    Set<EquipmentType>? selectedEquipmentTypes,
  }) {
    return ExercisesLoaded(
      allExercises: allExercises ?? this.allExercises,
      filteredExercises: filteredExercises ?? this.filteredExercises,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedMuscleGroups: selectedMuscleGroups ?? this.selectedMuscleGroups,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedEquipmentTypes:
          selectedEquipmentTypes ?? this.selectedEquipmentTypes,
    );
  }

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
