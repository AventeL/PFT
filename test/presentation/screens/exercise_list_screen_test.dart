import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pft/domain/entities/exercise.dart';
import 'package:pft/domain/entities/exercise_enums.dart';
import 'package:pft/l10n/app_localizations.dart';
import 'package:pft/presentation/blocs/exercise/exercise_bloc.dart';
import 'package:pft/presentation/screens/exercise_list/exercise_list_screen.dart';

import '../../helpers/test_helpers.mocks.dart';

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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: BlocProvider<ExerciseBloc>.value(
        value: bloc,
        child: const ExerciseListScreen(),
      ),
    );
  }

  group('ExerciseListScreen Widget Tests', () {
    testWidgets('loads exercises successfully', (WidgetTester tester) async {
      // Arrange
      final bloc = ExerciseBloc(
        getExercises: mockGetExercises,
        createCustomExercise: mockCreateCustomExercise,
        seedExercises: mockSeedExercises,
        searchExercises: mockSearchExercises,
        repository: mockRepository,
      );

      when(mockGetExercises.call()).thenAnswer((_) async => []);

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

      // Assert - should show empty state after loading completes
      expect(find.textContaining('No exercises'), findsOneWidget);

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

      when(mockGetExercises.call()).thenAnswer((_) async => testExercises);

      // Act - pump and wait for all async operations to complete
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

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

      when(mockGetExercises.call()).thenThrow(Exception('Test error'));

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

      // Assert
      expect(find.textContaining('Error'), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);

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

      when(mockGetExercises.call()).thenAnswer((_) async => []);

      // Act - pump and wait for all async operations
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

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
      when(mockGetExercises.call()).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) {
          throw Exception('Test error');
        }
        return [];
      });

      // Act - initial load fails
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

      expect(find.textContaining('Error'), findsOneWidget);

      // Tap retry button by icon
      await tester.tap(find.byIcon(Icons.refresh));
      await tester.pumpAndSettle();

      // Assert - should show empty state now
      expect(find.textContaining('No exercises'), findsOneWidget);
      expect(find.textContaining('Error'), findsNothing);

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

      when(mockGetExercises.call()).thenAnswer((_) async => []);

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Exercises'), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);

      bloc.close();
    });
  });
}
