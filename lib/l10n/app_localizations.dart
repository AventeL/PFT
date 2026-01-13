import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// Nom court de l'application
  ///
  /// In fr, this message translates to:
  /// **'PFT'**
  String get appName;

  /// Nom complet de l'application
  ///
  /// In fr, this message translates to:
  /// **'Performance Fitness Tracker'**
  String get appFullName;

  /// No description provided for @loading.
  ///
  /// In fr, this message translates to:
  /// **'Chargement...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In fr, this message translates to:
  /// **'Erreur'**
  String get error;

  /// No description provided for @success.
  ///
  /// In fr, this message translates to:
  /// **'Succès'**
  String get success;

  /// No description provided for @cancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get confirm;

  /// No description provided for @save.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get delete;

  /// No description provided for @edit.
  ///
  /// In fr, this message translates to:
  /// **'Modifier'**
  String get edit;

  /// No description provided for @add.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter'**
  String get add;

  /// No description provided for @search.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher'**
  String get search;

  /// No description provided for @filter.
  ///
  /// In fr, this message translates to:
  /// **'Filtrer'**
  String get filter;

  /// No description provided for @clear.
  ///
  /// In fr, this message translates to:
  /// **'Effacer'**
  String get clear;

  /// No description provided for @apply.
  ///
  /// In fr, this message translates to:
  /// **'Appliquer'**
  String get apply;

  /// No description provided for @close.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get close;

  /// No description provided for @back.
  ///
  /// In fr, this message translates to:
  /// **'Retour'**
  String get back;

  /// No description provided for @next.
  ///
  /// In fr, this message translates to:
  /// **'Suivant'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In fr, this message translates to:
  /// **'Précédent'**
  String get previous;

  /// No description provided for @done.
  ///
  /// In fr, this message translates to:
  /// **'Terminé'**
  String get done;

  /// No description provided for @skip.
  ///
  /// In fr, this message translates to:
  /// **'Passer'**
  String get skip;

  /// No description provided for @exercises.
  ///
  /// In fr, this message translates to:
  /// **'Exercices'**
  String get exercises;

  /// No description provided for @exerciseList.
  ///
  /// In fr, this message translates to:
  /// **'Liste des exercices'**
  String get exerciseList;

  /// No description provided for @exerciseDetails.
  ///
  /// In fr, this message translates to:
  /// **'Détails de l\'exercice'**
  String get exerciseDetails;

  /// No description provided for @searchExercises.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher un exercice'**
  String get searchExercises;

  /// No description provided for @filterExercises.
  ///
  /// In fr, this message translates to:
  /// **'Filtrer les exercices'**
  String get filterExercises;

  /// No description provided for @noExercisesFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucun exercice trouvé'**
  String get noExercisesFound;

  /// No description provided for @exerciseCount.
  ///
  /// In fr, this message translates to:
  /// **'exercices'**
  String get exerciseCount;

  /// No description provided for @customExercise.
  ///
  /// In fr, this message translates to:
  /// **'Personnalisé'**
  String get customExercise;

  /// No description provided for @addCustomExercise.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un exercice personnalisé'**
  String get addCustomExercise;

  /// No description provided for @exerciseName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de l\'exercice'**
  String get exerciseName;

  /// No description provided for @exerciseDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get exerciseDescription;

  /// No description provided for @exerciseInstructions.
  ///
  /// In fr, this message translates to:
  /// **'Instructions'**
  String get exerciseInstructions;

  /// No description provided for @muscleGroupChest.
  ///
  /// In fr, this message translates to:
  /// **'Pectoraux'**
  String get muscleGroupChest;

  /// No description provided for @muscleGroupBack.
  ///
  /// In fr, this message translates to:
  /// **'Dos'**
  String get muscleGroupBack;

  /// No description provided for @muscleGroupShoulders.
  ///
  /// In fr, this message translates to:
  /// **'Épaules'**
  String get muscleGroupShoulders;

  /// No description provided for @muscleGroupLegs.
  ///
  /// In fr, this message translates to:
  /// **'Jambes'**
  String get muscleGroupLegs;

  /// No description provided for @muscleGroupArms.
  ///
  /// In fr, this message translates to:
  /// **'Bras'**
  String get muscleGroupArms;

  /// No description provided for @muscleGroupCore.
  ///
  /// In fr, this message translates to:
  /// **'Abdominaux'**
  String get muscleGroupCore;

  /// No description provided for @muscleGroupCardio.
  ///
  /// In fr, this message translates to:
  /// **'Cardio'**
  String get muscleGroupCardio;

  /// No description provided for @muscleGroupFullBody.
  ///
  /// In fr, this message translates to:
  /// **'Corps entier'**
  String get muscleGroupFullBody;

  /// No description provided for @muscleGroupOther.
  ///
  /// In fr, this message translates to:
  /// **'Autre'**
  String get muscleGroupOther;

  /// No description provided for @allMuscleGroups.
  ///
  /// In fr, this message translates to:
  /// **'Tous les groupes'**
  String get allMuscleGroups;

  /// No description provided for @equipmentBarbell.
  ///
  /// In fr, this message translates to:
  /// **'Barre'**
  String get equipmentBarbell;

  /// No description provided for @equipmentDumbbell.
  ///
  /// In fr, this message translates to:
  /// **'Haltères'**
  String get equipmentDumbbell;

  /// No description provided for @equipmentMachine.
  ///
  /// In fr, this message translates to:
  /// **'Machine'**
  String get equipmentMachine;

  /// No description provided for @equipmentBodyweight.
  ///
  /// In fr, this message translates to:
  /// **'Poids du corps'**
  String get equipmentBodyweight;

  /// No description provided for @equipmentCable.
  ///
  /// In fr, this message translates to:
  /// **'Câble'**
  String get equipmentCable;

  /// No description provided for @equipmentOther.
  ///
  /// In fr, this message translates to:
  /// **'Autre'**
  String get equipmentOther;

  /// No description provided for @allEquipmentTypes.
  ///
  /// In fr, this message translates to:
  /// **'Tous les équipements'**
  String get allEquipmentTypes;

  /// No description provided for @categoryCompound.
  ///
  /// In fr, this message translates to:
  /// **'Polyarticulaire'**
  String get categoryCompound;

  /// No description provided for @categoryIsolation.
  ///
  /// In fr, this message translates to:
  /// **'Isolation'**
  String get categoryIsolation;

  /// No description provided for @categoryCardio.
  ///
  /// In fr, this message translates to:
  /// **'Cardio'**
  String get categoryCardio;

  /// No description provided for @categoryStretching.
  ///
  /// In fr, this message translates to:
  /// **'Étirement'**
  String get categoryStretching;

  /// No description provided for @allCategories.
  ///
  /// In fr, this message translates to:
  /// **'Toutes les catégories'**
  String get allCategories;

  /// No description provided for @workouts.
  ///
  /// In fr, this message translates to:
  /// **'Entraînements'**
  String get workouts;

  /// No description provided for @myWorkouts.
  ///
  /// In fr, this message translates to:
  /// **'Mes entraînements'**
  String get myWorkouts;

  /// No description provided for @createWorkout.
  ///
  /// In fr, this message translates to:
  /// **'Créer un entraînement'**
  String get createWorkout;

  /// No description provided for @newWorkout.
  ///
  /// In fr, this message translates to:
  /// **'Nouvel entraînement'**
  String get newWorkout;

  /// No description provided for @editWorkout.
  ///
  /// In fr, this message translates to:
  /// **'Modifier l\'entraînement'**
  String get editWorkout;

  /// No description provided for @deleteWorkout.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer l\'entraînement'**
  String get deleteWorkout;

  /// No description provided for @duplicateWorkout.
  ///
  /// In fr, this message translates to:
  /// **'Dupliquer l\'entraînement'**
  String get duplicateWorkout;

  /// No description provided for @workoutName.
  ///
  /// In fr, this message translates to:
  /// **'Nom de l\'entraînement'**
  String get workoutName;

  /// No description provided for @workoutNameHint.
  ///
  /// In fr, this message translates to:
  /// **'Ex: Push Day, Jambes, etc.'**
  String get workoutNameHint;

  /// No description provided for @workoutNameRequired.
  ///
  /// In fr, this message translates to:
  /// **'Le nom de l\'entraînement est requis'**
  String get workoutNameRequired;

  /// No description provided for @workoutNameTooLong.
  ///
  /// In fr, this message translates to:
  /// **'Le nom ne peut pas dépasser 100 caractères'**
  String get workoutNameTooLong;

  /// No description provided for @workoutDescription.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get workoutDescription;

  /// No description provided for @description.
  ///
  /// In fr, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @descriptionHint.
  ///
  /// In fr, this message translates to:
  /// **'Décrivez votre entraînement (optionnel)'**
  String get descriptionHint;

  /// No description provided for @workoutNotes.
  ///
  /// In fr, this message translates to:
  /// **'Notes'**
  String get workoutNotes;

  /// No description provided for @notes.
  ///
  /// In fr, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @notesHint.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez des notes (optionnel)'**
  String get notesHint;

  /// No description provided for @workoutTemplates.
  ///
  /// In fr, this message translates to:
  /// **'Modèles d\'entraînement'**
  String get workoutTemplates;

  /// No description provided for @templates.
  ///
  /// In fr, this message translates to:
  /// **'Templates'**
  String get templates;

  /// No description provided for @templateList.
  ///
  /// In fr, this message translates to:
  /// **'Liste des templates'**
  String get templateList;

  /// No description provided for @useThisTemplate.
  ///
  /// In fr, this message translates to:
  /// **'Utiliser ce template'**
  String get useThisTemplate;

  /// No description provided for @noTemplatesAvailable.
  ///
  /// In fr, this message translates to:
  /// **'Aucun template disponible'**
  String get noTemplatesAvailable;

  /// No description provided for @errorLoadingTemplates.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement des templates'**
  String get errorLoadingTemplates;

  /// No description provided for @retry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get retry;

  /// No description provided for @exercisesCount.
  ///
  /// In fr, this message translates to:
  /// **'{count} exercices'**
  String exercisesCount(int count);

  /// No description provided for @noWorkoutsFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucun entraînement trouvé'**
  String get noWorkoutsFound;

  /// No description provided for @workoutNeedsExercises.
  ///
  /// In fr, this message translates to:
  /// **'Ajoutez au moins un exercice'**
  String get workoutNeedsExercises;

  /// No description provided for @addExercise.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter un exercice'**
  String get addExercise;

  /// No description provided for @addExercises.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter des exercices'**
  String get addExercises;

  /// No description provided for @removeExercise.
  ///
  /// In fr, this message translates to:
  /// **'Retirer l\'exercice'**
  String get removeExercise;

  /// No description provided for @reorderExercises.
  ///
  /// In fr, this message translates to:
  /// **'Réorganiser les exercices'**
  String get reorderExercises;

  /// No description provided for @noExercisesAdded.
  ///
  /// In fr, this message translates to:
  /// **'Aucun exercice ajouté'**
  String get noExercisesAdded;

  /// No description provided for @tapToAddExercises.
  ///
  /// In fr, this message translates to:
  /// **'Appuyez sur + pour ajouter des exercices'**
  String get tapToAddExercises;

  /// No description provided for @unknownExercise.
  ///
  /// In fr, this message translates to:
  /// **'Exercice inconnu'**
  String get unknownExercise;

  /// No description provided for @startWorkout.
  ///
  /// In fr, this message translates to:
  /// **'Démarrer l\'entraînement'**
  String get startWorkout;

  /// No description provided for @continueWorkout.
  ///
  /// In fr, this message translates to:
  /// **'Continuer l\'entraînement'**
  String get continueWorkout;

  /// No description provided for @finishWorkout.
  ///
  /// In fr, this message translates to:
  /// **'Terminer l\'entraînement'**
  String get finishWorkout;

  /// No description provided for @abandonWorkout.
  ///
  /// In fr, this message translates to:
  /// **'Abandonner l\'entraînement'**
  String get abandonWorkout;

  /// No description provided for @workoutInProgress.
  ///
  /// In fr, this message translates to:
  /// **'Entraînement en cours'**
  String get workoutInProgress;

  /// No description provided for @workoutCompleted.
  ///
  /// In fr, this message translates to:
  /// **'Entraînement terminé !'**
  String get workoutCompleted;

  /// No description provided for @workoutAbandoned.
  ///
  /// In fr, this message translates to:
  /// **'Entraînement abandonné'**
  String get workoutAbandoned;

  /// No description provided for @confirmAbandon.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr de vouloir abandonner cet entraînement ?'**
  String get confirmAbandon;

  /// No description provided for @confirmFinish.
  ///
  /// In fr, this message translates to:
  /// **'Êtes-vous sûr d\'avoir terminé cet entraînement ?'**
  String get confirmFinish;

  /// No description provided for @sets.
  ///
  /// In fr, this message translates to:
  /// **'Séries'**
  String get sets;

  /// No description provided for @reps.
  ///
  /// In fr, this message translates to:
  /// **'Répétitions'**
  String get reps;

  /// No description provided for @weight.
  ///
  /// In fr, this message translates to:
  /// **'Poids'**
  String get weight;

  /// No description provided for @addSet.
  ///
  /// In fr, this message translates to:
  /// **'Ajouter une série'**
  String get addSet;

  /// No description provided for @removeSet.
  ///
  /// In fr, this message translates to:
  /// **'Retirer la série'**
  String get removeSet;

  /// No description provided for @set.
  ///
  /// In fr, this message translates to:
  /// **'Série'**
  String get set;

  /// No description provided for @kg.
  ///
  /// In fr, this message translates to:
  /// **'kg'**
  String get kg;

  /// No description provided for @lbs.
  ///
  /// In fr, this message translates to:
  /// **'lbs'**
  String get lbs;

  /// No description provided for @completed.
  ///
  /// In fr, this message translates to:
  /// **'Complété'**
  String get completed;

  /// No description provided for @skipped.
  ///
  /// In fr, this message translates to:
  /// **'Passé'**
  String get skipped;

  /// No description provided for @timer.
  ///
  /// In fr, this message translates to:
  /// **'Minuteur'**
  String get timer;

  /// No description provided for @restTimer.
  ///
  /// In fr, this message translates to:
  /// **'Temps de repos'**
  String get restTimer;

  /// No description provided for @startTimer.
  ///
  /// In fr, this message translates to:
  /// **'Démarrer le minuteur'**
  String get startTimer;

  /// No description provided for @pauseTimer.
  ///
  /// In fr, this message translates to:
  /// **'Mettre en pause'**
  String get pauseTimer;

  /// No description provided for @resumeTimer.
  ///
  /// In fr, this message translates to:
  /// **'Reprendre'**
  String get resumeTimer;

  /// No description provided for @stopTimer.
  ///
  /// In fr, this message translates to:
  /// **'Arrêter'**
  String get stopTimer;

  /// No description provided for @timerRunning.
  ///
  /// In fr, this message translates to:
  /// **'Minuteur en cours'**
  String get timerRunning;

  /// No description provided for @timerPaused.
  ///
  /// In fr, this message translates to:
  /// **'Minuteur en pause'**
  String get timerPaused;

  /// No description provided for @timerCompleted.
  ///
  /// In fr, this message translates to:
  /// **'Temps de repos terminé !'**
  String get timerCompleted;

  /// No description provided for @customRestTime.
  ///
  /// In fr, this message translates to:
  /// **'Temps de repos personnalisé'**
  String get customRestTime;

  /// No description provided for @seconds.
  ///
  /// In fr, this message translates to:
  /// **'secondes'**
  String get seconds;

  /// No description provided for @minutes.
  ///
  /// In fr, this message translates to:
  /// **'minutes'**
  String get minutes;

  /// No description provided for @history.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get history;

  /// No description provided for @workoutHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique des entraînements'**
  String get workoutHistory;

  /// No description provided for @sessionDetails.
  ///
  /// In fr, this message translates to:
  /// **'Détails de la session'**
  String get sessionDetails;

  /// No description provided for @noHistoryFound.
  ///
  /// In fr, this message translates to:
  /// **'Aucun historique trouvé'**
  String get noHistoryFound;

  /// No description provided for @totalWorkouts.
  ///
  /// In fr, this message translates to:
  /// **'Total d\'entraînements'**
  String get totalWorkouts;

  /// No description provided for @totalSets.
  ///
  /// In fr, this message translates to:
  /// **'Total de séries'**
  String get totalSets;

  /// No description provided for @totalReps.
  ///
  /// In fr, this message translates to:
  /// **'Total de répétitions'**
  String get totalReps;

  /// No description provided for @totalWeight.
  ///
  /// In fr, this message translates to:
  /// **'Poids total soulevé'**
  String get totalWeight;

  /// No description provided for @totalVolume.
  ///
  /// In fr, this message translates to:
  /// **'Volume total'**
  String get totalVolume;

  /// No description provided for @duration.
  ///
  /// In fr, this message translates to:
  /// **'Durée'**
  String get duration;

  /// No description provided for @date.
  ///
  /// In fr, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @today.
  ///
  /// In fr, this message translates to:
  /// **'Aujourd\'hui'**
  String get today;

  /// No description provided for @yesterday.
  ///
  /// In fr, this message translates to:
  /// **'Hier'**
  String get yesterday;

  /// No description provided for @thisWeek.
  ///
  /// In fr, this message translates to:
  /// **'Cette semaine'**
  String get thisWeek;

  /// No description provided for @thisMonth.
  ///
  /// In fr, this message translates to:
  /// **'Ce mois-ci'**
  String get thisMonth;

  /// No description provided for @stats.
  ///
  /// In fr, this message translates to:
  /// **'Statistiques'**
  String get stats;

  /// No description provided for @statistics.
  ///
  /// In fr, this message translates to:
  /// **'Statistiques'**
  String get statistics;

  /// No description provided for @dashboard.
  ///
  /// In fr, this message translates to:
  /// **'Tableau de bord'**
  String get dashboard;

  /// No description provided for @personalRecords.
  ///
  /// In fr, this message translates to:
  /// **'Records personnels'**
  String get personalRecords;

  /// No description provided for @pr.
  ///
  /// In fr, this message translates to:
  /// **'RP'**
  String get pr;

  /// No description provided for @newPR.
  ///
  /// In fr, this message translates to:
  /// **'Nouveau record !'**
  String get newPR;

  /// No description provided for @exerciseHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique de l\'exercice'**
  String get exerciseHistory;

  /// No description provided for @progressCharts.
  ///
  /// In fr, this message translates to:
  /// **'Graphiques de progression'**
  String get progressCharts;

  /// No description provided for @weeklyStats.
  ///
  /// In fr, this message translates to:
  /// **'Stats hebdomadaires'**
  String get weeklyStats;

  /// No description provided for @monthlyStats.
  ///
  /// In fr, this message translates to:
  /// **'Stats mensuelles'**
  String get monthlyStats;

  /// No description provided for @averageWeight.
  ///
  /// In fr, this message translates to:
  /// **'Poids moyen'**
  String get averageWeight;

  /// No description provided for @maxWeight.
  ///
  /// In fr, this message translates to:
  /// **'Poids maximum'**
  String get maxWeight;

  /// No description provided for @totalSessions.
  ///
  /// In fr, this message translates to:
  /// **'Sessions totales'**
  String get totalSessions;

  /// No description provided for @settings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres'**
  String get settings;

  /// No description provided for @generalSettings.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres généraux'**
  String get generalSettings;

  /// No description provided for @theme.
  ///
  /// In fr, this message translates to:
  /// **'Thème'**
  String get theme;

  /// No description provided for @lightMode.
  ///
  /// In fr, this message translates to:
  /// **'Mode clair'**
  String get lightMode;

  /// No description provided for @darkMode.
  ///
  /// In fr, this message translates to:
  /// **'Mode sombre'**
  String get darkMode;

  /// No description provided for @systemMode.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get systemMode;

  /// No description provided for @notifications.
  ///
  /// In fr, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @enableNotifications.
  ///
  /// In fr, this message translates to:
  /// **'Activer les notifications'**
  String get enableNotifications;

  /// No description provided for @timerNotifications.
  ///
  /// In fr, this message translates to:
  /// **'Notifications du minuteur'**
  String get timerNotifications;

  /// No description provided for @achievementNotifications.
  ///
  /// In fr, this message translates to:
  /// **'Notifications de succès'**
  String get achievementNotifications;

  /// No description provided for @restTimerSound.
  ///
  /// In fr, this message translates to:
  /// **'Son du minuteur'**
  String get restTimerSound;

  /// No description provided for @vibration.
  ///
  /// In fr, this message translates to:
  /// **'Vibration'**
  String get vibration;

  /// No description provided for @units.
  ///
  /// In fr, this message translates to:
  /// **'Unités'**
  String get units;

  /// No description provided for @metric.
  ///
  /// In fr, this message translates to:
  /// **'Métrique (kg)'**
  String get metric;

  /// No description provided for @imperial.
  ///
  /// In fr, this message translates to:
  /// **'Impérial (lbs)'**
  String get imperial;

  /// No description provided for @language.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get language;

  /// No description provided for @about.
  ///
  /// In fr, this message translates to:
  /// **'À propos'**
  String get about;

  /// No description provided for @version.
  ///
  /// In fr, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @privacyPolicy.
  ///
  /// In fr, this message translates to:
  /// **'Politique de confidentialité'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In fr, this message translates to:
  /// **'Conditions d\'utilisation'**
  String get termsOfService;

  /// No description provided for @errorGeneric.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue'**
  String get errorGeneric;

  /// No description provided for @errorNetwork.
  ///
  /// In fr, this message translates to:
  /// **'Erreur réseau'**
  String get errorNetwork;

  /// No description provided for @errorDatabase.
  ///
  /// In fr, this message translates to:
  /// **'Erreur de base de données'**
  String get errorDatabase;

  /// No description provided for @errorLoadingData.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors du chargement des données'**
  String get errorLoadingData;

  /// No description provided for @errorSavingData.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de l\'enregistrement'**
  String get errorSavingData;

  /// No description provided for @errorDeletingData.
  ///
  /// In fr, this message translates to:
  /// **'Erreur lors de la suppression'**
  String get errorDeletingData;

  /// No description provided for @errorInvalidInput.
  ///
  /// In fr, this message translates to:
  /// **'Entrée invalide'**
  String get errorInvalidInput;

  /// No description provided for @errorEmptyField.
  ///
  /// In fr, this message translates to:
  /// **'Ce champ ne peut pas être vide'**
  String get errorEmptyField;

  /// No description provided for @errorNoInternet.
  ///
  /// In fr, this message translates to:
  /// **'Aucune connexion Internet'**
  String get errorNoInternet;

  /// No description provided for @validationRequired.
  ///
  /// In fr, this message translates to:
  /// **'Champ requis'**
  String get validationRequired;

  /// No description provided for @validationMinLength.
  ///
  /// In fr, this message translates to:
  /// **'Minimum {min} caractères'**
  String validationMinLength(int min);

  /// No description provided for @validationMaxLength.
  ///
  /// In fr, this message translates to:
  /// **'Maximum {max} caractères'**
  String validationMaxLength(int max);

  /// No description provided for @validationInvalidEmail.
  ///
  /// In fr, this message translates to:
  /// **'Email invalide'**
  String get validationInvalidEmail;

  /// No description provided for @validationInvalidNumber.
  ///
  /// In fr, this message translates to:
  /// **'Nombre invalide'**
  String get validationInvalidNumber;

  /// No description provided for @validationPositiveNumber.
  ///
  /// In fr, this message translates to:
  /// **'Doit être un nombre positif'**
  String get validationPositiveNumber;

  /// No description provided for @emptyExercises.
  ///
  /// In fr, this message translates to:
  /// **'Aucun exercice disponible'**
  String get emptyExercises;

  /// No description provided for @emptyExercisesDescription.
  ///
  /// In fr, this message translates to:
  /// **'Commencez par ajouter des exercices à votre bibliothèque'**
  String get emptyExercisesDescription;

  /// No description provided for @emptyWorkouts.
  ///
  /// In fr, this message translates to:
  /// **'Aucun entraînement créé'**
  String get emptyWorkouts;

  /// No description provided for @emptyWorkoutsDescription.
  ///
  /// In fr, this message translates to:
  /// **'Créez votre premier entraînement pour commencer'**
  String get emptyWorkoutsDescription;

  /// No description provided for @emptyHistory.
  ///
  /// In fr, this message translates to:
  /// **'Aucun historique'**
  String get emptyHistory;

  /// No description provided for @emptyHistoryDescription.
  ///
  /// In fr, this message translates to:
  /// **'Vos entraînements terminés apparaîtront ici'**
  String get emptyHistoryDescription;

  /// No description provided for @emptySearch.
  ///
  /// In fr, this message translates to:
  /// **'Aucun résultat'**
  String get emptySearch;

  /// No description provided for @emptySearchDescription.
  ///
  /// In fr, this message translates to:
  /// **'Essayez avec d\'autres mots-clés'**
  String get emptySearchDescription;

  /// No description provided for @successWorkoutCreated.
  ///
  /// In fr, this message translates to:
  /// **'Entraînement créé avec succès'**
  String get successWorkoutCreated;

  /// No description provided for @successWorkoutUpdated.
  ///
  /// In fr, this message translates to:
  /// **'Entraînement mis à jour'**
  String get successWorkoutUpdated;

  /// No description provided for @successWorkoutDeleted.
  ///
  /// In fr, this message translates to:
  /// **'Entraînement supprimé'**
  String get successWorkoutDeleted;

  /// No description provided for @successWorkoutCompleted.
  ///
  /// In fr, this message translates to:
  /// **'Entraînement terminé avec succès !'**
  String get successWorkoutCompleted;

  /// No description provided for @successExerciseAdded.
  ///
  /// In fr, this message translates to:
  /// **'Exercice ajouté'**
  String get successExerciseAdded;

  /// No description provided for @successExerciseDeleted.
  ///
  /// In fr, this message translates to:
  /// **'Exercice supprimé'**
  String get successExerciseDeleted;

  /// No description provided for @successSettingsSaved.
  ///
  /// In fr, this message translates to:
  /// **'Paramètres enregistrés'**
  String get successSettingsSaved;

  /// No description provided for @selectWorkout.
  ///
  /// In fr, this message translates to:
  /// **'Sélectionner une séance'**
  String get selectWorkout;

  /// No description provided for @quickStart.
  ///
  /// In fr, this message translates to:
  /// **'Démarrage rapide'**
  String get quickStart;

  /// No description provided for @activeWorkout.
  ///
  /// In fr, this message translates to:
  /// **'Séance en cours'**
  String get activeWorkout;

  /// No description provided for @elapsedTime.
  ///
  /// In fr, this message translates to:
  /// **'Temps écoulé'**
  String get elapsedTime;

  /// No description provided for @sessionStartedAt.
  ///
  /// In fr, this message translates to:
  /// **'Démarrée à {time}'**
  String sessionStartedAt(String time);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
