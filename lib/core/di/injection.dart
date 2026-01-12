import 'package:get_it/get_it.dart';

import '../../data/database/database_helper.dart';
import '../../data/datasources/local/exercise_local_datasource.dart';
import '../../data/datasources/local/exercise_local_datasource_impl.dart';
import '../../data/datasources/local/workout_local_datasource.dart';
import '../../data/datasources/local/workout_local_datasource_impl.dart';
import '../../data/repositories/exercise_repository_impl.dart';
import '../../data/repositories/workout_repository_impl.dart';
import '../../domain/repositories/exercise_repository.dart';
import '../../domain/repositories/workout_repository.dart';
import '../../domain/usecases/create_custom_exercise.dart';
import '../../domain/usecases/create_workout.dart';
import '../../domain/usecases/delete_workout.dart';
import '../../domain/usecases/get_exercise_by_id.dart';
import '../../domain/usecases/get_exercises.dart';
import '../../domain/usecases/get_workouts.dart';
import '../../domain/usecases/search_exercises.dart';
import '../../domain/usecases/seed_exercises.dart';
import '../../domain/usecases/update_workout.dart';
import '../../presentation/blocs/exercise/exercise_bloc.dart';
import '../../presentation/blocs/workout/workout_bloc.dart';
import '../services/exercise_seed_service.dart';

final GetIt sl = GetIt.instance;

/// Initialize dependency injection
Future<void> initDependencies() async {
  // Database
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper.instance);

  // Get database instance
  final db = await sl<DatabaseHelper>().database;

  // Data sources
  sl.registerLazySingleton<ExerciseLocalDataSource>(
    () => ExerciseLocalDataSourceImpl(databaseHelper: sl()),
  );

  sl.registerLazySingleton<WorkoutLocalDataSource>(
    () => WorkoutLocalDataSourceImpl(db),
  );

  // Repositories
  sl.registerLazySingleton<ExerciseRepository>(
    () => ExerciseRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<WorkoutRepository>(
    () => WorkoutRepositoryImpl(sl()),
  );

  // Services
  sl.registerLazySingleton<ExerciseSeedService>(
    () => ExerciseSeedService(repository: sl()),
  );

  // Use cases - Exercise
  sl.registerLazySingleton(() => GetExercises(repository: sl()));
  sl.registerLazySingleton(() => GetExerciseById(repository: sl()));
  sl.registerLazySingleton(() => CreateCustomExercise(repository: sl()));
  sl.registerLazySingleton(() => SeedExercises(seedService: sl()));
  sl.registerLazySingleton(() => SearchExercises(sl()));

  // Use cases - Workout
  sl.registerLazySingleton(() => GetWorkouts(repository: sl()));
  sl.registerLazySingleton(() => CreateWorkout(repository: sl()));
  sl.registerLazySingleton(() => UpdateWorkout(repository: sl()));
  sl.registerLazySingleton(() => DeleteWorkout(repository: sl()));

  // BLoCs
  sl.registerFactory(
    () => ExerciseBloc(
      getExercises: sl(),
      createCustomExercise: sl(),
      seedExercises: sl(),
      searchExercises: sl(),
      repository: sl(),
    ),
  );

  sl.registerFactory(
    () => WorkoutBloc(
      getWorkouts: sl(),
      createWorkout: sl(),
      updateWorkout: sl(),
      deleteWorkout: sl(),
    ),
  );
}
