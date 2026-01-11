import 'package:flutter/material.dart';
import '../../../domain/entities/exercise.dart';

/// Widget to display a single exercise item in a list
class ExerciseListItem extends StatelessWidget {
  final Exercise exercise;
  final VoidCallback? onTap;

  const ExerciseListItem({
    super.key,
    required this.exercise,
    this.onTap,
  });

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
                    Text(
                      exercise.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      children: [
                        _buildChip(
                          exercise.muscleGroup.displayName,
                          Colors.blue,
                        ),
                        _buildChip(
                          exercise.category.displayName,
                          Colors.green,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Custom badge if applicable
              if (exercise.isCustom)
                const Chip(
                  label: Text('Custom', style: TextStyle(fontSize: 10)),
                  backgroundColor: Colors.orange,
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
    Color color;

    switch (exercise.equipmentType) {
      case var type when type.name == 'barbell':
        iconData = Icons.fitness_center;
        color = Colors.red;
        break;
      case var type when type.name == 'dumbbell':
        iconData = Icons.fitness_center;
        color = Colors.orange;
        break;
      case var type when type.name == 'machine':
        iconData = Icons.settings;
        color = Colors.purple;
        break;
      case var type when type.name == 'bodyweight':
        iconData = Icons.accessibility_new;
        color = Colors.green;
        break;
      case var type when type.name == 'cable':
        iconData = Icons.cable;
        color = Colors.blue;
        break;
      default:
        iconData = Icons.help;
        color = Colors.grey;
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
        style: const TextStyle(fontSize: 11),
      ),
      backgroundColor: color.withValues(alpha: 0.2),
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }
}

