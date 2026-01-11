/// Traductions françaises de l'application
/// Single Source of Truth pour tous les textes de l'app
class AppStrings {
  AppStrings._(); // Private constructor

  // ==================== GENERAL ====================
  static const String appName = 'PFT';
  static const String appFullName = 'Performance Fitness Tracker';
  static const String loading = 'Chargement...';
  static const String error = 'Erreur';
  static const String success = 'Succès';
  static const String cancel = 'Annuler';
  static const String confirm = 'Confirmer';
  static const String save = 'Enregistrer';
  static const String delete = 'Supprimer';
  static const String edit = 'Modifier';
  static const String add = 'Ajouter';
  static const String search = 'Rechercher';
  static const String filter = 'Filtrer';
  static const String clear = 'Effacer';
  static const String apply = 'Appliquer';
  static const String close = 'Fermer';
  static const String back = 'Retour';
  static const String next = 'Suivant';
  static const String previous = 'Précédent';
  static const String done = 'Terminé';
  static const String skip = 'Passer';

  // ==================== EXERCISES ====================
  static const String exercises = 'Exercices';
  static const String exerciseList = 'Liste des exercices';
  static const String exerciseDetails = 'Détails de l\'exercice';
  static const String searchExercises = 'Rechercher un exercice';
  static const String filterExercises = 'Filtrer les exercices';
  static const String noExercisesFound = 'Aucun exercice trouvé';
  static const String exerciseCount = 'exercices';
  static const String customExercise = 'Personnalisé';
  static const String addCustomExercise = 'Ajouter un exercice personnalisé';
  static const String exerciseName = 'Nom de l\'exercice';
  static const String exerciseDescription = 'Description';
  static const String exerciseInstructions = 'Instructions';

  // Muscle Groups (FR)
  static const String muscleGroupChest = 'Pectoraux';
  static const String muscleGroupBack = 'Dos';
  static const String muscleGroupShoulders = 'Épaules';
  static const String muscleGroupLegs = 'Jambes';
  static const String muscleGroupArms = 'Bras';
  static const String muscleGroupCore = 'Abdominaux';
  static const String muscleGroupCardio = 'Cardio';
  static const String muscleGroupFullBody = 'Corps entier';
  static const String muscleGroupOther = 'Autre';
  static const String allMuscleGroups = 'Tous les groupes';

  // Equipment Types (FR)
  static const String equipmentBarbell = 'Barre';
  static const String equipmentDumbbell = 'Haltères';
  static const String equipmentMachine = 'Machine';
  static const String equipmentBodyweight = 'Poids du corps';
  static const String equipmentCable = 'Câble';
  static const String equipmentOther = 'Autre';
  static const String allEquipmentTypes = 'Tous les équipements';

  // Exercise Categories (FR)
  static const String categoryCompound = 'Polyarticulaire';
  static const String categoryIsolation = 'Isolation';
  static const String categoryCardio = 'Cardio';
  static const String categoryStretching = 'Étirement';
  static const String allCategories = 'Toutes les catégories';

  // ==================== WORKOUTS ====================
  static const String workouts = 'Entraînements';
  static const String myWorkouts = 'Mes entraînements';
  static const String createWorkout = 'Créer un entraînement';
  static const String editWorkout = 'Modifier l\'entraînement';
  static const String deleteWorkout = 'Supprimer l\'entraînement';
  static const String duplicateWorkout = 'Dupliquer l\'entraînement';
  static const String workoutName = 'Nom de l\'entraînement';
  static const String workoutDescription = 'Description';
  static const String workoutNotes = 'Notes';
  static const String workoutTemplates = 'Modèles d\'entraînement';
  static const String noWorkoutsFound = 'Aucun entraînement trouvé';
  static const String addExercises = 'Ajouter des exercices';
  static const String removeExercise = 'Retirer l\'exercice';
  static const String reorderExercises = 'Réorganiser les exercices';

  // ==================== WORKOUT SESSION ====================
  static const String startWorkout = 'Démarrer l\'entraînement';
  static const String continueWorkout = 'Continuer l\'entraînement';
  static const String finishWorkout = 'Terminer l\'entraînement';
  static const String abandonWorkout = 'Abandonner l\'entraînement';
  static const String workoutInProgress = 'Entraînement en cours';
  static const String workoutCompleted = 'Entraînement terminé !';
  static const String workoutAbandoned = 'Entraînement abandonné';
  static const String confirmAbandon =
      'Êtes-vous sûr de vouloir abandonner cet entraînement ?';
  static const String confirmFinish =
      'Êtes-vous sûr d\'avoir terminé cet entraînement ?';

  // Sets & Reps
  static const String sets = 'Séries';
  static const String reps = 'Répétitions';
  static const String weight = 'Poids';
  static const String addSet = 'Ajouter une série';
  static const String removeSet = 'Retirer la série';
  static const String set = 'Série';
  static const String kg = 'kg';
  static const String lbs = 'lbs';
  static const String completed = 'Complété';
  static const String skipped = 'Passé';

  // ==================== TIMER ====================
  static const String timer = 'Minuteur';
  static const String restTimer = 'Temps de repos';
  static const String startTimer = 'Démarrer le minuteur';
  static const String pauseTimer = 'Mettre en pause';
  static const String resumeTimer = 'Reprendre';
  static const String stopTimer = 'Arrêter';
  static const String timerRunning = 'Minuteur en cours';
  static const String timerPaused = 'Minuteur en pause';
  static const String timerCompleted = 'Temps de repos terminé !';
  static const String customRestTime = 'Temps de repos personnalisé';
  static const String seconds = 'secondes';
  static const String minutes = 'minutes';

  // ==================== HISTORY ====================
  static const String history = 'Historique';
  static const String workoutHistory = 'Historique des entraînements';
  static const String sessionDetails = 'Détails de la session';
  static const String noHistoryFound = 'Aucun historique trouvé';
  static const String totalWorkouts = 'Total d\'entraînements';
  static const String totalSets = 'Total de séries';
  static const String totalReps = 'Total de répétitions';
  static const String totalWeight = 'Poids total soulevé';
  static const String totalVolume = 'Volume total';
  static const String duration = 'Durée';
  static const String date = 'Date';
  static const String today = 'Aujourd\'hui';
  static const String yesterday = 'Hier';
  static const String thisWeek = 'Cette semaine';
  static const String thisMonth = 'Ce mois-ci';

  // ==================== STATS ====================
  static const String stats = 'Statistiques';
  static const String statistics = 'Statistiques';
  static const String dashboard = 'Tableau de bord';
  static const String personalRecords = 'Records personnels';
  static const String pr = 'RP'; // Record Personnel
  static const String newPR = 'Nouveau record !';
  static const String exerciseHistory = 'Historique de l\'exercice';
  static const String progressCharts = 'Graphiques de progression';
  static const String weeklyStats = 'Stats hebdomadaires';
  static const String monthlyStats = 'Stats mensuelles';
  static const String averageWeight = 'Poids moyen';
  static const String maxWeight = 'Poids maximum';
  static const String totalSessions = 'Sessions totales';

  // ==================== SETTINGS ====================
  static const String settings = 'Paramètres';
  static const String generalSettings = 'Paramètres généraux';
  static const String theme = 'Thème';
  static const String lightMode = 'Mode clair';
  static const String darkMode = 'Mode sombre';
  static const String systemMode = 'Système';
  static const String notifications = 'Notifications';
  static const String enableNotifications = 'Activer les notifications';
  static const String timerNotifications = 'Notifications du minuteur';
  static const String achievementNotifications = 'Notifications de succès';
  static const String restTimerSound = 'Son du minuteur';
  static const String vibration = 'Vibration';
  static const String units = 'Unités';
  static const String metric = 'Métrique (kg)';
  static const String imperial = 'Impérial (lbs)';
  static const String language = 'Langue';
  static const String about = 'À propos';
  static const String version = 'Version';
  static const String privacyPolicy = 'Politique de confidentialité';
  static const String termsOfService = 'Conditions d\'utilisation';

  // ==================== ERRORS ====================
  static const String errorGeneric = 'Une erreur est survenue';
  static const String errorNetwork = 'Erreur réseau';
  static const String errorDatabase = 'Erreur de base de données';
  static const String errorLoadingData =
      'Erreur lors du chargement des données';
  static const String errorSavingData = 'Erreur lors de l\'enregistrement';
  static const String errorDeletingData = 'Erreur lors de la suppression';
  static const String errorInvalidInput = 'Entrée invalide';
  static const String errorEmptyField = 'Ce champ ne peut pas être vide';
  static const String errorNoInternet = 'Aucune connexion Internet';

  // ==================== VALIDATION ====================
  static const String validationRequired = 'Champ requis';
  static const String validationMinLength = 'Minimum {min} caractères';
  static const String validationMaxLength = 'Maximum {max} caractères';
  static const String validationInvalidEmail = 'Email invalide';
  static const String validationInvalidNumber = 'Nombre invalide';
  static const String validationPositiveNumber = 'Doit être un nombre positif';

  // ==================== EMPTY STATES ====================
  static const String emptyExercises = 'Aucun exercice disponible';
  static const String emptyExercisesDescription =
      'Commencez par ajouter des exercices à votre bibliothèque';
  static const String emptyWorkouts = 'Aucun entraînement créé';
  static const String emptyWorkoutsDescription =
      'Créez votre premier entraînement pour commencer';
  static const String emptyHistory = 'Aucun historique';
  static const String emptyHistoryDescription =
      'Vos entraînements terminés apparaîtront ici';
  static const String emptySearch = 'Aucun résultat';
  static const String emptySearchDescription =
      'Essayez avec d\'autres mots-clés';

  // ==================== SUCCESS MESSAGES ====================
  static const String successWorkoutCreated = 'Entraînement créé avec succès';
  static const String successWorkoutUpdated = 'Entraînement mis à jour';
  static const String successWorkoutDeleted = 'Entraînement supprimé';
  static const String successWorkoutCompleted =
      'Entraînement terminé avec succès !';
  static const String successExerciseAdded = 'Exercice ajouté';
  static const String successExerciseDeleted = 'Exercice supprimé';
  static const String successSettingsSaved = 'Paramètres enregistrés';

  // ==================== HELPER METHODS ====================

  /// Retourne le nom français d'un groupe musculaire
  static String getMuscleGroupName(String muscleGroup) {
    switch (muscleGroup.toLowerCase()) {
      case 'chest':
        return muscleGroupChest;
      case 'back':
        return muscleGroupBack;
      case 'shoulders':
        return muscleGroupShoulders;
      case 'legs':
        return muscleGroupLegs;
      case 'arms':
        return muscleGroupArms;
      case 'core':
        return muscleGroupCore;
      case 'cardio':
        return muscleGroupCardio;
      case 'fullbody':
      case 'full body':
        return muscleGroupFullBody;
      default:
        return muscleGroupOther;
    }
  }

  /// Retourne le nom français d'un équipement
  static String getEquipmentName(String equipment) {
    switch (equipment.toLowerCase()) {
      case 'barbell':
        return equipmentBarbell;
      case 'dumbbell':
        return equipmentDumbbell;
      case 'machine':
        return equipmentMachine;
      case 'bodyweight':
        return equipmentBodyweight;
      case 'cable':
        return equipmentCable;
      default:
        return equipmentOther;
    }
  }

  /// Retourne le nom français d'une catégorie
  static String getCategoryName(String category) {
    switch (category.toLowerCase()) {
      case 'compound':
        return categoryCompound;
      case 'isolation':
        return categoryIsolation;
      case 'cardio':
        return categoryCardio;
      case 'stretching':
        return categoryStretching;
      default:
        return categoryCompound;
    }
  }
}
