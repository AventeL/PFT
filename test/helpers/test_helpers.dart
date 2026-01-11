import 'package:mockito/annotations.dart';
import 'package:pft/domain/repositories/exercise_repository.dart';
import 'package:pft/domain/usecases/create_custom_exercise.dart';
import 'package:pft/domain/usecases/get_exercises.dart';
import 'package:pft/domain/usecases/search_exercises.dart';
import 'package:pft/domain/usecases/seed_exercises.dart';

/// Generate mocks for testing
/// Run: flutter pub run build_runner build --delete-conflicting-outputs
@GenerateMocks([
  ExerciseRepository,
  GetExercises,
  CreateCustomExercise,
  SeedExercises,
  SearchExercises,
])
void main() {}
