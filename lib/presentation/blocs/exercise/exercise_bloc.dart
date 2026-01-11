import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/exercise_repository.dart';
import '../../../domain/usecases/create_custom_exercise.dart';
import '../../../domain/usecases/get_exercises.dart';
import '../../../domain/usecases/search_exercises.dart';
import '../../../domain/usecases/seed_exercises.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';

/// BLoC for managing exercise state
class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final GetExercises getExercises;
  final CreateCustomExercise createCustomExercise;
  final SeedExercises seedExercises;
  final SearchExercises searchExercises;
  final ExerciseRepository repository;

  ExerciseBloc({
    required this.getExercises,
    required this.createCustomExercise,
    required this.seedExercises,
    required this.searchExercises,
    required this.repository,
  }) : super(const ExerciseInitial()) {
    on<SeedExercisesIfNeeded>(_onSeedExercisesIfNeeded);
    on<LoadExercises>(_onLoadExercises);
    on<CreateCustomExerciseEvent>(_onCreateCustomExercise);
    on<DeleteCustomExerciseEvent>(_onDeleteCustomExercise);
    on<SearchExercisesEvent>(_onSearchExercises);
    on<FilterByMuscleGroupsEvent>(_onFilterByMuscleGroups);
    on<FilterByCategoriesEvent>(_onFilterByCategories);
    on<FilterByEquipmentTypesEvent>(_onFilterByEquipmentTypes);
    on<ClearFiltersEvent>(_onClearFilters);
  }

  /// Handle seed exercises event
  Future<void> _onSeedExercisesIfNeeded(
    SeedExercisesIfNeeded event,
    Emitter<ExerciseState> emit,
  ) async {
    try {
      emit(const ExerciseLoading());
      await seedExercises();
      // After seeding, load exercises
      final exercises = await getExercises();
      emit(ExercisesLoaded(allExercises: exercises));
    } catch (e) {
      emit(ExerciseError('Failed to seed exercises: ${e.toString()}'));
    }
  }

  /// Handle load exercises event
  Future<void> _onLoadExercises(
    LoadExercises event,
    Emitter<ExerciseState> emit,
  ) async {
    try {
      emit(const ExerciseLoading());
      final exercises = await getExercises();
      emit(ExercisesLoaded(allExercises: exercises));
    } catch (e) {
      emit(ExerciseError('Failed to load exercises: ${e.toString()}'));
    }
  }

  /// Handle create custom exercise event
  Future<void> _onCreateCustomExercise(
    CreateCustomExerciseEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    try {
      await repository.createExercise(event.exercise);
      // Reload exercises after creation
      final exercises = await getExercises();
      emit(ExercisesLoaded(allExercises: exercises));
    } catch (e) {
      emit(ExerciseError('Failed to create exercise: ${e.toString()}'));
    }
  }

  /// Handle delete custom exercise event
  Future<void> _onDeleteCustomExercise(
    DeleteCustomExerciseEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    try {
      await repository.deleteExercise(event.exerciseId);
      // Reload exercises after deletion
      final exercises = await getExercises();
      emit(ExercisesLoaded(allExercises: exercises));
    } catch (e) {
      emit(ExerciseError('Failed to delete exercise: ${e.toString()}'));
    }
  }

  /// Handle search exercises event
  Future<void> _onSearchExercises(
    SearchExercisesEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    if (state is! ExercisesLoaded) return;

    final currentState = state as ExercisesLoaded;

    try {
      final filtered = await searchExercises(
        query: event.query,
        muscleGroups: currentState.selectedMuscleGroups,
        categories: currentState.selectedCategories,
        equipmentTypes: currentState.selectedEquipmentTypes,
      );

      emit(currentState.copyWith(
        searchQuery: event.query,
        filteredExercises: filtered,
      ));
    } catch (e) {
      emit(ExerciseError('Failed to search exercises: ${e.toString()}'));
    }
  }

  /// Handle filter by muscle groups event
  Future<void> _onFilterByMuscleGroups(
    FilterByMuscleGroupsEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    if (state is! ExercisesLoaded) return;

    final currentState = state as ExercisesLoaded;

    try {
      final filtered = await searchExercises(
        query: currentState.searchQuery,
        muscleGroups: event.muscleGroups,
        categories: currentState.selectedCategories,
        equipmentTypes: currentState.selectedEquipmentTypes,
      );

      emit(currentState.copyWith(
        selectedMuscleGroups: event.muscleGroups,
        filteredExercises: filtered,
      ));
    } catch (e) {
      emit(ExerciseError('Failed to filter exercises: ${e.toString()}'));
    }
  }

  /// Handle filter by categories event
  Future<void> _onFilterByCategories(
    FilterByCategoriesEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    if (state is! ExercisesLoaded) return;

    final currentState = state as ExercisesLoaded;

    try {
      final filtered = await searchExercises(
        query: currentState.searchQuery,
        muscleGroups: currentState.selectedMuscleGroups,
        categories: event.categories,
        equipmentTypes: currentState.selectedEquipmentTypes,
      );

      emit(currentState.copyWith(
        selectedCategories: event.categories,
        filteredExercises: filtered,
      ));
    } catch (e) {
      emit(ExerciseError('Failed to filter exercises: ${e.toString()}'));
    }
  }

  /// Handle filter by equipment types event
  Future<void> _onFilterByEquipmentTypes(
    FilterByEquipmentTypesEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    if (state is! ExercisesLoaded) return;

    final currentState = state as ExercisesLoaded;

    try {
      final filtered = await searchExercises(
        query: currentState.searchQuery,
        muscleGroups: currentState.selectedMuscleGroups,
        categories: currentState.selectedCategories,
        equipmentTypes: event.equipmentTypes,
      );

      emit(currentState.copyWith(
        selectedEquipmentTypes: event.equipmentTypes,
        filteredExercises: filtered,
      ));
    } catch (e) {
      emit(ExerciseError('Failed to filter exercises: ${e.toString()}'));
    }
  }

  /// Handle clear filters event
  Future<void> _onClearFilters(
    ClearFiltersEvent event,
    Emitter<ExerciseState> emit,
  ) async {
    if (state is! ExercisesLoaded) return;

    final currentState = state as ExercisesLoaded;

    emit(currentState.copyWith(
      searchQuery: '',
      selectedMuscleGroups: const {},
      selectedCategories: const {},
      selectedEquipmentTypes: const {},
      filteredExercises: currentState.allExercises,
    ));
  }
}
