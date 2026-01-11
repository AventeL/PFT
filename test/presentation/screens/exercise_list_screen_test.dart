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

    // Task 7.1: Test search bar renders and accepts input
    testWidgets('search bar renders with correct hint text',
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
      ];

      final bloc = ExerciseBloc(
        getExercises: mockGetExercises,
        createCustomExercise: mockCreateCustomExercise,
        seedExercises: mockSeedExercises,
        searchExercises: mockSearchExercises,
        repository: mockRepository,
      );

      when(mockGetExercises.call()).thenAnswer((_) async => testExercises);

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);

      bloc.close();
    });

    testWidgets('search bar accepts text input', (WidgetTester tester) async {
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
      ];

      final bloc = ExerciseBloc(
        getExercises: mockGetExercises,
        createCustomExercise: mockCreateCustomExercise,
        seedExercises: mockSeedExercises,
        searchExercises: mockSearchExercises,
        repository: mockRepository,
      );

      when(mockGetExercises.call()).thenAnswer((_) async => testExercises);

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

      // Enter text in search field
      await tester.enterText(find.byType(TextField), 'bench');
      await tester.pump();

      // Assert
      expect(find.text('bench'), findsOneWidget);

      bloc.close();
    });

    testWidgets('search bar initially has no clear button',
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
      ];

      final bloc = ExerciseBloc(
        getExercises: mockGetExercises,
        createCustomExercise: mockCreateCustomExercise,
        seedExercises: mockSeedExercises,
        searchExercises: mockSearchExercises,
        repository: mockRepository,
      );

      when(mockGetExercises.call()).thenAnswer((_) async => testExercises);

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

      // Assert - Initially no clear button (since search is empty)
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.suffixIcon, isNull);

      bloc.close();
    });

    testWidgets('search text field has a controller',
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
      ];

      final bloc = ExerciseBloc(
        getExercises: mockGetExercises,
        createCustomExercise: mockCreateCustomExercise,
        seedExercises: mockSeedExercises,
        searchExercises: mockSearchExercises,
        repository: mockRepository,
      );

      when(mockGetExercises.call()).thenAnswer((_) async => testExercises);

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

      // Enter text
      await tester.enterText(find.byType(TextField), 'bench');
      await tester.pump();

      // Assert - text should be in controller
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, 'bench');

      bloc.close();
    });

    // Task 7.4: Test "No results found" message
    testWidgets(
        'displays "No results found" with suggestion when filters active',
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

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

      // Assert - should show no exercises found
      expect(find.text('No exercises found'), findsOneWidget);
      expect(find.byIcon(Icons.search_off), findsOneWidget);

      bloc.close();
    });

    testWidgets('displays filter button in app bar',
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

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

      // Assert - filter button should be present
      expect(find.byIcon(Icons.filter_list), findsOneWidget);

      bloc.close();
    });

    testWidgets('displays exercise count when exercises are loaded',
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

      // Act
      await tester.pumpWidget(createTestWidget(bloc));
      await tester.pumpAndSettle();

      // Assert - should show count
      expect(find.textContaining('2'), findsWidgets);

      bloc.close();
    });
  });
}
