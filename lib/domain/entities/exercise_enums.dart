/// Exercise muscle group classification
enum MuscleGroup {
  chest,
  back,
  shoulders,
  arms,
  legs,
  core;

  String get displayName {
    switch (this) {
      case MuscleGroup.chest:
        return 'Chest';
      case MuscleGroup.back:
        return 'Back';
      case MuscleGroup.shoulders:
        return 'Shoulders';
      case MuscleGroup.arms:
        return 'Arms';
      case MuscleGroup.legs:
        return 'Legs';
      case MuscleGroup.core:
        return 'Core';
    }
  }
}

/// Exercise category - compound vs isolation
enum ExerciseCategory {
  compound,
  isolation;

  String get displayName {
    switch (this) {
      case ExerciseCategory.compound:
        return 'Compound';
      case ExerciseCategory.isolation:
        return 'Isolation';
    }
  }
}

/// Equipment type used for exercise
enum EquipmentType {
  barbell,
  dumbbell,
  machine,
  bodyweight,
  cable;

  String get displayName {
    switch (this) {
      case EquipmentType.barbell:
        return 'Barbell';
      case EquipmentType.dumbbell:
        return 'Dumbbell';
      case EquipmentType.machine:
        return 'Machine';
      case EquipmentType.bodyweight:
        return 'Bodyweight';
      case EquipmentType.cable:
        return 'Cable';
    }
  }
}

