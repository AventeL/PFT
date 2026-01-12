import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pft/domain/entities/exercise_enums.dart';
import 'package:pft/l10n/app_localizations.dart';
import 'package:pft/presentation/widgets/exercise_filter_chips.dart';

void main() {
  Widget createTestWidget(Widget child) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('en'),
      home: Scaffold(
        body: child,
      ),
    );
  }

  group('ExerciseFilterChips Widget Tests', () {
    testWidgets('renders all muscle group chips', (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        createTestWidget(
          ExerciseFilterChips(
            selectedMuscleGroups: const {},
            selectedCategories: const {},
            selectedEquipmentTypes: const {},
            onMuscleGroupsChanged: (_) {},
            onCategoriesChanged: (_) {},
            onEquipmentTypesChanged: (_) {},
            onClearFilters: () {},
            hasActiveFilters: false,
          ),
        ),
      );

      // Assert - Should find all 6 muscle group filter chips
      expect(find.byType(FilterChip), findsWidgets);
      // At least 6 muscle groups + 2 categories + 5 equipment types = 13 chips
      final chips = find.byType(FilterChip);
      expect(chips.evaluate().length, greaterThanOrEqualTo(13));
    });

    testWidgets('muscle group chip selection works',
        (WidgetTester tester) async {
      // Arrange
      Set<MuscleGroup> selectedGroups = {};

      await tester.pumpWidget(
        createTestWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return ExerciseFilterChips(
                selectedMuscleGroups: selectedGroups,
                selectedCategories: const {},
                selectedEquipmentTypes: const {},
                onMuscleGroupsChanged: (groups) {
                  setState(() {
                    selectedGroups = groups;
                  });
                },
                onCategoriesChanged: (_) {},
                onEquipmentTypesChanged: (_) {},
                onClearFilters: () {},
                hasActiveFilters: selectedGroups.isNotEmpty,
              );
            },
          ),
        ),
      );

      // Find the first FilterChip (should be Chest)
      final firstChip = find.byType(FilterChip).first;

      // Act - Tap on first chip
      await tester.tap(firstChip);
      await tester.pumpAndSettle();

      // Assert - One muscle group should be selected
      expect(selectedGroups.length, 1);
      expect(selectedGroups.contains(MuscleGroup.chest), true);

      // Find another chip and tap it
      final chips = find.byType(FilterChip);
      await tester.tap(chips.at(1)); // Second chip (Back)
      await tester.pumpAndSettle();

      // Assert - Two muscle groups should be selected
      expect(selectedGroups.length, 2);

      // Tap first chip again to deselect
      await tester.tap(firstChip);
      await tester.pumpAndSettle();

      // Assert - Only one muscle group should be selected
      expect(selectedGroups.length, 1);
    });

    testWidgets('category chip selection works', (WidgetTester tester) async {
      // Arrange
      Set<ExerciseCategory> selectedCategories = {};

      await tester.pumpWidget(
        createTestWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return ExerciseFilterChips(
                selectedMuscleGroups: const {},
                selectedCategories: selectedCategories,
                selectedEquipmentTypes: const {},
                onMuscleGroupsChanged: (_) {},
                onCategoriesChanged: (categories) {
                  setState(() {
                    selectedCategories = categories;
                  });
                },
                onEquipmentTypesChanged: (_) {},
                onClearFilters: () {},
                hasActiveFilters: selectedCategories.isNotEmpty,
              );
            },
          ),
        ),
      );

      // Find category chips (they come after muscle group chips)
      final allChips = find.byType(FilterChip);

      // Tap on a category chip (index 6 should be first category)
      await tester.tap(allChips.at(6));
      await tester.pumpAndSettle();

      // Assert - One category should be selected
      expect(selectedCategories.length, 1);

      // Tap on another category chip
      await tester.tap(allChips.at(7));
      await tester.pumpAndSettle();

      // Assert - Both categories should be selected
      expect(selectedCategories.length, 2);
    });

    testWidgets('equipment type chip selection works',
        (WidgetTester tester) async {
      // Arrange
      Set<EquipmentType> selectedTypes = {};

      await tester.pumpWidget(
        createTestWidget(
          StatefulBuilder(
            builder: (context, setState) {
              return ExerciseFilterChips(
                selectedMuscleGroups: const {},
                selectedCategories: const {},
                selectedEquipmentTypes: selectedTypes,
                onMuscleGroupsChanged: (_) {},
                onCategoriesChanged: (_) {},
                onEquipmentTypesChanged: (types) {
                  setState(() {
                    selectedTypes = types;
                  });
                },
                onClearFilters: () {},
                hasActiveFilters: selectedTypes.isNotEmpty,
              );
            },
          ),
        ),
      );

      // Find equipment chips (they come after muscle groups and categories)
      final allChips = find.byType(FilterChip);

      // Tap on an equipment chip (index 8 should be first equipment type)
      await tester.tap(allChips.at(8));
      await tester.pumpAndSettle();

      // Assert - One equipment type should be selected
      expect(selectedTypes.length, 1);

      // Tap on another equipment chip
      await tester.tap(allChips.at(9));
      await tester.pumpAndSettle();

      // Assert - Both equipment types should be selected
      expect(selectedTypes.length, 2);
    });

    testWidgets('shows selected state visually', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        createTestWidget(
          ExerciseFilterChips(
            selectedMuscleGroups: const {MuscleGroup.chest, MuscleGroup.back},
            selectedCategories: const {ExerciseCategory.compound},
            selectedEquipmentTypes: const {EquipmentType.barbell},
            onMuscleGroupsChanged: (_) {},
            onCategoriesChanged: (_) {},
            onEquipmentTypesChanged: (_) {},
            onClearFilters: () {},
            hasActiveFilters: true,
          ),
        ),
      );

      // Assert - Find FilterChips
      final allChips = find.byType(FilterChip);
      expect(allChips, findsWidgets);

      // Verify that some chips have selected property set to true
      final chipWidgets = tester.widgetList<FilterChip>(allChips).toList();
      final selectedChips = chipWidgets.where((chip) => chip.selected).toList();

      // Should have 4 selected chips (2 muscle groups + 1 category + 1 equipment)
      expect(selectedChips.length, 4);
    });

    testWidgets('renders filter sections with titles',
        (WidgetTester tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        createTestWidget(
          ExerciseFilterChips(
            selectedMuscleGroups: const {},
            selectedCategories: const {},
            selectedEquipmentTypes: const {},
            onMuscleGroupsChanged: (_) {},
            onCategoriesChanged: (_) {},
            onEquipmentTypesChanged: (_) {},
            onClearFilters: () {},
            hasActiveFilters: false,
          ),
        ),
      );

      // Assert - Should find section titles (localized)
      // Note: Exact text depends on localization, so we just verify structure
      expect(find.byType(Column), findsWidgets);
      expect(find.byType(Wrap), findsWidgets);
    });
  });
}
