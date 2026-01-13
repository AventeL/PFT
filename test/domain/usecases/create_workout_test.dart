import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pft/domain/entities/workout.dart';
import 'package:pft/domain/entities/workout_exercise.dart';
import 'package:pft/domain/repositories/workout_repository.dart';
import 'package:pft/domain/usecases/create_workout.dart';

class MockWorkoutRepository extends Mock implements WorkoutRepository {}

void main() {
  late CreateWorkout useCase;
  late MockWorkoutRepository mockRepository;

  setUp(() {
    mockRepository = MockWorkoutRepository();
    useCase = CreateWorkout(repository: mockRepository);
  });

  setUpAll(() {
    registerFallbackValue(Workout(
      id: '',
      name: '',
      exercises: const [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));
  });

  group('CreateWorkout', () {
    final testDate = DateTime(2026, 1, 12);
    final validWorkout = Workout(
      id: '',
      name: 'Push Day',
      description: 'Chest and triceps',
      exercises: const [
        WorkoutExercise(
          exerciseId: 'ex-1',
          order: 0,
          targetSets: 3,
        ),
      ],
      createdAt: testDate,
      updatedAt: testDate,
    );

    test('should create workout successfully with valid data', () async {
      // Arrange
      when(() => mockRepository.createWorkout(any()))
          .thenAnswer((_) async => validWorkout);

      // Act
      final result = await useCase(validWorkout);

      // Assert
      expect(result, isA<Workout>());
      verify(() => mockRepository.createWorkout(any())).called(1);
    });

    test('should throw ArgumentError when workout name is empty', () async {
      // Arrange
      final invalidWorkout = validWorkout.copyWith(name: '');

      // Act & Assert
      expect(
        () => useCase(invalidWorkout),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          'Workout name cannot be empty',
        )),
      );
      verifyNever(() => mockRepository.createWorkout(any()));
    });

    test('should throw ArgumentError when workout name is only whitespace',
        () async {
      // Arrange
      final invalidWorkout = validWorkout.copyWith(name: '   ');

      // Act & Assert
      expect(
        () => useCase(invalidWorkout),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          'Workout name cannot be empty',
        )),
      );
      verifyNever(() => mockRepository.createWorkout(any()));
    });

    test('should throw ArgumentError when workout has no exercises', () async {
      // Arrange
      final invalidWorkout = validWorkout.copyWith(exercises: []);

      // Act & Assert
      expect(
        () => useCase(invalidWorkout),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          'Workout must have at least one exercise',
        )),
      );
      verifyNever(() => mockRepository.createWorkout(any()));
    });

    test('should throw ArgumentError when workout name exceeds 100 characters',
        () async {
      // Arrange
      final longName = 'A' * 101;
      final invalidWorkout = validWorkout.copyWith(name: longName);

      // Act & Assert
      expect(
        () => useCase(invalidWorkout),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          'Workout name cannot exceed 100 characters',
        )),
      );
      verifyNever(() => mockRepository.createWorkout(any()));
    });

    test(
        'should throw ArgumentError when workout description exceeds 500 characters',
        () async {
      // Arrange
      final longDescription = 'A' * 501;
      final invalidWorkout =
          validWorkout.copyWith(description: longDescription);

      // Act & Assert
      expect(
        () => useCase(invalidWorkout),
        throwsA(isA<ArgumentError>().having(
          (e) => e.message,
          'message',
          'Workout description cannot exceed 500 characters',
        )),
      );
      verifyNever(() => mockRepository.createWorkout(any()));
    });

    test('should accept workout name with exactly 100 characters', () async {
      // Arrange
      final maxName = 'A' * 100;
      final workoutWithMaxName = validWorkout.copyWith(name: maxName);
      when(() => mockRepository.createWorkout(any()))
          .thenAnswer((_) async => workoutWithMaxName);

      // Act
      await useCase(workoutWithMaxName);

      // Assert
      verify(() => mockRepository.createWorkout(any())).called(1);
    });

    test('should accept workout description with exactly 500 characters',
        () async {
      // Arrange
      final maxDescription = 'A' * 500;
      final workoutWithMaxDesc =
          validWorkout.copyWith(description: maxDescription);
      when(() => mockRepository.createWorkout(any()))
          .thenAnswer((_) async => workoutWithMaxDesc);

      // Act
      await useCase(workoutWithMaxDesc);

      // Assert
      verify(() => mockRepository.createWorkout(any())).called(1);
    });

    test('should trim workout name before saving', () async {
      // Arrange
      final workoutWithSpaces = validWorkout.copyWith(name: '  Push Day  ');
      when(() => mockRepository.createWorkout(any()))
          .thenAnswer((_) async => validWorkout);

      // Act
      await useCase(workoutWithSpaces);

      // Assert
      final captured =
          verify(() => mockRepository.createWorkout(captureAny())).captured;
      final savedWorkout = captured.first as Workout;
      expect(savedWorkout.name, 'Push Day');
    });

    test('should trim workout description before saving', () async {
      // Arrange
      final workoutWithSpaces =
          validWorkout.copyWith(description: '  Test description  ');
      when(() => mockRepository.createWorkout(any()))
          .thenAnswer((_) async => validWorkout);

      // Act
      await useCase(workoutWithSpaces);

      // Assert
      final captured =
          verify(() => mockRepository.createWorkout(captureAny())).captured;
      final savedWorkout = captured.first as Workout;
      expect(savedWorkout.description, 'Test description');
    });

    test('should trim workout notes before saving', () async {
      // Arrange
      final workoutWithSpaces = validWorkout.copyWith(notes: '  Test notes  ');
      when(() => mockRepository.createWorkout(any()))
          .thenAnswer((_) async => validWorkout);

      // Act
      await useCase(workoutWithSpaces);

      // Assert
      final captured =
          verify(() => mockRepository.createWorkout(captureAny())).captured;
      final savedWorkout = captured.first as Workout;
      expect(savedWorkout.notes, 'Test notes');
    });

    test('should generate UUID when workout ID is empty', () async {
      // Arrange
      final workoutWithoutId = validWorkout.copyWith(id: '');
      when(() => mockRepository.createWorkout(any()))
          .thenAnswer((_) async => validWorkout);

      // Act
      await useCase(workoutWithoutId);

      // Assert
      final captured =
          verify(() => mockRepository.createWorkout(captureAny())).captured;
      final savedWorkout = captured.first as Workout;
      expect(savedWorkout.id, isNotEmpty);
      expect(savedWorkout.id.length, 36); // UUID v4 length
    });

    test('should preserve existing ID when provided', () async {
      // Arrange
      final workoutWithId = validWorkout.copyWith(id: 'existing-id');
      when(() => mockRepository.createWorkout(any()))
          .thenAnswer((_) async => workoutWithId);

      // Act
      await useCase(workoutWithId);

      // Assert
      final captured =
          verify(() => mockRepository.createWorkout(captureAny())).captured;
      final savedWorkout = captured.first as Workout;
      expect(savedWorkout.id, 'existing-id');
    });

    test('should update updatedAt timestamp', () async {
      // Arrange
      final oldDate = DateTime(2025, 1, 1);
      final workoutWithOldDate = validWorkout.copyWith(updatedAt: oldDate);
      when(() => mockRepository.createWorkout(any()))
          .thenAnswer((_) async => validWorkout);

      // Act
      final beforeCall = DateTime.now();
      await useCase(workoutWithOldDate);
      final afterCall = DateTime.now();

      // Assert
      final captured =
          verify(() => mockRepository.createWorkout(captureAny())).captured;
      final savedWorkout = captured.first as Workout;
      expect(
          savedWorkout.updatedAt.isAfter(beforeCall) ||
              savedWorkout.updatedAt.isAtSameMomentAs(beforeCall),
          true);
      expect(
          savedWorkout.updatedAt.isBefore(afterCall) ||
              savedWorkout.updatedAt.isAtSameMomentAs(afterCall),
          true);
    });

    test('should accept workout with null description', () async {
      // Arrange
      final workoutWithoutDesc = validWorkout.copyWith(description: null);
      when(() => mockRepository.createWorkout(any()))
          .thenAnswer((_) async => workoutWithoutDesc);

      // Act
      await useCase(workoutWithoutDesc);

      // Assert
      verify(() => mockRepository.createWorkout(any())).called(1);
    });

    test('should accept workout with null notes', () async {
      // Arrange
      final workoutWithoutNotes = validWorkout.copyWith(notes: null);
      when(() => mockRepository.createWorkout(any()))
          .thenAnswer((_) async => workoutWithoutNotes);

      // Act
      await useCase(workoutWithoutNotes);

      // Assert
      verify(() => mockRepository.createWorkout(any())).called(1);
    });
  });
}
