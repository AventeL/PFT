import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pft/domain/entities/workout.dart';
import 'package:pft/domain/entities/workout_exercise.dart';
import 'package:pft/domain/usecases/create_workout.dart';
import 'package:pft/domain/usecases/delete_workout.dart';
import 'package:pft/domain/usecases/get_workout_templates.dart';
import 'package:pft/domain/usecases/get_workouts.dart';
import 'package:pft/domain/usecases/import_template.dart';
import 'package:pft/domain/usecases/seed_templates.dart';
import 'package:pft/domain/usecases/update_workout.dart';
import 'package:pft/presentation/blocs/workout/workout_bloc.dart';
import 'package:pft/presentation/blocs/workout/workout_event.dart';
import 'package:pft/presentation/blocs/workout/workout_state.dart';

class MockGetWorkouts extends Mock implements GetWorkouts {}

class MockCreateWorkout extends Mock implements CreateWorkout {}

class MockUpdateWorkout extends Mock implements UpdateWorkout {}

class MockDeleteWorkout extends Mock implements DeleteWorkout {}

class MockGetWorkoutTemplates extends Mock implements GetWorkoutTemplates {}

class MockImportTemplate extends Mock implements ImportTemplate {}

class MockSeedTemplates extends Mock implements SeedTemplates {}

void main() {
  late WorkoutBloc bloc;
  late MockGetWorkouts mockGetWorkouts;
  late MockCreateWorkout mockCreateWorkout;
  late MockUpdateWorkout mockUpdateWorkout;
  late MockDeleteWorkout mockDeleteWorkout;
  late MockGetWorkoutTemplates mockGetWorkoutTemplates;
  late MockImportTemplate mockImportTemplate;
  late MockSeedTemplates mockSeedTemplates;

  setUp(() {
    mockGetWorkouts = MockGetWorkouts();
    mockCreateWorkout = MockCreateWorkout();
    mockUpdateWorkout = MockUpdateWorkout();
    mockDeleteWorkout = MockDeleteWorkout();
    mockGetWorkoutTemplates = MockGetWorkoutTemplates();
    mockImportTemplate = MockImportTemplate();
    mockSeedTemplates = MockSeedTemplates();

    bloc = WorkoutBloc(
      getWorkouts: mockGetWorkouts,
      createWorkout: mockCreateWorkout,
      updateWorkout: mockUpdateWorkout,
      deleteWorkout: mockDeleteWorkout,
      getWorkoutTemplates: mockGetWorkoutTemplates,
      importTemplate: mockImportTemplate,
      seedTemplates: mockSeedTemplates,
    );
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

  tearDown(() {
    bloc.close();
  });

  final testWorkout = Workout(
    id: 'workout-1',
    name: 'Push Day',
    description: 'Chest and triceps',
    exercises: const [
      WorkoutExercise(
        exerciseId: 'ex-1',
        order: 0,
        targetSets: 3,
      ),
    ],
    createdAt: DateTime(2026, 1, 12),
    updatedAt: DateTime(2026, 1, 12),
  );

  group('WorkoutBloc', () {
    test('initial state is WorkoutInitial', () {
      expect(bloc.state, const WorkoutInitial());
    });

    group('LoadWorkouts', () {
      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, WorkoutsLoaded] when successful',
        build: () {
          when(() => mockGetWorkouts()).thenAnswer((_) async => [testWorkout]);
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadWorkouts()),
        expect: () => [
          const WorkoutLoading(),
          WorkoutsLoaded([testWorkout]),
        ],
        verify: (_) {
          verify(() => mockGetWorkouts()).called(1);
        },
      );

      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, WorkoutError] when fails',
        build: () {
          when(() => mockGetWorkouts()).thenThrow(Exception('Database error'));
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadWorkouts()),
        expect: () => [
          const WorkoutLoading(),
          const WorkoutError(
              'Failed to load workouts: Exception: Database error'),
        ],
      );

      blocTest<WorkoutBloc, WorkoutState>(
        'emits empty list when no workouts exist',
        build: () {
          when(() => mockGetWorkouts()).thenAnswer((_) async => []);
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadWorkouts()),
        expect: () => [
          const WorkoutLoading(),
          const WorkoutsLoaded([]),
        ],
      );
    });

    group('CreateWorkoutEvent', () {
      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, WorkoutCreated, WorkoutLoading, WorkoutsLoaded] when successful',
        build: () {
          when(() => mockCreateWorkout(any()))
              .thenAnswer((_) async => testWorkout);
          when(() => mockGetWorkouts()).thenAnswer((_) async => [testWorkout]);
          return bloc;
        },
        act: (bloc) => bloc.add(CreateWorkoutEvent(testWorkout)),
        expect: () => [
          const WorkoutLoading(),
          WorkoutCreated(testWorkout),
          const WorkoutLoading(),
          WorkoutsLoaded([testWorkout]),
        ],
        verify: (_) {
          verify(() => mockCreateWorkout(any())).called(1);
          verify(() => mockGetWorkouts()).called(1);
        },
      );

      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, WorkoutError] when validation fails',
        build: () {
          when(() => mockCreateWorkout(any()))
              .thenThrow(ArgumentError('Workout name cannot be empty'));
          return bloc;
        },
        act: (bloc) => bloc.add(CreateWorkoutEvent(testWorkout)),
        expect: () => [
          const WorkoutLoading(),
          const WorkoutError(
              'Failed to create workout: Invalid argument(s): Workout name cannot be empty'),
        ],
      );

      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, WorkoutError] when database fails',
        build: () {
          when(() => mockCreateWorkout(any()))
              .thenThrow(Exception('Database error'));
          return bloc;
        },
        act: (bloc) => bloc.add(CreateWorkoutEvent(testWorkout)),
        expect: () => [
          const WorkoutLoading(),
          const WorkoutError(
              'Failed to create workout: Exception: Database error'),
        ],
      );
    });

    group('UpdateWorkoutEvent', () {
      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, WorkoutUpdated, WorkoutLoading, WorkoutsLoaded] when successful',
        build: () {
          final updatedWorkout = testWorkout.copyWith(name: 'Updated Push Day');
          when(() => mockUpdateWorkout(any()))
              .thenAnswer((_) async => updatedWorkout);
          when(() => mockGetWorkouts())
              .thenAnswer((_) async => [updatedWorkout]);
          return bloc;
        },
        act: (bloc) {
          final updatedWorkout = testWorkout.copyWith(name: 'Updated Push Day');
          return bloc.add(UpdateWorkoutEvent(updatedWorkout));
        },
        expect: () {
          final updatedWorkout = testWorkout.copyWith(name: 'Updated Push Day');
          return [
            const WorkoutLoading(),
            WorkoutUpdated(updatedWorkout),
            const WorkoutLoading(),
            WorkoutsLoaded([updatedWorkout]),
          ];
        },
        verify: (_) {
          verify(() => mockUpdateWorkout(any())).called(1);
          verify(() => mockGetWorkouts()).called(1);
        },
      );

      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, WorkoutError] when update fails',
        build: () {
          when(() => mockUpdateWorkout(any()))
              .thenThrow(Exception('Update failed'));
          return bloc;
        },
        act: (bloc) => bloc.add(UpdateWorkoutEvent(testWorkout)),
        expect: () => [
          const WorkoutLoading(),
          const WorkoutError(
              'Failed to update workout: Exception: Update failed'),
        ],
      );
    });

    group('DeleteWorkoutEvent', () {
      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, WorkoutDeleted, WorkoutLoading, WorkoutsLoaded] when successful',
        build: () {
          when(() => mockDeleteWorkout(any())).thenAnswer((_) async => {});
          when(() => mockGetWorkouts()).thenAnswer((_) async => []);
          return bloc;
        },
        act: (bloc) => bloc.add(const DeleteWorkoutEvent('workout-1')),
        expect: () => [
          const WorkoutLoading(),
          const WorkoutDeleted('workout-1'),
          const WorkoutLoading(),
          const WorkoutsLoaded([]),
        ],
        verify: (_) {
          verify(() => mockDeleteWorkout('workout-1')).called(1);
          verify(() => mockGetWorkouts()).called(1);
        },
      );

      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, WorkoutError] when delete fails',
        build: () {
          when(() => mockDeleteWorkout(any()))
              .thenThrow(Exception('Delete failed'));
          return bloc;
        },
        act: (bloc) => bloc.add(const DeleteWorkoutEvent('workout-1')),
        expect: () => [
          const WorkoutLoading(),
          const WorkoutError(
              'Failed to delete workout: Exception: Delete failed'),
        ],
      );
    });

    group('DuplicateWorkoutEvent', () {
      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, WorkoutCreated, WorkoutLoading, WorkoutsLoaded] when successful',
        build: () {
          when(() => mockCreateWorkout(any()))
              .thenAnswer((_) async => testWorkout);
          when(() => mockGetWorkouts()).thenAnswer((_) async => [testWorkout]);
          return bloc;
        },
        act: (bloc) => bloc.add(DuplicateWorkoutEvent(testWorkout)),
        expect: () => [
          const WorkoutLoading(),
          isA<WorkoutCreated>(),
          const WorkoutLoading(),
          isA<WorkoutsLoaded>(),
        ],
        verify: (_) {
          final captured =
              verify(() => mockCreateWorkout(captureAny())).captured;
          final duplicatedWorkout = captured.first as Workout;
          expect(duplicatedWorkout.name, 'Push Day (Copy)');
          expect(duplicatedWorkout.id, isNot(testWorkout.id));
          verify(() => mockGetWorkouts()).called(1);
        },
      );

      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, WorkoutError] when duplication fails',
        build: () {
          when(() => mockCreateWorkout(any()))
              .thenThrow(Exception('Duplication failed'));
          return bloc;
        },
        act: (bloc) => bloc.add(DuplicateWorkoutEvent(testWorkout)),
        expect: () => [
          const WorkoutLoading(),
          const WorkoutError(
              'Failed to duplicate workout: Exception: Duplication failed'),
        ],
      );
    });

    group('LoadTemplates', () {
      final template1 =
          testWorkout.copyWith(id: 'template-1', isTemplate: true);
      final template2 =
          testWorkout.copyWith(id: 'template-2', isTemplate: true);

      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, TemplatesLoaded] with only templates',
        build: () {
          when(() => mockGetWorkoutTemplates())
              .thenAnswer((_) async => [template1, template2]);
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadTemplates()),
        expect: () => [
          const WorkoutLoading(),
          TemplatesLoaded([template1, template2]),
        ],
        verify: (_) {
          verify(() => mockGetWorkoutTemplates()).called(1);
        },
      );

      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, TemplatesLoaded] with empty list when no templates',
        build: () {
          when(() => mockGetWorkoutTemplates()).thenAnswer((_) async => []);
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadTemplates()),
        expect: () => [
          const WorkoutLoading(),
          const TemplatesLoaded([]),
        ],
      );

      blocTest<WorkoutBloc, WorkoutState>(
        'emits [WorkoutLoading, WorkoutError] when fails',
        build: () {
          when(() => mockGetWorkoutTemplates())
              .thenThrow(Exception('Database error'));
          return bloc;
        },
        act: (bloc) => bloc.add(const LoadTemplates()),
        expect: () => [
          const WorkoutLoading(),
          const WorkoutError(
              'Failed to load templates: Exception: Database error'),
        ],
      );
    });
  });
}
