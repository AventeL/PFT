import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pft/domain/entities/exercise.dart';
import 'package:pft/domain/entities/exercise_enums.dart';
import 'package:pft/presentation/widgets/exercise_list_item.dart';

void main() {
  group('ExerciseListItem Widget Tests', () {
    testWidgets('displays exercise name', (WidgetTester tester) async {
      // Arrange
      final exercise = Exercise(
        id: '1',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExerciseListItem(exercise: exercise),
          ),
        ),
      );

      // Assert
      expect(find.text('Bench Press'), findsOneWidget);
    });

    testWidgets('displays muscle group badge', (WidgetTester tester) async {
      // Arrange
      final exercise = Exercise(
        id: '1',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExerciseListItem(exercise: exercise),
          ),
        ),
      );

      // Assert
      expect(find.text('Chest'), findsOneWidget);
    });

    testWidgets('displays category badge', (WidgetTester tester) async {
      // Arrange
      final exercise = Exercise(
        id: '1',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExerciseListItem(exercise: exercise),
          ),
        ),
      );

      // Assert
      expect(find.text('Compound'), findsOneWidget);
    });

    testWidgets('displays custom badge for custom exercises',
        (WidgetTester tester) async {
      // Arrange
      final exercise = Exercise(
        id: '1',
        name: 'Custom Exercise',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.isolation,
        equipmentType: EquipmentType.dumbbell,
        isCustom: true,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExerciseListItem(exercise: exercise),
          ),
        ),
      );

      // Assert
      expect(find.text('Custom'), findsOneWidget);
    });

    testWidgets('does not display custom badge for pre-loaded exercises',
        (WidgetTester tester) async {
      // Arrange
      final exercise = Exercise(
        id: '1',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExerciseListItem(exercise: exercise),
          ),
        ),
      );

      // Assert
      expect(find.text('Custom'), findsNothing);
    });

    testWidgets('displays equipment icon', (WidgetTester tester) async {
      // Arrange
      final exercise = Exercise(
        id: '1',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExerciseListItem(exercise: exercise),
          ),
        ),
      );

      // Assert
      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.byIcon(Icons.fitness_center), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (WidgetTester tester) async {
      // Arrange
      var tapped = false;
      final exercise = Exercise(
        id: '1',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExerciseListItem(
              exercise: exercise,
              onTap: () {
                tapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ExerciseListItem));
      await tester.pump();

      // Assert
      expect(tapped, true);
    });

    testWidgets('displays all equipment types correctly',
        (WidgetTester tester) async {
      // Test all equipment types
      final equipmentTypes = [
        EquipmentType.barbell,
        EquipmentType.dumbbell,
        EquipmentType.machine,
        EquipmentType.bodyweight,
        EquipmentType.cable,
      ];

      for (final equipmentType in equipmentTypes) {
        final exercise = Exercise(
          id: '1',
          name: 'Test Exercise',
          muscleGroup: MuscleGroup.chest,
          category: ExerciseCategory.compound,
          equipmentType: equipmentType,
          isCustom: false,
          createdAt: DateTime.now(),
        );

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ExerciseListItem(exercise: exercise),
            ),
          ),
        );

        // Should display an icon for each equipment type
        expect(find.byType(CircleAvatar), findsOneWidget);

        // Clear the widget tree for next iteration
        await tester.pumpWidget(Container());
      }
    });

    testWidgets('displays isolation category correctly',
        (WidgetTester tester) async {
      // Arrange
      final exercise = Exercise(
        id: '1',
        name: 'Bicep Curls',
        muscleGroup: MuscleGroup.arms,
        category: ExerciseCategory.isolation,
        equipmentType: EquipmentType.dumbbell,
        isCustom: false,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExerciseListItem(exercise: exercise),
          ),
        ),
      );

      // Assert
      expect(find.text('Isolation'), findsOneWidget);
    });

    testWidgets('displays card with proper styling',
        (WidgetTester tester) async {
      // Arrange
      final exercise = Exercise(
        id: '1',
        name: 'Bench Press',
        muscleGroup: MuscleGroup.chest,
        category: ExerciseCategory.compound,
        equipmentType: EquipmentType.barbell,
        isCustom: false,
        createdAt: DateTime.now(),
      );

      // Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ExerciseListItem(exercise: exercise),
          ),
        ),
      );

      // Assert
      expect(find.byType(Card), findsOneWidget);
      expect(find.byType(InkWell), findsWidgets); // Multiple InkWells (Card + potential Chips)
    });
  });
}

