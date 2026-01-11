import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/get_exercises.dart';
import '../../../domain/usecases/create_custom_exercise.dart';
import '../../../domain/usecases/seed_exercises.dart';
import '../../../domain/repositories/exercise_repository.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';

/// BLoC for managing exercise state
class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final GetExercises getExercises;
  final CreateCustomExercise createCustomExercise;
  final SeedExercises seedExercises;
  final ExerciseRepository repository;

  ExerciseBloc({
    required this.getExercises,
    required this.createCustomExercise,
    required this.seedExercises,
    required this.repository,
  }) : super(const ExerciseInitial()) {
    on<SeedExercisesIfNeeded>(_onSeedExercisesIfNeeded);
    on<LoadExercises>(_onLoadExercises);
    on<CreateCustomExerciseEvent>(_onCreateCustomExercise);
    on<DeleteCustomExerciseEvent>(_onDeleteCustomExercise);
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
      emit(ExercisesLoaded(exercises));
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
      emit(ExercisesLoaded(exercises));
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
      emit(ExercisesLoaded(exercises));
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
      emit(ExercisesLoaded(exercises));
    } catch (e) {
      emit(ExerciseError('Failed to delete exercise: ${e.toString()}'));
    }
  }
}

