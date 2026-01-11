import 'package:flutter/material.dart';

/// App Color Palette - Single Source of Truth
/// Toutes les couleurs de l'app sont définies ici pour garantir l'uniformité
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // ==================== PRIMARY COLORS ====================
  /// Couleur principale de l'app (violet/bleu profond pour fitness premium)
  static const Color primary = Color(
    0xFF5E35B1,
  ); // Violet plus foncé pour meilleur contraste
  static const Color primaryLight = Color(0xFF8A7AB8);
  static const Color primaryDark = Color(0xFF4527A0); // Plus foncé

  /// Couleur secondaire (orange énergique pour l'action)
  static const Color secondary = Color(0xFFE65100); // Orange plus foncé
  static const Color secondaryLight = Color(0xFFFF8A65);
  static const Color secondaryDark = Color(0xFFBF360C); // Très foncé

  /// Couleur d'accent (vert pour les succès/progression)
  static const Color accent = Color(0xFF00A844); // Vert plus foncé
  static const Color accentLight = Color(0xFF69F0AE);
  static const Color accentDark = Color(0xFF00892F);

  // ==================== SEMANTIC COLORS ====================
  /// Succès (records, objectifs atteints)
  static const Color success = Color(0xFF4CAF50);
  static const Color successLight = Color(0xFF81C784);
  static const Color successDark = Color(0xFF388E3C);

  /// Erreur (échecs, erreurs)
  static const Color error = Color(0xFFE53935);
  static const Color errorLight = Color(0xFFEF5350);
  static const Color errorDark = Color(0xFFC62828);

  /// Attention (avertissements, temps restant)
  static const Color warning = Color(0xFFFF9800);
  static const Color warningLight = Color(0xFFFFB74D);
  static const Color warningDark = Color(0xFFF57C00);

  /// Information (conseils, astuces)
  static const Color info = Color(0xFF2196F3);
  static const Color infoLight = Color(0xFF64B5F6);
  static const Color infoDark = Color(0xFF1976D2);

  // ==================== MUSCLE GROUP COLORS ====================
  /// Couleurs distinctes par groupe musculaire pour les chips/badges
  static const Color muscleChest = Color(0xFFE57373); // Rouge corail
  static const Color muscleBack = Color(0xFF64B5F6); // Bleu clair
  static const Color muscleShoulders = Color(0xFFFFB74D); // Orange
  static const Color muscleLegs = Color(0xFF81C784); // Vert
  static const Color muscleArms = Color(0xFFBA68C8); // Violet
  static const Color muscleCore = Color(0xFFFFD54F); // Jaune
  static const Color muscleCardio = Color(0xFF4DD0E1); // Cyan
  static const Color muscleFullBody = Color(0xFFA1887F); // Brun
  static const Color muscleOther = Color(0xFF90A4AE); // Gris bleu

  // ==================== EQUIPMENT TYPE COLORS ====================
  /// Couleurs par type d'équipement
  static const Color equipmentBarbell = Color(0xFFF44336); // Rouge
  static const Color equipmentDumbbell = Color(0xFFFF9800); // Orange
  static const Color equipmentMachine = Color(0xFF9C27B0); // Violet
  static const Color equipmentBodyweight = Color(0xFF4CAF50); // Vert
  static const Color equipmentCable = Color(0xFF2196F3); // Bleu
  static const Color equipmentOther = Color(0xFF9E9E9E); // Gris

  // ==================== CATEGORY COLORS ====================
  /// Couleurs par catégorie d'exercice
  static const Color categoryCompound = Color(0xFF1976D2); // Bleu foncé
  static const Color categoryIsolation = Color(0xFF7B1FA2); // Violet foncé
  static const Color categoryCardio = Color(0xFFE64A19); // Orange foncé
  static const Color categoryStretching = Color(0xFF00897B); // Vert teal

  // ==================== NEUTRAL COLORS (Light Mode) ====================
  static const Color backgroundLight = Color(0xFFFAFAFA);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color cardLight = Color(0xFFFFFFFF);

  static const Color textPrimaryLight = Color(
    0xFF1A1A1A,
  ); // Presque noir pour meilleur contraste
  static const Color textSecondaryLight = Color(0xFF5F5F5F); // Gris plus foncé
  static const Color textDisabledLight = Color(0xFF9E9E9E); // Gris moyen

  static const Color borderLight = Color(0xFFD0D0D0); // Bordures plus visibles
  static const Color dividerLight = Color(0xFFE5E5E5);
  static const Color shadowLight = Color(0x1F000000);

  // ==================== NEUTRAL COLORS (Dark Mode) ====================
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF2C2C2C);

  static const Color textPrimaryDark = Color(0xFFE0E0E0);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  static const Color textDisabledDark = Color(0xFF6B6B6B);

  static const Color borderDark = Color(0xFF3A3A3A);
  static const Color dividerDark = Color(0xFF2A2A2A);
  static const Color shadowDark = Color(0x3F000000);

  // ==================== OVERLAY COLORS ====================
  /// Overlay pour shimmer loading
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);
  static const Color shimmerBaseDark = Color(0xFF2C2C2C);
  static const Color shimmerHighlightDark = Color(0xFF3A3A3A);

  /// Overlay pour bottom sheets, dialogs
  static const Color overlayLight = Color(0x80000000);
  static const Color overlayDark = Color(0xCC000000);

  /// Ripple effect color
  static const Color rippleLight = Color(0x1F000000);
  static const Color rippleDark = Color(0x3FFFFFFF);

  // ==================== TIMER SPECIFIC COLORS ====================
  /// Couleurs pour le timer (feature killer de l'app)
  static const Color timerActive = Color(0xFF4CAF50); // Vert en cours
  static const Color timerPaused = Color(0xFFFF9800); // Orange en pause
  static const Color timerAlmostDone = Color(0xFFFFEB3B); // Jaune presque fini
  static const Color timerDone = Color(0xFFF44336); // Rouge terminé

  // ==================== GRADIENT COLORS ====================
  /// Gradients pour les éléments premium (stats, records, etc.)
  static const List<Color> gradientPrimary = [
    Color(0xFF6750A4),
    Color(0xFF8A7AB8),
  ];

  static const List<Color> gradientSuccess = [
    Color(0xFF4CAF50),
    Color(0xFF81C784),
  ];

  static const List<Color> gradientEnergy = [
    Color(0xFFFF6B35),
    Color(0xFFFF8A65),
  ];

  // ==================== HELPER METHODS ====================

  /// Retourne la couleur associée à un groupe musculaire
  static Color getMuscleGroupColor(String muscleGroup) {
    switch (muscleGroup.toLowerCase()) {
      case 'chest':
      case 'pectoraux':
        return muscleChest;
      case 'back':
      case 'dos':
        return muscleBack;
      case 'shoulders':
      case 'epaules':
      case 'épaules':
        return muscleShoulders;
      case 'legs':
      case 'jambes':
        return muscleLegs;
      case 'arms':
      case 'bras':
        return muscleArms;
      case 'core':
      case 'abdominaux':
        return muscleCore;
      case 'cardio':
        return muscleCardio;
      case 'fullbody':
      case 'full body':
      case 'corps entier':
        return muscleFullBody;
      default:
        return muscleOther;
    }
  }

  /// Retourne la couleur associée à un type d'équipement
  static Color getEquipmentColor(String equipmentType) {
    switch (equipmentType.toLowerCase()) {
      case 'barbell':
      case 'barre':
        return equipmentBarbell;
      case 'dumbbell':
      case 'haltère':
      case 'haltere':
        return equipmentDumbbell;
      case 'machine':
        return equipmentMachine;
      case 'bodyweight':
      case 'poids du corps':
        return equipmentBodyweight;
      case 'cable':
      case 'câble':
        return equipmentCable;
      default:
        return equipmentOther;
    }
  }

  /// Retourne la couleur associée à une catégorie d'exercice
  static Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'compound':
      case 'polyarticulaire':
        return categoryCompound;
      case 'isolation':
        return categoryIsolation;
      case 'cardio':
        return categoryCardio;
      case 'stretching':
      case 'étirement':
      case 'etirement':
        return categoryStretching;
      default:
        return categoryCompound;
    }
  }

  /// Retourne une couleur avec opacité
  static Color withOpacity(Color color, double opacity) {
    return color.withValues(alpha: opacity);
  }
}
