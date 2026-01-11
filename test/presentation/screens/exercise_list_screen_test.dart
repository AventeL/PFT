import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pft/domain/entities/exercise.dart';
import 'package:pft/domain/entities/exercise_enums.dart';
import 'package:pft/domain/repositories/exercise_repository.dart';
import 'package:pft/domain/usecases/create_custom_exercise.dart';
import 'package:pft/domain/usecases/get_exercises.dart';
import 'package:pft/domain/usecases/search_exercises.dart';
import 'package:pft/domain/usecases/seed_exercises.dart';
import 'package:pft/presentation/blocs/exercise/exercise_bloc.dart';
import 'package:pft/presentation/screens/exercise_list/exercise_list_screen.dart';

// Mock classes
class MockGetExercises extends Mock implements GetExercises {}

class MockCreateCustomExercise extends Mock implements CreateCustomExercise {}

class MockSeedExercises extends Mock implements SeedExercises {}

class MockSearchExercises extends Mock implements SearchExercises {}

class MockExerciseRepository extends Mock implements ExerciseRepository {}

void main() {
  late MockGetExercises mockGetExercises;
  late MockCreateCustomExercise mockCreateCustomExercise;
  late MockSeedExercises mockSeedExercises;
  late MockSearchExercises mockSearchExercises;
  late MockExerciseRepository mockRepository;

  setUp(() {
    mockGetExercises = MockGetExercises();
    mockCreateCustomExercise = MockCreateCustomExercise();
    mockSeedExercises = MockSeedExercises();
    mockSearchExercises = MockSearchExercises();
    mockRepository = MockExerciseRepository();
  });

  Widget createTestWidget(ExerciseBloc bloc) {
    return MaterialApp(
      home: BlocProvider<ExerciseBloc>.value(
        value: bloc,
        child: const ExerciseListScreen(),
      ),
    );
  }

  group('ExerciseListScreen Widget Tests', () {
    testWidgets('displays loading indicator when state is ExerciseLoading',
        (WidgetTester tester) async {
      // Arrange
      final bloc = ExerciseBloc(
        getExercises: mockGetExercises,
        createCustomExercise: mockCreateCustomExercise,
        seedExercises: mockSeedExercises,
        searchExercises: mockSearchExercises,
        repository: mockRepository,
      );

      // Mock to return empty list after a short delay
      when(() => mockGetExercises()).thenAnswer(
        (_) => Future.delayed(const Duration(milliseconds: 100), () => []),
      );

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      // Trigger the frame where LoadExercises is added
      await tester.pump();

      // Now we should see the loading indicator
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Complete all pending operations
      await tester.pumpAndSettle();

      bloc.close();
    });

    testWidgets('displays exercises grouped by muscle group when loaded',
        (WidgetTester tester) async {
      // Arrange
      final testExercises = [
        Exercise(
          id: '1',
          name: 'Bench Press',
          muscleGroup: MuscleGroup.chest,
          category: ExerciseCategory.compound,
          equipmentType: EquipmentType.barbell,
          isCustom: false,
          createdAt: DateTime.now(),
        ),
        Exercise(
          id: '2',
          name: 'Squat',
          muscleGroup: MuscleGroup.legs,
          category: ExerciseCategory.compound,
          equipmentType: EquipmentType.barbell,
          isCustom: false,
          createdAt: DateTime.now(),
        ),
      ];

      final bloc = ExerciseBloc(
        getExercises: mockGetExercises,
        createCustomExercise: mockCreateCustomExercise,
        seedExercises: mockSeedExercises,
        searchExercises: mockSearchExercises,
        repository: mockRepository,
      );

      when(() => mockGetExercises()).thenAnswer((_) async => testExercises);

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pump(); // Start loading
      await tester.pump(); // Complete loading

      // Assert
      expect(
          find.text('Chest'), findsWidgets); // Can appear in header and badge
      expect(find.text('Legs'), findsWidgets);
      expect(find.text('Bench Press'), findsOneWidget);
      expect(find.text('Squat'), findsOneWidget);

      bloc.close();
    });

    testWidgets(
        'displays error message and retry button when state is ExerciseError',
        (WidgetTester tester) async {
      // Arrange
      final bloc = ExerciseBloc(
        getExercises: mockGetExercises,
        createCustomExercise: mockCreateCustomExercise,
        seedExercises: mockSeedExercises,
        searchExercises: mockSearchExercises,
        repository: mockRepository,
      );

      when(() => mockGetExercises()).thenThrow(Exception('Test error'));

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pump(); // Start loading
      await tester.pump(); // Error state

      // Assert
      expect(find.text('Error loading exercises'), findsOneWidget);
      expect(find.text('Retry'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);

      bloc.close();
    });

    testWidgets('displays "No exercises found" when list is empty',
        (WidgetTester tester) async {
      // Arrange
      final bloc = ExerciseBloc(
        getExercises: mockGetExercises,
        createCustomExercise: mockCreateCustomExercise,
        seedExercises: mockSeedExercises,
        searchExercises: mockSearchExercises,
        repository: mockRepository,
      );

      when(() => mockGetExercises()).thenAnswer((_) async => []);

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pump(); // Start loading
      await tester.pump(); // Complete loading

      // Assert
      expect(find.text('No exercises found'), findsOneWidget);

      bloc.close();
    });
    testWidgets('retry button reloads exercises', (WidgetTester tester) async {
      // Arrange
      final bloc = ExerciseBloc(
        getExercises: mockGetExercises,
        createCustomExercise: mockCreateCustomExercise,
        seedExercises: mockSeedExercises,
        searchExercises: mockSearchExercises,
        repository: mockRepository,
      );

      // First call fails, second succeeds
      var callCount = 0;
      when(() => mockGetExercises()).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          throw Exception('Test error');
        }
        return [];
      });

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pump(); // Start loading
      await tester.pump(); // Error state

      expect(find.text('Error loading exercises'), findsOneWidget);

      // Tap retry
      await tester.tap(find.text('Retry'));
      await tester.pump(); // Start loading again
      await tester.pump(); // Complete loading

      // Assert - should show empty state now
      expect(find.text('No exercises found'), findsOneWidget);
      expect(find.text('Error loading exercises'), findsNothing);

      bloc.close();
    });
    testWidgets('displays app bar with title', (WidgetTester tester) async {
      // Arrange
      final bloc = ExerciseBloc(
        getExercises: mockGetExercises,
        createCustomExercise: mockCreateCustomExercise,
        seedExercises: mockSeedExercises,
        searchExercises: mockSearchExercises,
        repository: mockRepository,
      );

      when(() => mockGetExercises()).thenAnswer((_) async => []);

      // Act
      await tester.pumpWidget(createTestWidget(bloc));

      // Assert
      expect(find.text('Exercises'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);

      bloc.close();
    });
  });
}
