import 'package:flutter_test/flutter_test.dart';
import 'package:pft/data/models/exercise_model.dart';
import 'package:pft/domain/entities/exercise.dart';
import 'package:pft/domain/entities/exercise_enums.dart';

void main() {
  group('ExerciseModel', () {
    final testDateTime = DateTime(2026, 1, 1);

    final testExercise = Exercise(
      id: 'test-id',
      name: 'Bench Press',
      muscleGroup: MuscleGroup.chest,
      category: ExerciseCategory.compound,
      equipmentType: EquipmentType.barbell,
      isCustom: false,
      instructions: 'Test instructions',
      createdAt: testDateTime,
    );

    final testModel = ExerciseModel(
      id: 'test-id',
      name: 'Bench Press',
      muscleGroup: 'chest',
      category: 'compound',
      equipmentType: 'barbell',
      isCustom: false,
      instructions: 'Test instructions',
      createdAt: testDateTime,
    );

    final testJson = {
      'id': 'test-id',
      'name': 'Bench Press',
      'muscleGroup': 'chest',
      'category': 'compound',
      'equipmentType': 'barbell',
      'isCustom': false,
      'instructions': 'Test instructions',
      'createdAt': '2026-01-01T00:00:00.000',
    };

    final testMap = {
      'id': 'test-id',
      'name': 'Bench Press',
      'muscle_group': 'chest',
      'category': 'compound',
      'equipment_type': 'barbell',
      'is_custom': 0,
      'instructions': 'Test instructions',
      'created_at': testDateTime.millisecondsSinceEpoch,
    };

    group('fromJson', () {
      test('should deserialize from JSON correctly', () {
        // Act
        final model = ExerciseModel.fromJson(testJson);

        // Assert
        expect(model.id, 'test-id');
        expect(model.name, 'Bench Press');
        expect(model.muscleGroup, 'chest');
        expect(model.category, 'compound');
        expect(model.equipmentType, 'barbell');
        expect(model.isCustom, false);
        expect(model.instructions, 'Test instructions');
      });

      test('should handle missing isCustom field', () {
        // Arrange
        final jsonWithoutCustom = Map<String, dynamic>.from(testJson);
        jsonWithoutCustom.remove('isCustom');

        // Act
        final model = ExerciseModel.fromJson(jsonWithoutCustom);

        // Assert
        expect(model.isCustom, false);
      });

      test('should handle null instructions', () {
        // Arrange
        final jsonWithNullInstructions = Map<String, dynamic>.from(testJson);
        jsonWithNullInstructions['instructions'] = null;

        // Act
        final model = ExerciseModel.fromJson(jsonWithNullInstructions);

        // Assert
        expect(model.instructions, null);
      });
    });

    group('toJson', () {
      test('should serialize to JSON correctly', () {
        // Act
        final json = testModel.toJson();

        // Assert
        expect(json['id'], 'test-id');
        expect(json['name'], 'Bench Press');
        expect(json['muscleGroup'], 'chest');
        expect(json['category'], 'compound');
        expect(json['equipmentType'], 'barbell');
        expect(json['isCustom'], false);
        expect(json['instructions'], 'Test instructions');
        expect(json['createdAt'], testDateTime.toIso8601String());
      });
    });

    group('fromMap', () {
      test('should deserialize from database map correctly', () {
        // Act
        final model = ExerciseModel.fromMap(testMap);

        // Assert
        expect(model.id, 'test-id');
        expect(model.name, 'Bench Press');
        expect(model.muscleGroup, 'chest');
        expect(model.category, 'compound');
        expect(model.equipmentType, 'barbell');
        expect(model.isCustom, false);
        expect(model.instructions, 'Test instructions');
        expect(model.createdAt, testDateTime);
      });

      test('should handle isCustom as 1 (true)', () {
        // Arrange
        final mapWithCustom = Map<String, dynamic>.from(testMap);
        mapWithCustom['is_custom'] = 1;

        // Act
        final model = ExerciseModel.fromMap(mapWithCustom);

        // Assert
        expect(model.isCustom, true);
      });
    });

    group('toMap', () {
      test('should serialize to database map correctly', () {
        // Act
        final map = testModel.toMap();

        // Assert
        expect(map['id'], 'test-id');
        expect(map['name'], 'Bench Press');
        expect(map['muscle_group'], 'chest');
        expect(map['category'], 'compound');
        expect(map['equipment_type'], 'barbell');
        expect(map['is_custom'], 0);
        expect(map['instructions'], 'Test instructions');
        expect(map['created_at'], testDateTime.millisecondsSinceEpoch);
      });

      test('should convert isCustom true to 1', () {
        // Arrange
        final customModel = ExerciseModel(
          id: 'test-id',
          name: 'Custom Exercise',
          muscleGroup: 'chest',
          category: 'compound',
          equipmentType: 'barbell',
          isCustom: true,
          createdAt: testDateTime,
        );

        // Act
        final map = customModel.toMap();

        // Assert
        expect(map['is_custom'], 1);
      });
    });

    group('fromEntity', () {
      test('should convert from Exercise entity correctly', () {
        // Act
        final model = ExerciseModel.fromEntity(testExercise);

        // Assert
        expect(model.id, testExercise.id);
        expect(model.name, testExercise.name);
        expect(model.muscleGroup, testExercise.muscleGroup.name);
        expect(model.category, testExercise.category.name);
        expect(model.equipmentType, testExercise.equipmentType.name);
        expect(model.isCustom, testExercise.isCustom);
        expect(model.instructions, testExercise.instructions);
        expect(model.createdAt, testExercise.createdAt);
      });
    });

    group('toEntity', () {
      test('should convert to Exercise entity correctly', () {
        // Act
        final entity = testModel.toEntity();

        // Assert
        expect(entity.id, testModel.id);
        expect(entity.name, testModel.name);
        expect(entity.muscleGroup, MuscleGroup.chest);
        expect(entity.category, ExerciseCategory.compound);
        expect(entity.equipmentType, EquipmentType.barbell);
        expect(entity.isCustom, testModel.isCustom);
        expect(entity.instructions, testModel.instructions);
        expect(entity.createdAt, testModel.createdAt);
      });

      test('should parse all muscle groups correctly', () {
        final muscleGroups = ['chest', 'back', 'shoulders', 'arms', 'legs', 'core'];
        final expected = [
          MuscleGroup.chest,
          MuscleGroup.back,
          MuscleGroup.shoulders,
          MuscleGroup.arms,
          MuscleGroup.legs,
          MuscleGroup.core,
        ];

        for (var i = 0; i < muscleGroups.length; i++) {
          final model = ExerciseModel(
            id: 'test-id',
            name: 'Test',
            muscleGroup: muscleGroups[i],
            category: 'compound',
            equipmentType: 'barbell',
            isCustom: false,
            createdAt: testDateTime,
          );

          final entity = model.toEntity();
          expect(entity.muscleGroup, expected[i]);
        }
      });
    });
  });
}

