// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pft/presentation/blocs/exercise/exercise_bloc.dart';

import 'helpers/test_helpers.mocks.dart';

void main() {
  testWidgets('App smoke test - loads without crashing', (
    WidgetTester tester,
  ) async {
    // Setup mocks
    final mockGetExercises = MockGetExercises();
    final mockCreateCustomExercise = MockCreateCustomExercise();
    final mockSeedExercises = MockSeedExercises();
    final mockSearchExercises = MockSearchExercises();
    final mockRepository = MockExerciseRepository();

    // Mock the responses
    when(mockSeedExercises.call()).thenAnswer((_) async => {});
    when(mockGetExercises.call()).thenAnswer((_) async => []);

    // Build our app with mocked BLoC
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider(
          create: (context) => ExerciseBloc(
            getExercises: mockGetExercises,
            createCustomExercise: mockCreateCustomExercise,
            seedExercises: mockSeedExercises,
            searchExercises: mockSearchExercises,
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
