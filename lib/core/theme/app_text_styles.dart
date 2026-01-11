import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Styles de texte de l'application
/// Utilise Google Fonts (Poppins) pour un look moderne et professionnel
class AppTextStyles {
  AppTextStyles._(); // Private constructor

  // Font Family (utilise Poppins via Google Fonts)
  static String get _fontFamily => GoogleFonts.poppins().fontFamily!;

  // ==================== HEADINGS ====================

  /// H1 - Très grand titre (ex: écrans d'onboarding, splash)
  static TextStyle get h1 => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.2,
  );

  /// H2 - Grand titre (ex: titre de page principale)
  static TextStyle get h2 => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.3,
    height: 1.3,
  );

  /// H3 - Titre moyen (ex: AppBar titles, section headers)
  static TextStyle get h3 => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.3,
  );

  /// H4 - Petit titre (ex: card titles, dialog titles)
  static TextStyle get h4 => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.4,
  );

  /// H5 - Très petit titre (ex: list item titles)
  static TextStyle get h5 => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.4,
  );

  // ==================== SUBTITLES ====================

  /// Subtitle 1 - Grand sous-titre
  static TextStyle get subtitle1 => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
    height: 1.5,
  );

  /// Subtitle 2 - Petit sous-titre
  static TextStyle get subtitle2 => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
  );

  // ==================== BODY TEXT ====================

  /// Body 1 - Texte de corps principal
  static TextStyle get body1 => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.5,
    height: 1.5,
  );

  /// Body 2 - Texte de corps secondaire (plus petit)
  static TextStyle get body2 => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
    height: 1.4,
  );

  // ==================== BUTTONS ====================

  /// Button - Texte des boutons
  static TextStyle get button => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.25,
    height: 1.0,
  );

  // ==================== SMALL TEXT ====================

  /// Caption - Texte de légende (très petit)
  static TextStyle get caption => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
    height: 1.3,
  );

  /// Overline - Texte en majuscules (très petit, labels)
  static TextStyle get overline => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    height: 1.0,
  );

  // ==================== SPECIALIZED STYLES ====================

  /// Timer Display - Pour l'affichage du timer (large et mono)
  static TextStyle get timerDisplay => TextStyle(
    fontFamily: GoogleFonts.robotoMono().fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.bold,
    letterSpacing: 2,
    height: 1.0,
  );

  /// Stats Number - Pour les chiffres de stats (gras et grand)
  static TextStyle get statsNumber => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.5,
    height: 1.0,
  );

  /// Exercise Name - Pour les noms d'exercices (lisible, clair)
  static TextStyle get exerciseName => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.3,
  );

  /// Set Input - Pour l'entrée de sets (mono, lisible)
  static TextStyle get setInput => TextStyle(
    fontFamily: GoogleFonts.robotoMono().fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w500,
    letterSpacing: 1,
    height: 1.2,
  );

  // ==================== HELPER METHODS ====================

  /// Retourne une copie du style avec une couleur spécifique
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  /// Retourne une copie du style avec un poids spécifique
  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  /// Retourne une copie du style avec une taille spécifique
  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }
}
