import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pft/domain/entities/exercise.dart';
import 'package:pft/domain/entities/exercise_enums.dart';
import 'package:pft/domain/repositories/exercise_repository.dart';
import 'package:pft/domain/usecases/search_exercises.dart';

class MockExerciseRepository extends Mock implements ExerciseRepository {}

void main() {
  late SearchExercises usecase;
  late MockExerciseRepository mockRepository;
  late List<Exercise> testExercises;

  setUp(() {
    mockRepository = MockExerciseRepository();
    usecase = SearchExercises(mockRepository);

    // Create test data
    testExercises = [
      Exercise(
        id: '1',
        name: 'Barbell Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: DateTime.now(),
      ),
      Exercise(
        id: '2',
        name: 'Dumbbell Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.dumbbell,
        isCustom: false,
        createdAt: DateTime.now(),
      ),
      Exercise(
        id: '3',
        name: 'Cable Flyes',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.isolation,
        equipmentType: EquipmentType.cable,
        isCustom: false,
        createdAt: DateTime.now(),
      ),
      Exercise(
        id: '4',
        name: 'Barbell Rows',
        muscleGroup: MuscleGroup.back,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: DateTime.now(),
      ),
      Exercise(
        id: '5',
        name: 'Pull-ups',
        muscleGroup: MuscleGroup.back,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.bodyweight,
        isCustom: false,
        createdAt: DateTime.now(),
      ),
      Exercise(
        id: '6',
        name: 'Leg Press',
        muscleGroup: MuscleGroup.legs,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.machine,
        isCustom: false,
        createdAt: DateTime.now(),
      ),
    ];
  });

  group('SearchExercises', () {
    test('should return all exercises when no filters applied', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act
      final result = await usecase();

      // Assert
      expect(result, equals(testExercises));
      expect(result.length, equals(6));
      verify(() => mockRepository.getExercises()).called(1);
    });

    test('should filter by search query (case-insensitive)', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act
      final result = await usecase(query: 'bench');

      // Assert
      expect(result.length, equals(2));
      expect(result[0].name, contains('Bench Press'));
      expect(result[1].name, contains('Bench Press'));
    });

    test('should filter by search query with partial match', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act
      final result = await usecase(query: 'press');

      // Assert
      expect(result.length, equals(3)); // 2 bench press + 1 leg press
      expect(result.every((e) => e.name.toLowerCase().contains('press')), true);
    });

    test('should filter by search query case-insensitive', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act
      final result = await usecase(query: 'BARBELL');

      // Assert
      expect(result.length, equals(2));
      expect(result[0].name, equals('Barbell Bench Press'));
      expect(result[1].name, equals('Barbell Rows'));
    });

    test('should return empty list when no matches found', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act
      final result = await usecase(query: 'nonexistent');

      // Assert
      expect(result, isEmpty);
    });

    test('should filter by single muscle group', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act
      final result = await usecase(muscleGroups: {MuscleGroup.chest});

      // Assert
      expect(result.length, equals(3));
      expect(result.every((e) => e.muscleGroup == MuscleGroup.chest), true);
    });

    test('should filter by multiple muscle groups (OR logic)', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act
      final result = await usecase(
        muscleGroups: {MuscleGroup.chest, MuscleGroup.back},
      );

      // Assert
      expect(result.length, equals(5)); // 3 chest + 2 back
      expect(
        result.every((e) =>
            e.muscleGroup == MuscleGroup.chest ||
            e.muscleGroup == MuscleGroup.back),
        true,
      );
    });

    test('should filter by category', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act
      final result = await usecase(categories: {ExerciseCategory.isolation});

      // Assert
      expect(result.length, equals(1));
      expect(result[0].name, equals('Cable Flyes'));
    });

    test('should filter by equipment type', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act
      final result = await usecase(equipmentTypes: {EquipmentType.barbell});

      // Assert
      expect(result.length, equals(2));
      expect(result[0].name, equals('Barbell Bench Press'));
      expect(result[1].name, equals('Barbell Rows'));
    });

    test('should apply multiple filters with AND logic', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act - Chest exercises that are compound
      final result = await usecase(
        muscleGroups: {MuscleGroup.chest},
        categories: {ExerciseCategory.compound},
      );

      // Assert
      expect(result.length, equals(2)); // 2 compound chest exercises
      expect(result[0].name, equals('Barbell Bench Press'));
      expect(result[1].name, equals('Dumbbell Bench Press'));
    });

    test('should apply search query with filters', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act - Search "barbell" in chest exercises
      final result = await usecase(
        query: 'barbell',
        muscleGroups: {MuscleGroup.chest},
      );

      // Assert
      expect(result.length, equals(1));
      expect(result[0].name, equals('Barbell Bench Press'));
    });

    test('should combine all filter types', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act - Barbell compound exercises for chest or back
      final result = await usecase(
        muscleGroups: {MuscleGroup.chest, MuscleGroup.back},
        categories: {ExerciseCategory.compound},
        equipmentTypes: {EquipmentType.barbell},
      );

      // Assert
      expect(result.length, equals(2)); // Barbell Bench Press + Barbell Rows
      expect(
        result.every((e) =>
            e.equipmentType == EquipmentType.barbell &&
            e.category == ExerciseCategory.compound),
        true,
      );
    });

    test('should return empty list when filters match nothing', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act - Isolation exercises for legs (none in test data)
      final result = await usecase(
        muscleGroups: {MuscleGroup.legs},
        categories: {ExerciseCategory.isolation},
      );

      // Assert
      expect(result, isEmpty);
    });

    test('should handle empty query string as no filter', () async {
      // Arrange
      when(() => mockRepository.getExercises())
          .thenAnswer((_) async => testExercises);

      // Act
      final result = await usecase(query: '');

      // Assert
      expect(result.length, equals(6)); // All exercises
    });
  });
}
