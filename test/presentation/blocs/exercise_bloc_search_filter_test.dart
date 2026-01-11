import 'package:bloc_test/bloc_test.dart';
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
import 'package:pft/presentation/blocs/exercise/exercise_event.dart';
import 'package:pft/presentation/blocs/exercise/exercise_state.dart';

// Mock classes
class MockGetExercises extends Mock implements GetExercises {}

class MockCreateCustomExercise extends Mock implements CreateCustomExercise {}

class MockSeedExercises extends Mock implements SeedExercises {}

class MockSearchExercises extends Mock implements SearchExercises {}

class MockExerciseRepository extends Mock implements ExerciseRepository {}

void main() {
  late ExerciseBloc exerciseBloc;
  late MockGetExercises mockGetExercises;
  late MockCreateCustomExercise mockCreateCustomExercise;
  late MockSeedExercises mockSeedExercises;
  late MockSearchExercises mockSearchExercises;
  late MockExerciseRepository mockRepository;

  late List<Exercise> testExercises;
  late Exercise chestExercise1;
  late Exercise chestExercise2;
  late Exercise backExercise;
  late Exercise legsExercise;

  setUpAll(() {
    registerFallbackValue(
      Exercise(
        id: 'fallback',
        name: 'Fallback',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: DateTime.now(),
      ),
    );
  });

  setUp(() {
    mockGetExercises = MockGetExercises();
    mockCreateCustomExercise = MockCreateCustomExercise();
    mockSeedExercises = MockSeedExercises();
    mockSearchExercises = MockSearchExercises();
    mockRepository = MockExerciseRepository();

    // Create test data
    chestExercise1 = Exercise(
      id: '1',
      name: 'Barbell Bench Press',
      muscleGroup: MuscleGroup.chest,
      category: ExerciseCategory.compound,
      equipmentType: EquipmentType.barbell,
      isCustom: false,
      createdAt: DateTime.now(),
    );

    chestExercise2 = Exercise(
      id: '2',
      name: 'Dumbbell Flyes',
      muscleGroup: MuscleGroup.chest,
      category: ExerciseCategory.isolation,
      equipmentType: EquipmentType.dumbbell,
      isCustom: false,
      createdAt: DateTime.now(),
    );

    backExercise = Exercise(
      id: '3',
      name: 'Pull-ups',
      muscleGroup: MuscleGroup.back,
      category: ExerciseCategory.compound,
      equipmentType: EquipmentType.bodyweight,
      isCustom: false,
      createdAt: DateTime.now(),
    );

    legsExercise = Exercise(
      id: '4',
      name: 'Leg Press',
      muscleGroup: MuscleGroup.legs,
      category: ExerciseCategory.compound,
      equipmentType: EquipmentType.machine,
      isCustom: false,
      createdAt: DateTime.now(),
    );

    testExercises = [
      chestExercise1,
      chestExercise2,
      backExercise,
      legsExercise,
    ];

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

  group('ExerciseBloc - Search & Filter', () {
    blocTest<ExerciseBloc, ExerciseState>(
      'emits filtered exercises when SearchExercisesEvent is added',
      build: () {
        when(() => mockSearchExercises(
              query: any(named: 'query'),
              muscleGroups: any(named: 'muscleGroups'),
              categories: any(named: 'categories'),
              equipmentTypes: any(named: 'equipmentTypes'),
            )).thenAnswer((_) async => [chestExercise1]);
        return exerciseBloc;
      },
      seed: () => ExercisesLoaded(allExercises: testExercises),
      act: (bloc) => bloc.add(const SearchExercisesEvent('bench')),
      expect: () => [
        isA<ExercisesLoaded>()
            .having((state) => state.searchQuery, 'searchQuery', 'bench')
            .having(
                (state) => state.filteredExercises.length, 'filtered count', 1)
            .having((state) => state.filteredExercises.first.name, 'first name',
                'Barbell Bench Press'),
      ],
      verify: (_) {
        verify(() => mockSearchExercises(
              query: 'bench',
              muscleGroups: const {},
              categories: const {},
              equipmentTypes: const {},
            )).called(1);
      },
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'emits filtered exercises when FilterByMuscleGroupsEvent is added',
      build: () {
        when(() => mockSearchExercises(
              query: any(named: 'query'),
              muscleGroups: any(named: 'muscleGroups'),
              categories: any(named: 'categories'),
              equipmentTypes: any(named: 'equipmentTypes'),
            )).thenAnswer((_) async => [chestExercise1, chestExercise2]);
        return exerciseBloc;
      },
      seed: () => ExercisesLoaded(allExercises: testExercises),
      act: (bloc) =>
          bloc.add(const FilterByMuscleGroupsEvent({MuscleGroup.chest})),
      expect: () => [
        isA<ExercisesLoaded>().having(
            (state) => state.selectedMuscleGroups, 'selected groups', {
          MuscleGroup.chest
        }).having(
            (state) => state.filteredExercises.length, 'filtered count', 2),
      ],
      verify: (_) {
        verify(() => mockSearchExercises(
              query: '',
              muscleGroups: {MuscleGroup.chest},
              categories: const {},
              equipmentTypes: const {},
            )).called(1);
      },
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'emits filtered exercises when FilterByCategoriesEvent is added',
      build: () {
        when(() => mockSearchExercises(
                  query: any(named: 'query'),
                  muscleGroups: any(named: 'muscleGroups'),
                  categories: any(named: 'categories'),
                  equipmentTypes: any(named: 'equipmentTypes'),
                ))
            .thenAnswer(
                (_) async => [chestExercise1, backExercise, legsExercise]);
        return exerciseBloc;
      },
      seed: () => ExercisesLoaded(allExercises: testExercises),
      act: (bloc) =>
          bloc.add(const FilterByCategoriesEvent({ExerciseCategory.compound})),
      expect: () => [
        isA<ExercisesLoaded>().having(
            (state) => state.selectedCategories, 'selected categories', {
          ExerciseCategory.compound
        }).having(
            (state) => state.filteredExercises.length, 'filtered count', 3),
      ],
      verify: (_) {
        verify(() => mockSearchExercises(
              query: '',
              muscleGroups: const {},
              categories: {ExerciseCategory.compound},
              equipmentTypes: const {},
            )).called(1);
      },
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'emits filtered exercises when FilterByEquipmentTypesEvent is added',
      build: () {
        when(() => mockSearchExercises(
              query: any(named: 'query'),
              muscleGroups: any(named: 'muscleGroups'),
              categories: any(named: 'categories'),
              equipmentTypes: any(named: 'equipmentTypes'),
            )).thenAnswer((_) async => [chestExercise1]);
        return exerciseBloc;
      },
      seed: () => ExercisesLoaded(allExercises: testExercises),
      act: (bloc) =>
          bloc.add(const FilterByEquipmentTypesEvent({EquipmentType.barbell})),
      expect: () => [
        isA<ExercisesLoaded>().having(
            (state) => state.selectedEquipmentTypes, 'selected equipment', {
          EquipmentType.barbell
        }).having(
            (state) => state.filteredExercises.length, 'filtered count', 1),
      ],
      verify: (_) {
        verify(() => mockSearchExercises(
              query: '',
              muscleGroups: const {},
              categories: const {},
              equipmentTypes: {EquipmentType.barbell},
            )).called(1);
      },
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'emits all exercises when ClearFiltersEvent is added',
      build: () => exerciseBloc,
      seed: () => ExercisesLoaded(
        allExercises: testExercises,
        filteredExercises: [chestExercise1],
        searchQuery: 'bench',
        selectedMuscleGroups: const {MuscleGroup.chest},
      ),
      act: (bloc) => bloc.add(const ClearFiltersEvent()),
      expect: () => [
        isA<ExercisesLoaded>()
            .having((state) => state.searchQuery, 'search query', '')
            .having(
                (state) => state.selectedMuscleGroups, 'muscle groups', isEmpty)
            .having((state) => state.selectedCategories, 'categories', isEmpty)
            .having(
                (state) => state.selectedEquipmentTypes, 'equipment', isEmpty)
            .having((state) => state.filteredExercises.length, 'filtered count',
                testExercises.length),
      ],
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'combines search and filters correctly',
      build: () {
        // Fallback mock for any other combination - MUST BE FIRST in Mocktail
        when(() => mockSearchExercises(
              query: any(named: 'query'),
              muscleGroups: any(named: 'muscleGroups'),
              categories: any(named: 'categories'),
              equipmentTypes: any(named: 'equipmentTypes'),
            )).thenAnswer((_) async => []);

        // Mock for filtering by muscle group (no search query yet) - SPECIFIC
        when(() => mockSearchExercises(
              query: '',
              muscleGroups: {MuscleGroup.chest},
              categories: const {},
              equipmentTypes: const {},
            )).thenAnswer((_) async => [chestExercise1, chestExercise2]);

        // Mock for searching within filtered results - SPECIFIC
        when(() => mockSearchExercises(
              query: 'barbell',
              muscleGroups: {MuscleGroup.chest},
              categories: const {},
              equipmentTypes: const {},
            )).thenAnswer((_) async => [chestExercise1]);

        return exerciseBloc;
      },
      seed: () => ExercisesLoaded(allExercises: testExercises),
      act: (bloc) async {
        bloc.add(const FilterByMuscleGroupsEvent({MuscleGroup.chest}));
        await Future.delayed(const Duration(milliseconds: 100));
        bloc.add(const SearchExercisesEvent('barbell'));
      },
      expect: () => [
        // After filtering by muscle group
        isA<ExercisesLoaded>().having(
            (state) => state.selectedMuscleGroups, 'muscle groups', {
          MuscleGroup.chest
        }).having(
            (state) => state.filteredExercises.length, 'filtered count', 2),
        // After searching
        isA<ExercisesLoaded>()
            .having((state) => state.searchQuery, 'search query', 'barbell')
            .having((state) => state.selectedMuscleGroups, 'muscle groups',
                {MuscleGroup.chest})
            .having(
                (state) => state.filteredExercises.length, 'filtered count', 1)
            .having((state) => state.filteredExercises.first.name, 'first name',
                'Barbell Bench Press'),
      ],
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'hasActiveFilters returns true when filters are active',
      build: () {
        when(() => mockSearchExercises(
              query: 'test',
              muscleGroups: any(named: 'muscleGroups'),
              categories: any(named: 'categories'),
              equipmentTypes: any(named: 'equipmentTypes'),
            )).thenAnswer((_) async => []);
        return exerciseBloc;
      },
      seed: () => ExercisesLoaded(allExercises: testExercises),
      act: (bloc) => bloc.add(const SearchExercisesEvent('test')),
      expect: () => [
        isA<ExercisesLoaded>().having(
            (state) => state.hasActiveFilters, 'has active filters', true),
      ],
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'resultCount returns correct filtered count',
      build: () {
        when(() => mockSearchExercises(
              query: any(named: 'query'),
              muscleGroups: any(named: 'muscleGroups'),
              categories: any(named: 'categories'),
              equipmentTypes: any(named: 'equipmentTypes'),
            )).thenAnswer((_) async => [chestExercise1, chestExercise2]);
        return exerciseBloc;
      },
      seed: () => ExercisesLoaded(allExercises: testExercises),
      act: (bloc) =>
          bloc.add(const FilterByMuscleGroupsEvent({MuscleGroup.chest})),
      expect: () => [
        isA<ExercisesLoaded>()
            .having((state) => state.resultCount, 'result count', 2),
      ],
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'does not filter when state is not ExercisesLoaded',
      build: () => exerciseBloc,
      seed: () => const ExerciseInitial(),
      act: (bloc) => bloc.add(const SearchExercisesEvent('test')),
      expect: () => [],
      verify: (_) {
        verifyNever(() => mockSearchExercises(
              query: any(named: 'query'),
              muscleGroups: any(named: 'muscleGroups'),
              categories: any(named: 'categories'),
              equipmentTypes: any(named: 'equipmentTypes'),
            ));
      },
    );

    blocTest<ExerciseBloc, ExerciseState>(
      'emits error when search fails',
      build: () {
        when(() => mockSearchExercises(
              query: any(named: 'query'),
              muscleGroups: any(named: 'muscleGroups'),
              categories: any(named: 'categories'),
              equipmentTypes: any(named: 'equipmentTypes'),
            )).thenThrow(Exception('Search failed'));
        return exerciseBloc;
      },
      seed: () => ExercisesLoaded(allExercises: testExercises),
      act: (bloc) => bloc.add(const SearchExercisesEvent('test')),
      expect: () => [
        isA<ExerciseError>().having((state) => state.message, 'error message',
            contains('Search failed')),
      ],
    );
  });
}
