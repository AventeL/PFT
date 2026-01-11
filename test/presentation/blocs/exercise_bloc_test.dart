import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:pft/domain/entities/exercise.dart';
import 'package:pft/domain/entities/exercise_enums.dart';
import 'package:pft/presentation/blocs/exercise/exercise_bloc.dart';
import 'package:pft/presentation/blocs/exercise/exercise_event.dart';
import 'package:pft/presentation/blocs/exercise/exercise_state.dart';

import '../../helpers/test_helpers.mocks.dart';

void main() {
  late ExerciseBloc exerciseBloc;
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

    exerciseBloc = ExerciseBloc(
      getExercises: mockGetExercises,
      createCustomExercise: mockCreateCustomExercise,
      seedExercises: mockSeedExercises,
      searchExercises: mockSearchExercises,
      repository: mockRepository,
    );
  });

  tearDown(() {
    exerciseBloc.close();
  });

  final testExercise = Exercise(
    id: 'test-id',
    name: 'Bench Press',
    muscleGroup: MuscleGroup.chest,
    category: ExerciseCategory.compound,
    equipmentType: EquipmentType.barbell,
    isCustom: false,
    createdAt: DateTime.now(),
  );

  final testExercises = [testExercise];

  group('ExerciseBloc', () {
    test('initial state should be ExerciseInitial', () {
      expect(exerciseBloc.state, const ExerciseInitial());
    });

    blocTest<ExerciseBloc, ExerciseState>(
      'emits [ExerciseLoading, ExercisesLoaded] when LoadExercises succeeds',
      build: () {
        when(mockGetExercises.call()).thenAnswer((_) async => testExercises);
        return exerciseBloc;
      },
      act: (bloc) => bloc.add(const LoadExercises()),
      expect: () => [
        const ExerciseLoading(),
        ExercisesLoaded(allExercises: testExercises),
      ],
      verify: (_) {
        verify(mockGetExercises.call()).called(1);
      },
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'emits [ExerciseLoading, ExerciseError] when LoadExercises fails',
      build: () {
        when(mockGetExercises.call()).thenThrow(Exception('Failed to load'));
        return exerciseBloc;
      },
      act: (bloc) => bloc.add(const LoadExercises()),
      expect: () => [
        const ExerciseLoading(),
        isA<ExerciseError>(),
      ],
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'emits [ExerciseLoading, ExercisesLoaded] when SeedExercisesIfNeeded succeeds',
      build: () {
        when(mockSeedExercises.call()).thenAnswer((_) async => {});
        when(mockGetExercises.call()).thenAnswer((_) async => testExercises);
        return exerciseBloc;
      },
      act: (bloc) => bloc.add(const SeedExercisesIfNeeded()),
      expect: () => [
        const ExerciseLoading(),
        ExercisesLoaded(allExercises: testExercises),
      ],
      verify: (_) {
        verify(mockSeedExercises.call()).called(1);
        verify(mockGetExercises.call()).called(1);
      },
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'emits [ExercisesLoaded] when CreateCustomExerciseEvent succeeds',
      build: () {
        when(mockRepository.createExercise(any))
            .thenAnswer((_) async => testExercise);
        when(mockGetExercises.call()).thenAnswer((_) async => testExercises);
        return exerciseBloc;
      },
      act: (bloc) => bloc.add(CreateCustomExerciseEvent(testExercise)),
      expect: () => [
        ExercisesLoaded(allExercises: testExercises),
      ],
      verify: (_) {
        verify(mockRepository.createExercise(testExercise)).called(1);
        verify(mockGetExercises.call()).called(1);
      },
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'emits [ExercisesLoaded] when DeleteCustomExerciseEvent succeeds',
      build: () {
        when(mockRepository.deleteExercise(any)).thenAnswer((_) async => {});
        when(mockGetExercises.call()).thenAnswer((_) async => []);
        return exerciseBloc;
      },
      act: (bloc) => bloc.add(const DeleteCustomExerciseEvent('test-id')),
      expect: () => [
        const ExercisesLoaded(allExercises: []),
      ],
      verify: (_) {
        verify(mockRepository.deleteExercise('test-id')).called(1);
        verify(mockGetExercises.call()).called(1);
      },
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'emits [ExerciseError] when CreateCustomExerciseEvent fails',
      build: () {
        when(mockRepository.createExercise(any))
            .thenThrow(Exception('Failed to create'));
        return exerciseBloc;
      },
      act: (bloc) => bloc.add(CreateCustomExerciseEvent(testExercise)),
      expect: () => [
        isA<ExerciseError>(),
      ],
    );
  });
}
