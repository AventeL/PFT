import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/exercise.dart';
import '../../../l10n/app_localizations.dart';

/// Extension pour accéder facilement aux traductions via context
extension _LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Widget to display a single exercise item in a list
class ExerciseListItem extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback? onTap;

  const ExerciseListItem({super.key, required this.exercise, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Equipment icon
              _buildEquipmentIcon(),
              const SizedBox(width: 12),

              // Exercise details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exercise.name, style: AppTextStyles.exerciseName),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildChip(
                          _getMuscleGroupName(
                            context,
                            exercise.muscleGroup.name,
                          ),
                          AppColors.getMuscleGroupColor(
                            exercise.muscleGroup.name,
                          ),
                        ),
                        _buildChip(
                          _getCategoryName(
                            context,
                            exercise.category.name,
                          ),
                          AppColors.getCategoryColor(exercise.category.name),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Custom badge if applicable
              if (exercise.isCustom)
                Chip(
                  label: Text(context.l10n.customExercise,
                      style: AppTextStyles.caption),
                  backgroundColor: AppColors.secondary.withValues(alpha: 0.2),
                  padding: EdgeInsets.zero,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEquipmentIcon() {
    IconData iconData;
    Color color = AppColors.getEquipmentColor(exercise.equipmentType.name);

    switch (exercise.equipmentType) {
      case var type when type.name == 'barbell':
        iconData = Icons.fitness_center;
        break;
      case var type when type.name == 'dumbbell':
        iconData = Icons.fitness_center;
        break;
      case var type when type.name == 'machine':
        iconData = Icons.settings;
        break;
      case var type when type.name == 'bodyweight':
        iconData = Icons.accessibility_new;
        break;
      case var type when type.name == 'cable':
        iconData = Icons.cable;
        break;
      default:
        iconData = Icons.help;
    }

    return CircleAvatar(
      backgroundColor: color.withValues(alpha: 0.2),
      child: Icon(iconData, color: color, size: 20),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Chip(
      label: Text(
        label,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
      backgroundColor: color.withValues(alpha: 0.15),
      side: BorderSide(color: color, width: 1),
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  String _getMuscleGroupName(BuildContext context, String muscleGroup) {
    final l10n = context.l10n;
    return switch (muscleGroup.toLowerCase()) {
      'chest' => l10n.muscleGroupChest,
      'back' => l10n.muscleGroupBack,
      'shoulders' => l10n.muscleGroupShoulders,
      'legs' => l10n.muscleGroupLegs,
      'arms' => l10n.muscleGroupArms,
      'core' => l10n.muscleGroupCore,
      'cardio' => l10n.muscleGroupCardio,
      'fullbody' || 'full body' => l10n.muscleGroupFullBody,
      _ => l10n.muscleGroupOther,
    };
  }

  String _getCategoryName(BuildContext context, String category) {
    final l10n = context.l10n;
    return switch (category.toLowerCase()) {
      'compound' => l10n.categoryCompound,
      'isolation' => l10n.categoryIsolation,
      'cardio' => l10n.categoryCardio,
      'stretching' => l10n.categoryStretching,
      _ => l10n.categoryCompound,
    };
  }
}
