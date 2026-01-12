import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/usecases/create_workout.dart';
import '../../../domain/usecases/delete_workout.dart';
import '../../../domain/usecases/get_workouts.dart';
import '../../../domain/usecases/update_workout.dart';
import 'workout_event.dart';
import 'workout_state.dart';

/// WorkoutBloc - Manages workout state
class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  final GetWorkouts getWorkouts;
  final CreateWorkout createWorkout;
  final UpdateWorkout updateWorkout;
  final DeleteWorkout deleteWorkout;
  final Uuid uuid = const Uuid();

  WorkoutBloc({
    required this.getWorkouts,
    required this.createWorkout,
    required this.updateWorkout,
    required this.deleteWorkout,
  }) : super(const WorkoutInitial()) {
    on<LoadWorkouts>(_onLoadWorkouts);
    on<CreateWorkoutEvent>(_onCreateWorkout);
    on<UpdateWorkoutEvent>(_onUpdateWorkout);
    on<DeleteWorkoutEvent>(_onDeleteWorkout);
    on<DuplicateWorkoutEvent>(_onDuplicateWorkout);
    on<LoadTemplates>(_onLoadTemplates);
  }

  Future<void> _onLoadWorkouts(
    LoadWorkouts event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      emit(const WorkoutLoading());
      final workouts = await getWorkouts();
      emit(WorkoutsLoaded(workouts));
    } catch (e) {
      emit(WorkoutError('Failed to load workouts: ${e.toString()}'));
    }
  }

  Future<void> _onCreateWorkout(
    CreateWorkoutEvent event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      emit(const WorkoutLoading());
      final workout = await createWorkout(event.workout);
      emit(WorkoutCreated(workout));
      // Reload workouts after creation
      add(const LoadWorkouts());
    } catch (e) {
      emit(WorkoutError('Failed to create workout: ${e.toString()}'));
    }
  }

  Future<void> _onUpdateWorkout(
    UpdateWorkoutEvent event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      emit(const WorkoutLoading());
      final workout = await updateWorkout(event.workout);
      emit(WorkoutUpdated(workout));
      // Reload workouts after update
      add(const LoadWorkouts());
    } catch (e) {
      emit(WorkoutError('Failed to update workout: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteWorkout(
    DeleteWorkoutEvent event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      emit(const WorkoutLoading());
      await deleteWorkout(event.workoutId);
      emit(WorkoutDeleted(event.workoutId));
      // Reload workouts after deletion
      add(const LoadWorkouts());
    } catch (e) {
      emit(WorkoutError('Failed to delete workout: ${e.toString()}'));
    }
  }

  Future<void> _onDuplicateWorkout(
    DuplicateWorkoutEvent event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      emit(const WorkoutLoading());
      // Create a copy with new ID and updated name
      final duplicatedWorkout = event.workout.copyWith(
        id: uuid.v4(),
        name: '${event.workout.name} (Copy)',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      final workout = await createWorkout(duplicatedWorkout);
      emit(WorkoutCreated(workout));
      // Reload workouts after duplication
      add(const LoadWorkouts());
    } catch (e) {
      emit(WorkoutError('Failed to duplicate workout: ${e.toString()}'));
    }
  }

  Future<void> _onLoadTemplates(
    LoadTemplates event,
    Emitter<WorkoutState> emit,
  ) async {
    try {
      emit(const WorkoutLoading());
      final workouts = await getWorkouts();
      final templates = workouts.where((w) => w.isTemplate).toList();
      emit(TemplatesLoaded(templates));
    } catch (e) {
      emit(WorkoutError('Failed to load templates: ${e.toString()}'));
    }
  }
}
