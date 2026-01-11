import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../domain/entities/exercise_enums.dart';
import '../../l10n/app_localizations.dart';

/// Extension pour accéder facilement aux traductions via context
extension _LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Widget pour afficher les filtres d'exercices sous forme de chips
class ExerciseFilterChips extends StatelessWidget {
  final Set<MuscleGroup> selectedMuscleGroups;
  final Set<ExerciseCategory> selectedCategories;
  final Set<EquipmentType> selectedEquipmentTypes;
  final Function(Set<MuscleGroup>) onMuscleGroupsChanged;
  final Function(Set<ExerciseCategory>) onCategoriesChanged;
  final Function(Set<EquipmentType>) onEquipmentTypesChanged;
  final VoidCallback onClearFilters;
  final bool hasActiveFilters;

  const ExerciseFilterChips({
    super.key,
    required this.selectedMuscleGroups,
    required this.selectedCategories,
    required this.selectedEquipmentTypes,
    required this.onMuscleGroupsChanged,
    required this.onCategoriesChanged,
    required this.onEquipmentTypesChanged,
    required this.onClearFilters,
    required this.hasActiveFilters,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Muscle Groups
        _FilterSection(
          title: l10n.allMuscleGroups,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildMuscleGroupChip(context, MuscleGroup.chest),
              _buildMuscleGroupChip(context, MuscleGroup.back),
              _buildMuscleGroupChip(context, MuscleGroup.shoulders),
              _buildMuscleGroupChip(context, MuscleGroup.arms),
              _buildMuscleGroupChip(context, MuscleGroup.legs),
              _buildMuscleGroupChip(context, MuscleGroup.core),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Categories
        _FilterSection(
          title: l10n.allCategories,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildCategoryChip(context, ExerciseCategory.compound),
              _buildCategoryChip(context, ExerciseCategory.isolation),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Equipment Types
        _FilterSection(
          title: l10n.allEquipmentTypes,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildEquipmentChip(context, EquipmentType.barbell),
              _buildEquipmentChip(context, EquipmentType.dumbbell),
              _buildEquipmentChip(context, EquipmentType.machine),
              _buildEquipmentChip(context, EquipmentType.bodyweight),
              _buildEquipmentChip(context, EquipmentType.cable),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildMuscleGroupChip(BuildContext context, MuscleGroup group) {
    final l10n = context.l10n;
    final isSelected = selectedMuscleGroups.contains(group);

    String label;
    switch (group) {
      case MuscleGroup.chest:
        label = l10n.muscleGroupChest;
        break;
      case MuscleGroup.back:
        label = l10n.muscleGroupBack;
        break;
      case MuscleGroup.shoulders:
        label = l10n.muscleGroupShoulders;
        break;
      case MuscleGroup.arms:
        label = l10n.muscleGroupArms;
        break;
      case MuscleGroup.legs:
        label = l10n.muscleGroupLegs;
        break;
      case MuscleGroup.core:
        label = l10n.muscleGroupCore;
        break;
    }

    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? AppColors.primary
              : Theme.of(context).colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          fontSize: 14, // Taille fixe
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        final newSelection = Set<MuscleGroup>.from(selectedMuscleGroups);
        if (selected) {
          newSelection.add(group);
        } else {
          newSelection.remove(group);
        }
        onMuscleGroupsChanged(newSelection);
      },
      showCheckmark: false,
      backgroundColor: Colors.transparent,
      selectedColor: AppColors.primary.withValues(alpha: 0.2),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      side: isSelected
          ? const BorderSide(color: AppColors.primary, width: 2)
          : BorderSide(color: Colors.grey.withValues(alpha: 0.3), width: 2),
    );
  }

  Widget _buildCategoryChip(BuildContext context, ExerciseCategory category) {
    final l10n = context.l10n;
    final isSelected = selectedCategories.contains(category);

    String label;
    switch (category) {
      case ExerciseCategory.compound:
        label = l10n.categoryCompound;
        break;
      case ExerciseCategory.isolation:
        label = l10n.categoryIsolation;
        break;
    }

    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? AppColors.secondary
              : Theme.of(context).colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          fontSize: 14, // Taille fixe
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        final newSelection = Set<ExerciseCategory>.from(selectedCategories);
        if (selected) {
          newSelection.add(category);
        } else {
          newSelection.remove(category);
        }
        onCategoriesChanged(newSelection);
      },
      showCheckmark: false,
      backgroundColor: Colors.transparent,
      selectedColor: AppColors.secondary.withValues(alpha: 0.2),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      side: isSelected
          ? const BorderSide(color: AppColors.secondary, width: 2)
          : BorderSide(color: Colors.grey.withValues(alpha: 0.3), width: 2),
    );
  }

  Widget _buildEquipmentChip(BuildContext context, EquipmentType type) {
    final l10n = context.l10n;
    final isSelected = selectedEquipmentTypes.contains(type);

    String label;
    switch (type) {
      case EquipmentType.barbell:
        label = l10n.equipmentBarbell;
        break;
      case EquipmentType.dumbbell:
        label = l10n.equipmentDumbbell;
        break;
      case EquipmentType.machine:
        label = l10n.equipmentMachine;
        break;
      case EquipmentType.bodyweight:
        label = l10n.equipmentBodyweight;
        break;
      case EquipmentType.cable:
        label = l10n.equipmentCable;
        break;
    }

    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected
              ? AppColors.accent
              : Theme.of(context).colorScheme.onSurface,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          fontSize: 14, // Taille fixe
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        final newSelection = Set<EquipmentType>.from(selectedEquipmentTypes);
        if (selected) {
          newSelection.add(type);
        } else {
          newSelection.remove(type);
        }
        onEquipmentTypesChanged(newSelection);
      },
      showCheckmark: false,
      backgroundColor: Colors.transparent,
      selectedColor: AppColors.accent.withValues(alpha: 0.2),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      side: isSelected
          ? const BorderSide(color: AppColors.accent, width: 2)
          : BorderSide(color: Colors.grey.withValues(alpha: 0.3), width: 2),
    );
  }
}

/// Section de filtres avec titre
class _FilterSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _FilterSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: child,
        ),
      ],
    );
  }
}
