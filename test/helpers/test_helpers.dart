import 'package:mockito/annotations.dart';
import 'package:pft/domain/repositories/exercise_repository.dart';
import 'package:pft/domain/repositories/workout_repository.dart';
import 'package:pft/domain/usecases/create_custom_exercise.dart';
import 'package:pft/domain/usecases/create_workout.dart';
import 'package:pft/domain/usecases/delete_workout.dart';
import 'package:pft/domain/usecases/get_exercises.dart';
import 'package:pft/domain/usecases/get_workouts.dart';
import 'package:pft/domain/usecases/search_exercises.dart';
import 'package:pft/domain/usecases/seed_exercises.dart';
import 'package:pft/domain/usecases/update_workout.dart';

/// Generate mocks for testing
/// Run: flutter pub run build_runner build --delete-conflicting-outputs
@GenerateMocks([
  ExerciseRepository,
  WorkoutRepository,
  GetExercises,
  CreateCustomExercise,
  SeedExercises,
  SearchExercises,
  GetWorkouts,
  CreateWorkout,
  UpdateWorkout,
  DeleteWorkout,
])
void main() {}
