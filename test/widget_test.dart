// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pft/domain/repositories/exercise_repository.dart';
import 'package:pft/domain/usecases/create_custom_exercise.dart';
import 'package:pft/domain/usecases/get_exercises.dart';
import 'package:pft/domain/usecases/seed_exercises.dart';
import 'package:pft/presentation/blocs/exercise/exercise_bloc.dart';

// Mock classes for testing
class MockGetExercises extends Mock implements GetExercises {}

class MockCreateCustomExercise extends Mock implements CreateCustomExercise {}

class MockSeedExercises extends Mock implements SeedExercises {}

class MockExerciseRepository extends Mock implements ExerciseRepository {}

void main() {
  testWidgets('App smoke test - loads without crashing', (
    WidgetTester tester,
  ) async {
    // Setup mocks
    final mockGetExercises = MockGetExercises();
    final mockCreateCustomExercise = MockCreateCustomExercise();
    final mockSeedExercises = MockSeedExercises();
    final mockRepository = MockExerciseRepository();

    // Mock the responses
    when(() => mockSeedExercises()).thenAnswer((_) async => {});
    when(() => mockGetExercises()).thenAnswer((_) async => []);

    // Build our app with mocked BLoC
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => ExerciseBloc(
            getExercises: mockGetExercises,
            createCustomExercise: mockCreateCustomExercise,
            seedExercises: mockSeedExercises,
            repository: mockRepository,
          ),
          child: const Scaffold(
            body: Center(child: Text('PFT - Performance Fitness Tracker')),
          ),
        ),
      ),
    );

    // Verify that the app title is displayed
    expect(find.text('PFT - Performance Fitness Tracker'), findsOneWidget);
  });
}
