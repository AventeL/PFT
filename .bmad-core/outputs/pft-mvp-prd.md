# PRD - PFT (Performance Fitness Tracker) - Phase 1 MVP

**Document Version:** 1.0  
**Date Created:** 2026-01-11  
**Last Updated:** 2026-01-11  
**Author:** Mathis  
**Status:** Draft  
**Target Release:** Q1 2026 (Alpha: 2026-04-11)

---

## 📋 Executive Summary

### Product Overview
**PFT (Performance Fitness Tracker)** est une application mobile Flutter offline-first permettant aux pratiquants de musculation de tracker précisément leurs séances d'entraînement, suivre leur progression, et optimiser leurs performances grâce à un timer de repos intelligent et des visualisations motivantes.

### Problem Statement
Les pratiquants de musculation abandonnent le tracking de leurs performances à cause de:
- Carnets papier peu pratiques et facilement perdus
- Apps Excel/Notes sans visualisation ni insights
- Apps existantes trop complexes ou nécessitant connexion internet constante
- Mauvaise intégration du timer de repos dans le workflow
- Absence de feedback immédiat sur la progression

### Solution
Une app mobile native qui offre:
- ✅ Interface ultra-simple optimisée pour saisie rapide (< 10s par série)
- ✅ Fonctionnement 100% offline (stockage local)
- ✅ Timer de repos intelligent intégré au workflow (KILLER FEATURE)
- ✅ Visualisations de progression immédiates
- ✅ Base d'exercices pré-chargée (50+)

### Target Users
- **Primaire:** Pratiquants réguliers 2-5x/semaine, 18-45 ans, motivés à progresser
- **Secondaire:** Débutants cherchant structure, pratiquants home gym

### Success Criteria (MVP Launch - 2026-04-11)
1. ✅ **10 utilisateurs alpha actifs** (3+ séances/semaine)
2. ✅ **Taux complétion séance > 80%**
3. ✅ **Temps saisie série < 10s**
4. ✅ **Crash-free rate > 99%**

### Success Criteria (6 mois post-launch - 2026-06-30)
1. ✅ **100 MAU** (Monthly Active Users)
2. ✅ **Rétention D30 > 40%**
3. ✅ **NPS > 50**
4. ✅ **Rating stores > 4.5★**

---

## 🎯 Business Objectives

### Primary Objectives
1. **Valider product-market fit**
   - KR: 100 MAU après 3 mois post-launch
   - KR: Rétention D30 > 40%
   - KR: NPS > 50

2. **Construire base utilisateurs engagés pour Phase 2 (social)**
   - KR: 500 utilisateurs enregistrés fin 2026
   - KR: Taux d'engagement hebdomadaire > 60%

3. **Établir réputation d'app fiable et performante**
   - KR: > 4.5★ stores
   - KR: < 1% crash rate
   - KR: Mentions positives communautés fitness

### Market Positioning
**Notre niche:** App musculation moderne, offline-first, avec timer killer, pour pratiquants réguliers

**Différenciateurs clés:**
- Offline-first (fonctionne sans connexion)
- Timer de repos vraiment bien intégré
- UX ultra-efficace (< 10s par série)
- 100% gratuit Phase 1 (pas paywall, pas ads)
- Privacy-focused (données locales)

**Gap marché:** Il existe des apps complexes/chères (Strong, JEFIT) et des apps simples/datées (FitNotes). Notre positionnement = App MODERNE + SIMPLE + GRATUITE + OFFLINE + TIMER EXCELLENT.

---

## 🏗️ Features & Requirements

## Feature 1: Gestion des séances d'entraînement

**Priority:** P0 - Must Have  
**Effort Estimate:** 5 jours (M3)

### User Stories

#### US-1.1: Créer une séance personnalisée
**As a** pratiquant de musculation  
**I want to** créer mes propres séances d'entraînement  
**So that** je peux organiser mes entraînements selon mes objectifs

**Acceptance Criteria:**
- [ ] User peut créer une nouvelle séance avec un nom
- [ ] User peut ajouter une description (optionnel)
- [ ] User peut ajouter des exercices depuis la base de données
- [ ] User peut réordonner les exercices (drag & drop)
- [ ] User peut définir le nombre de séries cibles par exercice
- [ ] Séance sauvegardée localement automatiquement
- [ ] Validation: nom non vide, au moins 1 exercice

**UI/UX Notes:**
- Écran "New Workout" avec FAB "+" pour ajouter exercices
- Recherche/filtre exercices par groupe musculaire
- Preview de la séance avant sauvegarde

---

#### US-1.2: Utiliser templates pré-configurés
**As a** utilisateur débutant  
**I want to** accéder à des templates de séances pré-faits  
**So that** je n'ai pas à créer mes séances from scratch

**Acceptance Criteria:**
- [ ] 5+ templates disponibles dès installation:
  - Push/Pull/Legs (3 séances)
  - Upper/Lower (2 séances)
  - Full Body
- [ ] User peut prévisualiser un template avant import
- [ ] User peut importer template et le modifier
- [ ] Templates utilisent exercices de la base pré-chargée

**Templates Content:**
```
Push: Bench Press, Overhead Press, Incline DB Press, Triceps Dips, Lateral Raises
Pull: Deadlift, Pull-ups, Barbell Rows, Face Pulls, Biceps Curls
Legs: Squat, Romanian Deadlift, Leg Press, Leg Curls, Calf Raises
Upper: Bench Press, Barbell Rows, Overhead Press, Pull-ups, Dips
Lower: Squat, Deadlift, Leg Press, Lunges, Calf Raises
Full Body: Squat, Bench Press, Deadlift, Pull-ups, Overhead Press
```

---

#### US-1.3: Éditer/supprimer séances existantes
**As a** utilisateur  
**I want to** modifier ou supprimer mes séances  
**So that** je peux adapter mon programme au fil du temps

**Acceptance Criteria:**
- [ ] User peut éditer nom, description, exercices d'une séance
- [ ] User peut supprimer une séance (confirmation requise)
- [ ] Suppression affiche warning si séance utilisée dans historique
- [ ] Suppression ne supprime PAS l'historique (séances réalisées conservées)
- [ ] Édition met à jour timestamp "updatedAt"

---

#### US-1.4: Dupliquer une séance existante
**As a** utilisateur  
**I want to** dupliquer une séance que j'aime  
**So that** je peux créer variations facilement

**Acceptance Criteria:**
- [ ] Action "Duplicate" dans menu contextuel
- [ ] Séance dupliquée s'appelle "[Original Name] (Copy)"
- [ ] User peut renommer immédiatement après duplication
- [ ] Tous les exercices et paramètres sont copiés

---

#### US-1.5: Ajouter notes à une séance
**As a** utilisateur  
**I want to** ajouter des notes à mes séances  
**So that** je peux documenter ressentis, conditions, etc.

**Acceptance Criteria:**
- [ ] Champ texte "Notes" dans workout editor
- [ ] Notes sauvegardées avec la séance template
- [ ] Notes visibles en preview de la séance
- [ ] Character limit: 500 caractères

---

### Technical Specifications

**Data Model:**
```dart
class Workout {
  final String id; // UUID
  final String name;
  final String? description;
  final List<WorkoutExercise> exercises;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
}

class WorkoutExercise {
  final String exerciseId;
  final int order;
  final int targetSets;
  final Duration? restTime;
}
```

**BLoC Events/States:**
```dart
// WorkoutBloc Events
abstract class WorkoutEvent {}
class LoadWorkouts extends WorkoutEvent {}
class CreateWorkout extends WorkoutEvent {
  final Workout workout;
}
class UpdateWorkout extends WorkoutEvent {
  final Workout workout;
}
class DeleteWorkout extends WorkoutEvent {
  final String workoutId;
}
class DuplicateWorkout extends WorkoutEvent {
  final String workoutId;
}

// WorkoutBloc States
abstract class WorkoutState {}
class WorkoutInitial extends WorkoutState {}
class WorkoutLoading extends WorkoutState {}
class WorkoutsLoaded extends WorkoutState {
  final List<Workout> workouts;
}
class WorkoutError extends WorkoutState {
  final String message;
}
```

---

## Feature 2: Base de données d'exercices

**Priority:** P0 - Must Have  
**Effort Estimate:** 3 jours (M2)

### User Stories

#### US-2.1: Accéder à une base d'exercices pré-chargée
**As a** nouvel utilisateur  
**I want to** avoir accès à une liste d'exercices dès installation  
**So that** je peux commencer à tracker sans friction

**Acceptance Criteria:**
- [ ] 50+ exercices disponibles au premier lancement
- [ ] Exercices catégorisés par groupe musculaire:
  - Chest (Pectoraux)
  - Back (Dos)
  - Shoulders (Épaules)
  - Arms (Bras: biceps/triceps)
  - Legs (Jambes: quads/hamstrings/glutes)
  - Core (Abdos/gainage)
- [ ] Exercices taggés: compound/isolation, barbell/dumbbell/machine/bodyweight
- [ ] Chargement depuis fichier JSON/YAML au seed initial
- [ ] Performance: liste de 50+ exercices charge en < 100ms

**Exercise List (50+ essentiels):**
```yaml
Chest:
  - Barbell Bench Press (compound, barbell)
  - Incline Dumbbell Press (compound, dumbbell)
  - Decline Bench Press (compound, barbell)
  - Dumbbell Flyes (isolation, dumbbell)
  - Cable Flyes (isolation, machine)
  - Push-ups (compound, bodyweight)

Back:
  - Deadlift (compound, barbell)
  - Barbell Rows (compound, barbell)
  - Pull-ups (compound, bodyweight)
  - Lat Pulldown (compound, machine)
  - Seated Cable Rows (compound, machine)
  - T-Bar Rows (compound, barbell)
  - Face Pulls (isolation, machine)

Shoulders:
  - Overhead Press (compound, barbell)
  - Dumbbell Shoulder Press (compound, dumbbell)
  - Lateral Raises (isolation, dumbbell)
  - Front Raises (isolation, dumbbell)
  - Rear Delt Flyes (isolation, dumbbell)
  - Arnold Press (compound, dumbbell)

Arms:
  - Barbell Curls (isolation, barbell)
  - Hammer Curls (isolation, dumbbell)
  - Triceps Dips (compound, bodyweight)
  - Skull Crushers (isolation, barbell)
  - Cable Triceps Pushdown (isolation, machine)
  - Preacher Curls (isolation, machine)

Legs:
  - Barbell Squat (compound, barbell)
  - Romanian Deadlift (compound, barbell)
  - Leg Press (compound, machine)
  - Leg Curls (isolation, machine)
  - Leg Extensions (isolation, machine)
  - Lunges (compound, bodyweight/dumbbell)
  - Calf Raises (isolation, machine/bodyweight)
  - Bulgarian Split Squats (compound, dumbbell)

Core:
  - Plank (isometric, bodyweight)
  - Russian Twists (isolation, bodyweight)
  - Cable Crunches (isolation, machine)
  - Hanging Leg Raises (compound, bodyweight)
```

---

#### US-2.2: Rechercher et filtrer exercices
**As a** utilisateur  
**I want to** rechercher et filtrer exercices  
**So that** je trouve rapidement ce que je cherche

**Acceptance Criteria:**
- [ ] Barre de recherche (search by name)
- [ ] Filtres par groupe musculaire (chips sélectionnables)
- [ ] Filtres par type (compound/isolation)
- [ ] Filtres par équipement (barbell/dumbbell/machine/bodyweight)
- [ ] Résultats mis à jour en temps réel (debounced search)
- [ ] Performance: search sur 50+ exercices < 50ms

**UI/UX:**
- Search bar en haut d'écran
- Filter chips horizontalement scrollables
- Liste exercices avec nom + icône groupe musculaire
- Tap exercice = voir détails ou ajouter à séance (contexte)

---

#### US-2.3: Créer exercices personnalisés
**As a** utilisateur avancé  
**I want to** créer mes propres exercices  
**So that** je peux tracker des mouvements non standards

**Acceptance Criteria:**
- [ ] Bouton "Create Custom Exercise"
- [ ] User renseigne: nom (requis), groupe musculaire, type, équipement
- [ ] Instructions (optionnel, 500 char max)
- [ ] Exercice custom marqué avec badge "Custom"
- [ ] Exercices customs apparaissent dans liste générale
- [ ] Validation: nom unique (case-insensitive)

---

#### US-2.4: Voir détails d'un exercice
**As a** utilisateur  
**I want to** voir détails d'un exercice  
**So that** je comprends comment le faire correctement

**Acceptance Criteria:**
- [ ] Tap long sur exercice = bottom sheet détails
- [ ] Affiche: nom, groupe musculaire, type, équipement
- [ ] Affiche instructions si disponibles
- [ ] Affiche historique (combien de fois fait, dernière fois)
- [ ] Lien vers "View Full History" (navigation)

---

### Technical Specifications

**Data Model:**
```dart
class Exercise {
  final String id; // UUID
  final String name;
  final MuscleGroup muscleGroup;
  final ExerciseCategory category; // compound/isolation
  final EquipmentType equipmentType;
  final bool isCustom;
  final String? instructions;
  final DateTime createdAt;
}

enum MuscleGroup {
  chest, back, shoulders, arms, legs, core
}

enum ExerciseCategory {
  compound, isolation
}

enum EquipmentType {
  barbell, dumbbell, machine, bodyweight, cable
}
```

**Seed Data:**
- Fichier `assets/data/exercises.json` chargé au premier lancement
- Insertion bulk en database locale (SQLite/Hive)

---

## Feature 3: Tracking des performances (Active Workout)

**Priority:** P0 - Must Have (CRITIQUE)  
**Effort Estimate:** 8 jours (M4)

### User Stories

#### US-3.1: Démarrer une séance d'entraînement
**As a** utilisateur  
**I want to** démarrer une séance rapidement  
**So that** je peux commencer à tracker mes sets

**Acceptance Criteria:**
- [ ] Bouton "Start Workout" sur home screen (FAB)
- [ ] User sélectionne séance (templates ou custom)
- [ ] Option "Quick Start" = séance vide (ajouter exercices on-the-fly)
- [ ] Transition vers "Active Workout Screen" < 500ms
- [ ] Timestamp de début enregistré
- [ ] Écran reste allumé pendant séance (wakelock)

---

#### US-3.2: Tracker sets × reps × poids
**As a** utilisateur en séance  
**I want to** enregistrer mes performances rapidement  
**So that** je ne perds pas de temps entre séries

**Acceptance Criteria:**
- [ ] Interface "Set Entry" avec 3 champs: Reps, Weight, (RPE optionnel)
- [ ] Champs numériques optimisés pour saisie rapide (numpad)
- [ ] Bouton "Add Set" ajoute set et auto-lance timer repos
- [ ] Temps de saisie < 10 secondes (KPI critique)
- [ ] Sets affichés en liste avec numéro (Set 1, Set 2...)
- [ ] User peut éditer/supprimer set après ajout
- [ ] Auto-save toutes les 30s en background

**UI/UX Flow:**
```
Active Workout Screen:
├─ Exercise Name (ex: Barbell Bench Press)
├─ Previous Session Preview (dernières perfs)
│  └─ "Last time: 3×8 @ 80kg"
├─ Current Sets List
│  ├─ Set 1: 8 reps @ 80kg ✓
│  ├─ Set 2: 7 reps @ 80kg ✓
│  └─ Set 3: [Active]
├─ Quick Add Form
│  ├─ [Reps: 8]
│  ├─ [Weight: 80] kg
│  └─ [Add Set] (CTA button)
└─ Timer (si actif)
```

---

#### US-3.3: Copier performances dernière séance
**As a** utilisateur  
**I want to** partir de mes performances précédentes  
**So that** je gagne du temps et vois ma progression

**Acceptance Criteria:**
- [ ] Si exercice déjà fait précédemment, afficher preview "Last time: 3×8 @ 80kg"
- [ ] Bouton "Use Last Session" pré-remplit les sets
- [ ] User peut alors ajuster reps/poids avant validation
- [ ] Si premier fois exercice, champs vides

---

#### US-3.4: Éditer/supprimer sets pendant séance
**As a** utilisateur  
**I want to** corriger erreurs de saisie  
**So that** mes données sont précises

**Acceptance Criteria:**
- [ ] Tap sur set = édition inline
- [ ] Swipe left sur set = option "Delete"
- [ ] Confirmation avant suppression
- [ ] Éditions sauvegardées immédiatement

---

#### US-3.5: Passer au prochain exercice
**As a** utilisateur  
**I want to** naviguer facilement entre exercices  
**So that** je suis le flow de ma séance

**Acceptance Criteria:**
- [ ] Bouton "Next Exercise" visible en bas d'écran
- [ ] Transition fluide (animation slide)
- [ ] Exercice précédent marqué comme "Completed" ✓
- [ ] User peut revenir en arrière si besoin (back navigation)

---

#### US-3.6: Terminer ou abandonner séance
**As a** utilisateur  
**I want to** finaliser ma séance correctement  
**So that** mes données sont enregistrées

**Acceptance Criteria:**
- [ ] Bouton "Finish Workout" (après dernier exercice ou à tout moment)
- [ ] Confirmation: "Complete workout?" ou "Save as incomplete?"
- [ ] Si complétée: status = "completed", endTime enregistré
- [ ] Si abandonnée: status = "abandoned", données conservées quand même
- [ ] Transition vers "Workout Summary Screen"
- [ ] Wakelock désactivé

---

#### US-3.7: Auto-save et crash recovery
**As a** utilisateur  
**I want to** ne jamais perdre mes données même si crash  
**So that** mon tracking est fiable

**Acceptance Criteria:**
- [ ] Auto-save toutes les 30 secondes en background
- [ ] Si app crash ou fermée, état sauvegardé
- [ ] Au redémarrage, prompt "Resume workout?"
- [ ] User peut reprendre ou supprimer séance interrompue
- [ ] Tests: kill app mid-workout → données récupérables

---

### Technical Specifications

**Data Model:**
```dart
class WorkoutSession {
  final String id; // UUID
  final String workoutId;
  final DateTime startTime;
  final DateTime? endTime;
  final SessionStatus status; // active/completed/abandoned
  final List<PerformedExercise> performedExercises;
  final String? notes;
}

class PerformedExercise {
  final String exerciseId;
  final List<SetRecord> sets;
  final Duration? restTime;
}

class SetRecord {
  final int setNumber;
  final int reps;
  final double weight;
  final int? rpe; // 1-10 optionnel
  final DateTime timestamp;
}

enum SessionStatus {
  active, completed, abandoned
}
```

**BLoC Architecture:**
```dart
// ActiveWorkoutBloc
class ActiveWorkoutBloc extends Bloc<ActiveWorkoutEvent, ActiveWorkoutState> {
  // Events
  StartWorkout(String workoutId)
  AddSet(String exerciseId, SetRecord set)
  EditSet(String exerciseId, int setIndex, SetRecord newSet)
  RemoveSet(String exerciseId, int setIndex)
  CompleteExercise(String exerciseId)
  NextExercise()
  PauseWorkout()
  ResumeWorkout()
  FinishWorkout()
  AbandonWorkout()
  
  // States
  WorkoutActive(WorkoutSession session)
  ExerciseActive(PerformedExercise current)
  WorkoutPaused(WorkoutSession session)
  WorkoutCompleted(WorkoutSession session)
}
```

**Performance Requirements:**
- Set entry: < 10s (KPI)
- Auto-save: non-blocking, < 100ms
- Screen transitions: < 300ms
- No jank (60fps scrolling)

---

## Feature 4: Timer de repos intelligent (KILLER FEATURE)

**Priority:** P0 - Must Have  
**Effort Estimate:** 4 jours (M4)

### User Stories

#### US-4.1: Timer auto-démarré après chaque set
**As a** utilisateur  
**I want to** que le timer démarre automatiquement après un set  
**So that** je respecte mes temps de repos sans friction

**Acceptance Criteria:**
- [ ] Après "Add Set", timer démarre immédiatement
- [ ] Durée par défaut basée sur type exercice:
  - Compound (squat, deadlift, bench): 3 min
  - Isolation: 90s
- [ ] User peut override durée par exercice (settings)
- [ ] Timer affiché en fullscreen overlay (semi-transparent)
- [ ] Countdown visible: "2:45 remaining"

---

#### US-4.2: Notifications timer (son + vibration)
**As a** utilisateur  
**I want to** être alerté quand repos terminé  
**So that** je peux me concentrer sur ma séance sans regarder écran

**Acceptance Criteria:**
- [ ] À 10s restantes: vibration courte + "10s"
- [ ] À 0s: vibration longue + son (optionnel)
- [ ] Son configurable: on/off dans settings
- [ ] Notification locale (même si app en background)
- [ ] Timer continue en background si app minimisée

---

#### US-4.3: Personnalisation temps de repos
**As a** utilisateur  
**I want to** définir mes temps de repos par exercice  
**So that** je respecte mon programme

**Acceptance Criteria:**
- [ ] Dans workout editor, option "Set Rest Time" par exercice
- [ ] Options rapides: 60s, 90s, 2min, 3min, 5min
- [ ] Option custom (picker)
- [ ] Temps sauvegardé avec workout template
- [ ] Pendant séance active, bouton "Adjust Timer" (+/-30s)

---

#### US-4.4: Contrôles timer (pause, skip, extend)
**As a** utilisateur  
**I want to** contrôler le timer flexiblement  
**So that** je m'adapte à mes conditions réelles

**Acceptance Criteria:**
- [ ] Bouton "Pause" (gel countdown)
- [ ] Bouton "Skip" (terminer repos immédiatement)
- [ ] Bouton "+30s" (extend repos)
- [ ] Bouton "-30s" (réduire repos)
- [ ] UI: grands boutons tactiles (doigts moites)

**UI Design:**
```
Timer Overlay:
┌─────────────────────────┐
│      RESTING            │
│                         │
│       2:45              │  <- Gros countdown
│                         │
│  [Pause] [Skip] [+30s]  │  <- Contrôles
└─────────────────────────┘
```

---

#### US-4.5: Timer en background
**As a** utilisateur  
**I want to** que timer continue si je minimise app  
**So that** je peux check messages sans perdre timing

**Acceptance Criteria:**
- [ ] Timer continue en background
- [ ] Notification persistante affiche countdown
- [ ] Notification cliquable = retour à l'app
- [ ] Sync état au retour en foreground

---

### Technical Specifications

**BLoC Architecture:**
```dart
// TimerBloc
class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker; // Stream pour countdown
  
  // Events
  StartTimer(Duration duration)
  PauseTimer()
  ResumeTimer()
  ResetTimer()
  SkipTimer()
  ExtendTimer(Duration extension)
  TimerTick(Duration remaining)
  TimerComplete()
  
  // States
  TimerInitial(Duration duration)
  TimerRunning(Duration remaining)
  TimerPaused(Duration remaining)
  TimerCompleted()
}
```

**Dependencies:**
- `flutter_local_notifications` (notifications)
- `wakelock` (écran allumé)
- Custom Ticker stream (1s intervals)

**Performance:**
- Timer précision: ±500ms acceptable
- Notification latency: < 1s
- Background survival: tested 10+ min

---

## Feature 5: Historique et progression

**Priority:** P0 - Must Have  
**Effort Estimate:** 6 jours (M5)

### User Stories

#### US-5.1: Voir historique complet par exercice
**As a** utilisateur  
**I want to** voir toutes mes performances passées pour un exercice  
**So that** je visualise ma progression

**Acceptance Criteria:**
- [ ] Screen "Exercise History" accessible depuis exercice
- [ ] Liste chronologique de toutes sessions incluant cet exercice
- [ ] Affichage: date, sets×reps@weight
- [ ] Exemple: "2026-01-05: 3×8@80kg, 3×6@85kg"
- [ ] Pagination ou infinite scroll si > 50 sessions
- [ ] Performance: chargement < 300ms pour 2 ans données

---

#### US-5.2: Graphiques de progression
**As a** utilisateur  
**I want to** voir graphiques de mes progrès  
**So that** je suis motivé et identifie tendances

**Acceptance Criteria:**
- [ ] Graphique "Max Weight" over time (line chart)
- [ ] Graphique "Total Volume" (sets × reps × weight) over time
- [ ] Graphique "1RM estimé" (formule: weight × (1 + reps/30))
- [ ] Sélecteur période: 1 mois, 3 mois, 6 mois, 1 an, All
- [ ] Graphiques générés après minimum 3 datapoints
- [ ] Library: `fl_chart` (Flutter Charts)
- [ ] Interactive: tap point = détails session

**UI Example:**
```
Bench Press - Max Weight
   90kg ┤        ●
   85kg ┤     ●  │
   80kg ┤  ●  │  │
        └─────────────
        Jan Feb Mar
```

---

#### US-5.3: Personal Records (PR) tracking
**As a** utilisateur  
**I want to** voir mes records personnels  
**So that** je célèbre mes accomplissements

**Acceptance Criteria:**
- [ ] Badge "🏆 NEW PR!" affiché si nouveau record battu
- [ ] Records trackés:
  - Max Weight (1RM)
  - Max Reps at Weight
  - Max Volume (single session)
- [ ] Screen "Personal Records" liste tous PRs
- [ ] Affichage: exercice, record, date atteinte
- [ ] Animation célébration quand PR battu (confetti, haptic)

---

#### US-5.4: Statistiques globales
**As a** utilisateur  
**I want to** voir stats globales de mon activité  
**So that** je mesure mon engagement

**Acceptance Criteria:**
- [ ] Dashboard "Stats" affiche:
  - Total séances complétées
  - Total volume soulevé (all-time)
  - Streak actuel (jours consécutifs)
  - Exercice le plus fréquent
  - Temps total passé (durée séances cumulées)
- [ ] Mise à jour en temps réel après chaque séance
- [ ] Animations pour milestones (100 séances, 1000 sets, etc.)

---

#### US-5.5: Détails d'une séance passée
**As a** utilisateur  
**I want to** revoir détails d'une séance complétée  
**So that** je peux comparer avec présent

**Acceptance Criteria:**
- [ ] Tap sur séance dans historique = screen détails
- [ ] Affiche: date, durée, exercices, tous les sets
- [ ] Affiche notes si présentes
- [ ] Option "Use as Template" (réutiliser structure)
- [ ] Option "Repeat Workout" (refaire à l'identique)

---

### Technical Specifications

**BLoC Architecture:**
```dart
// HistoryBloc
class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  // Events
  LoadHistory(String exerciseId)
  LoadExerciseProgress(String exerciseId, Period period)
  CalculateStats()
  LoadSessionDetails(String sessionId)
  
  // States
  HistoryLoaded(List<WorkoutSession> sessions)
  ProgressLoaded(ExerciseProgress progress)
  StatsCalculated(GlobalStats stats)
  SessionDetailsLoaded(WorkoutSession session)
}

class ExerciseProgress {
  final List<DataPoint> maxWeightOverTime;
  final List<DataPoint> volumeOverTime;
  final PersonalRecords records;
}

class PersonalRecords {
  final double maxWeight;
  final int maxReps;
  final double maxVolume;
  final DateTime achievedAt;
}

class GlobalStats {
  final int totalWorkouts;
  final double totalVolume;
  final int currentStreak;
  final String mostFrequentExercise;
  final Duration totalTimeSpent;
}
```

**Chart Library:**
- `fl_chart: ^0.66.0`
- Custom theming pour dark/light mode
- Interactive tooltips

**Performance:**
- Queries optimisées avec indexes (exerciseId, date)
- Aggregation stats: calculated on-demand, cached 1h
- Graphiques: max 100 datapoints (sampling si > 100)

---

## Feature 6: Stockage local offline

**Priority:** P0 - Must Have  
**Effort Estimate:** 4 jours (M2)

### User Stories

#### US-6.1: Fonctionnement 100% offline
**As a** utilisateur  
**I want to** utiliser l'app sans connexion internet  
**So that** je peux tracker en salle même sans wifi/data

**Acceptance Criteria:**
- [ ] Aucune fonctionnalité ne requiert connexion
- [ ] Toutes données stockées localement (SQLite ou Hive)
- [ ] Pas de login/signup requis (Phase 1)
- [ ] App fonctionne en mode avion
- [ ] Pas de error messages "No internet"

---

#### US-6.2: Persistence robuste
**As a** utilisateur  
**I want to** que mes données soient sauvegardées de façon fiable  
**So that** je ne perds jamais mon historique

**Acceptance Criteria:**
- [ ] Transactions atomiques (ACID compliant si SQLite)
- [ ] Auto-save toutes les 30s pendant séance active
- [ ] Sauvegarde immédiate sur app backgrounded
- [ ] Tests: kill process → données intègres au redémarrage
- [ ] Corruption detection + recovery fallback

---

#### US-6.3: Performance avec large dataset
**As a** utilisateur avec 2+ ans d'usage  
**I want to** que l'app reste rapide  
**So that** je continue à l'utiliser long-terme

**Acceptance Criteria:**
- [ ] Performance testée avec dataset simulé:
  - 500 séances
  - 5000 exercices performed
  - 30000+ sets
- [ ] Temps chargement home screen: < 300ms
- [ ] Temps chargement historique exercice: < 300ms
- [ ] Scrolling fluide 60fps
- [ ] Database size: < 50MB pour 2 ans données

---

### Technical Specifications

**Database Choice:** SQLite (via `sqflite`) vs Hive

**Recommendation: SQLite** (justification finale à valider M2)
- ✅ Relationnel adapté aux requêtes complexes (stats, graphiques)
- ✅ Indexes performants
- ✅ ACID transactions
- ✅ Mature, éprouvé
- ❌ Légèrement plus verbeux que Hive

**Schema (SQLite):**
```sql
CREATE TABLE workouts (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  notes TEXT,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL
);

CREATE TABLE exercises (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  muscle_group TEXT NOT NULL,
  category TEXT NOT NULL,
  equipment_type TEXT NOT NULL,
  is_custom INTEGER NOT NULL DEFAULT 0,
  instructions TEXT,
  created_at INTEGER NOT NULL
);

CREATE INDEX idx_exercises_muscle_group ON exercises(muscle_group);
CREATE INDEX idx_exercises_name ON exercises(name);

CREATE TABLE workout_exercises (
  workout_id TEXT NOT NULL,
  exercise_id TEXT NOT NULL,
  order_index INTEGER NOT NULL,
  target_sets INTEGER,
  rest_time INTEGER,
  PRIMARY KEY (workout_id, exercise_id),
  FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE,
  FOREIGN KEY (exercise_id) REFERENCES exercises(id)
);

CREATE TABLE workout_sessions (
  id TEXT PRIMARY KEY,
  workout_id TEXT,
  start_time INTEGER NOT NULL,
  end_time INTEGER,
  status TEXT NOT NULL,
  notes TEXT,
  FOREIGN KEY (workout_id) REFERENCES workouts(id)
);

CREATE INDEX idx_sessions_start_time ON workout_sessions(start_time);

CREATE TABLE performed_exercises (
  id TEXT PRIMARY KEY,
  session_id TEXT NOT NULL,
  exercise_id TEXT NOT NULL,
  rest_time INTEGER,
  FOREIGN KEY (session_id) REFERENCES workout_sessions(id) ON DELETE CASCADE,
  FOREIGN KEY (exercise_id) REFERENCES exercises(id)
);

CREATE INDEX idx_performed_exercise_id ON performed_exercises(exercise_id);

CREATE TABLE set_records (
  id TEXT PRIMARY KEY,
  performed_exercise_id TEXT NOT NULL,
  set_number INTEGER NOT NULL,
  reps INTEGER NOT NULL,
  weight REAL NOT NULL,
  rpe INTEGER,
  timestamp INTEGER NOT NULL,
  FOREIGN KEY (performed_exercise_id) REFERENCES performed_exercises(id) ON DELETE CASCADE
);
```

**Repository Pattern:**
```dart
abstract class WorkoutRepository {
  Future<List<Workout>> getAllWorkouts();
  Future<Workout> getWorkoutById(String id);
  Future<void> createWorkout(Workout workout);
  Future<void> updateWorkout(Workout workout);
  Future<void> deleteWorkout(String id);
}

class SqliteWorkoutRepository implements WorkoutRepository {
  final Database db;
  // Implementation
}

// Future Phase 2: FirebaseWorkoutRepository implements WorkoutRepository
```

---

## 🎨 UI/UX Specifications

### Design System

**Theme:**
- Material Design 3 (Material You)
- Dark mode + Light mode support
- Primary color: Deep Blue (#1565C0) - énergie, focus
- Accent: Vibrant Orange (#FF6F00) - motivation, PRs
- Success: Green (#4CAF50)
- Error: Red (#F44336)

**Typography:**
- Headlines: Inter Bold
- Body: Inter Regular
- Numbers (sets/reps): Roboto Mono (monospace for alignment)

**Spacing:**
- Base unit: 8px
- Padding standard: 16px
- Component spacing: 12px

### Key Screens Wireframes

#### 1. Home Screen
```
┌─────────────────────────────────┐
│  ☰  PFT              [Profile]  │
├─────────────────────────────────┤
│                                 │
│  📊 Quick Stats                 │
│  ├─ 12 workouts this month      │
│  ├─ 3-day streak 🔥             │
│  └─ 85 tons lifted              │
│                                 │
│  💪 My Workouts                 │
│  ┌──────────────────────┐       │
│  │ Push Day             │  >    │
│  │ Last: 2 days ago     │       │
│  └──────────────────────┘       │
│  ┌──────────────────────┐       │
│  │ Pull Day             │  >    │
│  │ Last: 4 days ago     │       │
│  └──────────────────────┘       │
│  [+ New Workout]                │
│                                 │
│          [START WORKOUT]        │  <- FAB
└─────────────────────────────────┘
```

#### 2. Active Workout Screen
```
┌─────────────────────────────────┐
│  ← Push Day          [Finish]   │
├─────────────────────────────────┤
│  Exercise 1/5                   │
│  BARBELL BENCH PRESS            │
│                                 │
│  Last time: 3×8 @ 80kg          │
│                                 │
│  ─────────────────              │
│  Current Sets:                  │
│  ✓ Set 1:  8 reps @ 80kg        │
│  ✓ Set 2:  7 reps @ 80kg        │
│  ⏱ Set 3:  [RESTING - 1:45]     │
│                                 │
│  ─────────────────              │
│  Quick Add Next Set:            │
│  Reps:  [8]   Weight: [80] kg   │
│  [       ADD SET        ]       │
│                                 │
│  [     NEXT EXERCISE     ]      │
└─────────────────────────────────┘
```

#### 3. Timer Overlay (Semi-transparent)
```
┌─────────────────────────────────┐
│                                 │
│         RESTING                 │
│                                 │
│          2:15                   │  <- Huge countdown
│                                 │
│   [Pause] [Skip] [+30s]         │
│                                 │
│   (Tap outside to dismiss)      │
│                                 │
└─────────────────────────────────┘
```

#### 4. Exercise History Screen
```
┌─────────────────────────────────┐
│  ←  Barbell Bench Press         │
├─────────────────────────────────┤
│  📈 Progress Charts             │
│  [1M] [3M] [6M] [1Y] [All]      │
│                                 │
│     Max Weight                  │
│  90kg ┤        ●                │
│  85kg ┤     ●  │                │
│  80kg ┤  ●  │  │                │
│       └──────────               │
│                                 │
│  🏆 Personal Records            │
│  Max Weight: 90kg (2026-01-08)  │
│  Max Reps: 12 @ 60kg            │
│                                 │
│  📋 History                     │
│  ┌─────────────────────────┐   │
│  │ 2026-01-08              │   │
│  │ 3×8@80kg, 2×6@85kg      │   │
│  └─────────────────────────┘   │
│  ┌─────────────────────────┐   │
│  │ 2026-01-05              │   │
│  │ 3×8@80kg                │   │
│  └─────────────────────────┘   │
└─────────────────────────────────┘
```

### Interactions & Animations

**Microinteractions:**
- Button press: subtle scale + haptic
- Set added: slide-in animation + checkmark
- PR achieved: confetti animation + vibration burst
- Timer complete: pulsing animation + sound

**Transitions:**
- Screen navigation: Material motion (shared axis)
- Exercise switch: horizontal slide
- Modal sheets: slide up from bottom

**Haptic Feedback:**
- Set added: light impact
- PR achieved: heavy impact
- Timer complete: notification feedback
- Error: error feedback

---

## 🏗️ Technical Architecture

### Tech Stack Summary
- **Framework:** Flutter 3.x+ (Dart)
- **State Management:** `flutter_bloc` ^8.1.0
- **Persistence:** SQLite (`sqflite` ^2.3.0)
- **DI:** `get_it` ^7.6.0
- **Charts:** `fl_chart` ^0.66.0
- **Notifications:** `flutter_local_notifications` ^16.3.0
- **Wakelock:** `wakelock` ^0.6.2

### Clean Architecture Layers

```
lib/
├── main.dart
├── core/
│   ├── error/
│   ├── usecases/
│   ├── utils/
│   └── di/ (dependency injection)
├── domain/
│   ├── entities/
│   │   ├── workout.dart
│   │   ├── exercise.dart
│   │   ├── workout_session.dart
│   │   └── set_record.dart
│   ├── repositories/ (interfaces)
│   │   ├── workout_repository.dart
│   │   ├── exercise_repository.dart
│   │   └── session_repository.dart
│   └── usecases/
│       ├── get_workouts.dart
│       ├── create_workout.dart
│       ├── start_workout_session.dart
│       └── ...
├── data/
│   ├── models/ (entities + fromJson/toJson)
│   ├── datasources/
│   │   ├── local/
│   │   │   ├── database_helper.dart
│   │   │   └── workout_local_datasource.dart
│   │   └── (future: remote/)
│   └── repositories/ (implementations)
│       ├── workout_repository_impl.dart
│       └── ...
└── presentation/
    ├── blocs/
    │   ├── workout/
    │   ├── exercise/
    │   ├── active_workout/
    │   ├── timer/
    │   └── history/
    ├── screens/
    │   ├── home/
    │   ├── workout_builder/
    │   ├── active_workout/
    │   ├── exercise_history/
    │   └── settings/
    └── widgets/ (reusable components)
```

### Key BLoCs Overview

1. **WorkoutBloc** - CRUD séances
2. **ExerciseBloc** - Gestion base exercices
3. **ActiveWorkoutBloc** - Séance en cours (state critique)
4. **TimerBloc** - Timer de repos
5. **HistoryBloc** - Historique et stats

### Dependency Injection Setup

```dart
// di/injection_container.dart
final sl = GetIt.instance;

Future<void> init() async {
  // BLoCs
  sl.registerFactory(() => WorkoutBloc(getWorkouts: sl(), createWorkout: sl()));
  sl.registerFactory(() => ActiveWorkoutBloc(startSession: sl(), addSet: sl()));
  
  // Use cases
  sl.registerLazySingleton(() => GetWorkouts(sl()));
  sl.registerLazySingleton(() => CreateWorkout(sl()));
  
  // Repositories
  sl.registerLazySingleton<WorkoutRepository>(
    () => WorkoutRepositoryImpl(localDataSource: sl())
  );
  
  // Data sources
  sl.registerLazySingleton<WorkoutLocalDataSource>(
    () => WorkoutLocalDataSourceImpl(databaseHelper: sl())
  );
  
  // Core
  final db = await DatabaseHelper.instance.database;
  sl.registerLazySingleton(() => db);
}
```

---

## 📊 Success Metrics & Analytics

### Events to Track (Firebase Analytics)

**Onboarding:**
- `app_installed`
- `onboarding_started`
- `onboarding_completed`
- `first_workout_created`

**Core Actions:**
- `workout_started` (params: workout_id, workout_name)
- `workout_completed` (params: duration, exercises_count, sets_count)
- `workout_abandoned` (params: duration, completion_percentage)
- `set_added` (params: exercise_id, reps, weight)
- `pr_achieved` (params: exercise_id, record_type)

**Timer:**
- `timer_started` (params: duration)
- `timer_skipped`
- `timer_extended`

**Engagement:**
- `exercise_history_viewed` (params: exercise_id)
- `stats_viewed`
- `workout_duplicated`

### Dashboards to Monitor

**Acquisition:**
- Daily/Weekly/Monthly installs
- Install source (organic, ads if any)
- Conversion funnel: install → first workout created → first workout completed

**Engagement:**
- DAU / WAU / MAU
- Sessions per user per week
- Average session duration
- Sets per user per week

**Retention:**
- D1, D7, D30 retention cohorts
- Churn rate
- Weekly active users trend

**Quality:**
- Crash-free rate (Firebase Crashlytics)
- App Store ratings over time
- NPS score (in-app survey after 10 workouts)

**Performance:**
- Average set entry time (custom event)
- Workout completion rate
- Time to first meaningful paint

---

## 🚀 Roadmap & Milestones

### Phase 1 MVP Timeline (Q1 2026)

| Milestone | Date | Deliverables | Status |
|-----------|------|-------------|--------|
| **M1: Foundation** | 2026-01-24 | Flutter setup, architecture, data models, exercise DB | 🔜 |
| **M2: Core Data Layer** | 2026-02-07 | Repositories, SQLite, CRUD, tests | 📅 |
| **M3: Workout Management UI** | 2026-02-21 | Home, Workout Builder, Exercise Library | 📅 |
| **M4: Active Workout Flow** | 2026-03-14 | Active workout screen, set tracking, timer integration | 📅 |
| **M5: History & Analytics** | 2026-03-28 | Exercise history, graphiques, PRs, stats | 📅 |
| **M6: Polish & Alpha** | 2026-04-11 | UI polish, onboarding, TestFlight/Play Internal | 📅 |

**Alpha Testing:** 2026-04-11 à 2026-04-25 (2 semaines)
- 5-10 testeurs
- Objectif: validation UX, bugs critiques, mesure KPIs

**Beta Publique:** 2026-04-25
- Soumission App Store + Play Store
- Landing page
- Premiers 100 utilisateurs

**Launch v1.0:** 2026-06-15
- Version stable publique
- Marketing initial (Reddit, Discord, bouche-à-oreille)

---

## 🎯 Out of Scope (Phase 1)

**Deferred to Phase 2 (Q3-Q4 2026):**
- ❌ Cloud sync multi-devices
- ❌ User accounts / authentication
- ❌ Social features (amis, partage, feed)
- ❌ Gamification (badges, XP, achievements)
- ❌ Challenges entre utilisateurs

**Explicitly Excluded (Long-term/Never):**
- ❌ Plans nutrition intégrés
- ❌ Analyse vidéo de forme
- ❌ Coach IA / programmes générés
- ❌ Intégration wearables (Apple Watch, Garmin)
- ❌ Marketplace de programmes
- ❌ Fonctionnalités cardio/HIIT avancées

---

## 🧪 Testing Strategy

### Unit Tests
- **Target:** > 80% coverage
- **Focus:** BLoCs, use cases, repositories
- **Tools:** `test`, `mocktail`

### Widget Tests
- **Target:** All critical UI components
- **Focus:** Buttons, forms, lists, custom widgets
- **Tools:** `flutter_test`

### Integration Tests
- **Target:** Core user flows
- **Flows:**
  1. Create workout → Start workout → Add sets → Finish workout
  2. View exercise history → View graphiques
  3. Create custom exercise → Use in workout
- **Tools:** `integration_test`

### Performance Tests
- **Target:** Large dataset (2 years simulated)
- **Metrics:**
  - Screen load times < 300ms
  - Scrolling 60fps
  - Database queries < 100ms
- **Tools:** Flutter DevTools, custom benchmarks

### Manual Testing
- **Alpha testing:** 2 semaines, 5-10 users
- **Beta testing:** 2 semaines+, 50-100 users
- **Focus:** Real-world usage, edge cases, UX feedback

---

## 📝 Documentation Requirements

### Developer Documentation
- [ ] README.md (setup instructions)
- [ ] ARCHITECTURE.md (already exists, update)
- [ ] API_CONTRACTS.md (future Phase 2 prep)
- [ ] CONTRIBUTING.md (if open-source)

### User Documentation
- [ ] Onboarding in-app (interactive tutorial)
- [ ] Help center / FAQ (simple Notion page)
- [ ] Video demo (1-2 min, YouTube)

### Release Documentation
- [ ] CHANGELOG.md
- [ ] App Store description (FR + EN)
- [ ] Play Store description
- [ ] Privacy Policy (GDPR compliant, même offline)

---

## 🛡️ Risks & Mitigations

### Technical Risks

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|-----------|
| Performance dégradée avec gros historique | Medium | High | Tests avec dataset réaliste (100k+ sets), indexation optimisée, lazy loading |
| Perte de données (crash) | Medium | Critical | Auto-save 30s, state persistence, tests exhaustifs, backup local |
| Bugs critiques non détectés | Medium | High | Tests >80%, alpha testing 2 sem, crash reporting (Crashlytics) |

### Product Risks

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|-----------|
| UX trop complexe | Medium | Critical | User testing dès wireframes, onboarding <2min, analytics sur friction points |
| Valeur insuffisante vs papier/Excel | Low | High | Focus différenciation: Timer + Graphiques + PRs, valeur visible dès 3 séances |
| Base exercices incomplète | Medium | Medium | Commencer 50 essentiels = 90% usage, permettre customs, crowdsourcing Phase 2 |

### Market Risks

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|-----------|
| Concurrence forte (Strong, JEFIT, etc.) | High | Medium | Positionnement clair: Offline-first + Timer killer + UX moderne + Free |
| Adoption utilisateur faible | Medium | High | Landing page claire, ASO, bouche-à-oreille, contenu éducatif |
| Rétention faible | Medium | High | Push notifications intelligentes, streaks, email drip, Phase 2 social |

---

## 💰 Budget & Resources

### Development Costs (Q1 2026)
- Apple Developer: $99/an
- Google Play: $25 one-time
- Firebase Spark: $0 (< 10k events/jour)
- GitHub: $0 (free plan)
- Domain (optionnel): ~$12/an
- **Total MVP: ~$136**

### Post-Launch (Q2-Q3 2026)
- Firebase Blaze: ~$10-50/mois (si > 10k MAU)
- Marketing (optionnel): $0-500 (Reddit ads, ASO)

### Team
- **Solo developer** (Mathis)
- Timeline: 14 semaines (M1-M6)
- Effort: ~20-30h/semaine

---

## 📞 Stakeholders & Communication

### Internal
- **Product Owner:** Mathis
- **Developer:** Mathis
- **Designer:** Mathis (Material Design 3)

### External
- **Alpha Testers:** 5-10 pratiquants musculation (amis, famille, communauté locale)
- **Beta Testers:** 50-100 early adopters (Reddit r/fitness, Discord serveurs fitness)
- **Feedback channels:** 
  - Google Form (alpha/beta feedback)
  - Discord privé (alpha testers)
  - Email: feedback@pft-app.com (post-launch)

---

## ✅ Definition of Done

### For Each Feature:
- [ ] User stories completed with acceptance criteria met
- [ ] Unit tests written and passing (>80% coverage)
- [ ] Widget tests for UI components
- [ ] Code reviewed (self-review minimum)
- [ ] No critical bugs
- [ ] Performance validated (< 300ms loads)
- [ ] Dark/Light mode tested
- [ ] Accessibility basics (large touch targets, contrast)

### For MVP Launch:
- [ ] All P0 features completed
- [ ] Integration tests passing (core flows)
- [ ] Alpha testing completed (10 users, 2 weeks)
- [ ] Critical bugs fixed (crash-free > 99%)
- [ ] KPIs validated:
  - [ ] Set entry time < 10s
  - [ ] Workout completion rate > 80%
- [ ] App Store + Play Store assets ready
- [ ] Privacy Policy published
- [ ] Onboarding flow tested
- [ ] Crashlytics configured
- [ ] Analytics events validated

---

## 📚 Appendix

### Competitor Analysis Summary

| Competitor | Strengths | Weaknesses | Our Advantage |
|------------|-----------|------------|---------------|
| **Strong** | UI polie, cloud sync, graphiques avancés | Paywall €10/mois, compte obligatoire, complexe | Gratuit, offline, plus simple |
| **JEFIT** | Énorme base exercices (1300+), communauté | UI datée, ads intrusives, trop de features | UX moderne, focus, pas d'ads |
| **FitNotes** | Simple, gratuit, offline | Android only, UI basique, pas de timer | iOS+Android, timer killer, UX moderne |
| **Hevy** | UX moderne, social features, freemium équilibré | Connexion requise, cloud-dependent | Offline-first, timer meilleur |

### Exercise Database (50+ Initial)
See US-2.1 for full list. Categories: Chest (6), Back (7), Shoulders (6), Arms (6), Legs (8), Core (4).

### Glossary
- **MAU:** Monthly Active Users
- **DAU:** Daily Active Users
- **NPS:** Net Promoter Score
- **PR:** Personal Record
- **RPE:** Rate of Perceived Exertion (1-10)
- **RIR:** Reps In Reserve
- **1RM:** One-Rep Max (max weight for 1 rep)
- **Volume:** Sets × Reps × Weight

---

## 📋 Change Log

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | 2026-01-11 | Mathis | Initial PRD creation from project brief |

---

**Document Status:** ✅ Ready for Development  
**Next Steps:** 
1. Technical review with team (self-review)
2. Finalize SQLite vs Hive decision (M2)
3. Start M1: Foundation & Setup (2026-01-13)

---

*End of PRD*

