# 🏗️ PFT Architecture Documentation

**Version:** 1.0  
**Date:** 2026-01-11  
**Architecte:** Winston 🏗️  
**Status:** Implementation Ready

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Architecture Pattern](#architecture-pattern)
3. [Project Structure](#project-structure)
4. [State Management](#state-management)
5. [Database Schema](#database-schema)
6. [Dependency Injection](#dependency-injection)
7. [Key Design Decisions](#key-design-decisions)
8. [Performance Considerations](#performance-considerations)

---

## Overview

PFT (Performance Fitness Tracker) est une application mobile Flutter utilisant **Clean Architecture** avec **BLoC** pour le state management et **SQLite** pour le stockage local offline-first.

### Principes Architecturaux

1. **Separation of Concerns** - 3 layers: Domain, Data, Presentation
2. **Dependency Rule** - Les dépendances pointent toujours vers le Domain
3. **Testability** - >80% test coverage target
4. **Offline-First** - Toutes les fonctionnalités fonctionnent sans internet
5. **Performance** - 60 FPS animations, < 10s set entry time

---

## Architecture Pattern

### Clean Architecture (Uncle Bob)

```
┌─────────────────────────────────────────────────────────┐
│                   PRESENTATION LAYER                     │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   Screens    │  │   Widgets    │  │    BLoCs     │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                     DOMAIN LAYER                         │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   Entities   │  │  Use Cases   │  │ Repositories │  │
│  │  (Business)  │  │  (Business)  │  │ (Interfaces) │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                          │
                          ▼
┌─────────────────────────────────────────────────────────┐
│                      DATA LAYER                          │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │    Models    │  │ Repositories │  │ Data Sources │  │
│  │    (DTOs)    │  │    (Impl)    │  │   (SQLite)   │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### Layer Responsibilities

#### Presentation Layer
- **Screens**: Page-level widgets (WorkoutListScreen, ActiveWorkoutScreen, etc.)
- **Widgets**: Reusable UI components (ExerciseCard, SetInputWidget, etc.)
- **BLoCs**: State management, business logic orchestration

#### Domain Layer
- **Entities**: Core business objects (Workout, Exercise, WorkoutSession, etc.)
- **Use Cases**: Single-responsibility business operations (CreateWorkout, TrackSet, etc.)
- **Repository Interfaces**: Abstract contracts for data access

#### Data Layer
- **Models**: DTOs with JSON/SQLite serialization
- **Repository Implementations**: Concrete data access logic
- **Data Sources**: SQLite database operations

---

## Project Structure

```
lib/
├── main.dart                      # App entry point
│
├── core/                          # Shared utilities
│   ├── di/
│   │   └── injection.dart         # GetIt dependency injection
│   ├── utils/
│   │   ├── constants.dart
│   │   ├── extensions.dart
│   │   └── validators.dart
│   ├── constants/
│   │   └── app_constants.dart
│   └── services/
│       ├── database_helper.dart   # SQLite initialization
│       ├── seed_service.dart      # Initial data seeding
│       └── notification_service.dart
│
├── data/
│   ├── models/                    # DTOs with serialization
│   │   ├── workout_model.dart
│   │   ├── exercise_model.dart
│   │   ├── workout_session_model.dart
│   │   ├── performed_exercise_model.dart
│   │   ├── set_record_model.dart
│   │   ├── personal_record_model.dart
│   │   └── settings_model.dart
│   │
│   ├── datasources/
│   │   └── local/
│   │       ├── workout_local_datasource.dart
│   │       ├── exercise_local_datasource.dart
│   │       ├── session_local_datasource.dart
│   │       ├── history_local_datasource.dart
│   │       └── settings_local_datasource.dart
│   │
│   └── repositories/              # Repository implementations
│       ├── workout_repository_impl.dart
│       ├── exercise_repository_impl.dart
│       ├── session_repository_impl.dart
│       ├── history_repository_impl.dart
│       ├── stats_repository_impl.dart
│       └── settings_repository_impl.dart
│
├── domain/
│   ├── entities/                  # Business objects
│   │   ├── workout.dart
│   │   ├── workout_exercise.dart
│   │   ├── exercise.dart
│   │   ├── exercise_enums.dart    # MuscleGroup, Category, Equipment
│   │   ├── workout_session.dart
│   │   ├── performed_exercise.dart
│   │   ├── set_record.dart
│   │   ├── personal_record.dart
│   │   └── app_settings.dart
│   │
│   ├── repositories/              # Repository interfaces
│   │   ├── workout_repository.dart
│   │   ├── exercise_repository.dart
│   │   ├── session_repository.dart
│   │   ├── history_repository.dart
│   │   ├── stats_repository.dart
│   │   └── settings_repository.dart
│   │
│   └── usecases/                  # Business logic operations
│       ├── workout/
│       │   ├── create_workout.dart
│       │   ├── get_workouts.dart
│       │   ├── update_workout.dart
│       │   ├── delete_workout.dart
│       │   └── duplicate_workout.dart
│       ├── exercise/
│       │   ├── get_exercises.dart
│       │   ├── search_exercises.dart
│       │   ├── create_custom_exercise.dart
│       │   └── delete_custom_exercise.dart
│       ├── session/
│       │   ├── start_workout_session.dart
│       │   ├── track_set.dart
│       │   ├── finish_session.dart
│       │   └── abandon_session.dart
│       ├── history/
│       │   ├── get_workout_history.dart
│       │   ├── get_session_details.dart
│       │   └── get_exercise_history.dart
│       └── stats/
│           ├── calculate_personal_records.dart
│           ├── get_stats_dashboard.dart
│           └── get_progress_data.dart
│
└── presentation/
    ├── blocs/                     # State management
    │   ├── workout/
    │   │   ├── workout_bloc.dart
    │   │   ├── workout_event.dart
    │   │   └── workout_state.dart
    │   ├── exercise/
    │   │   ├── exercise_bloc.dart
    │   │   ├── exercise_event.dart
    │   │   └── exercise_state.dart
    │   ├── active_workout/
    │   │   ├── active_workout_bloc.dart
    │   │   ├── active_workout_event.dart
    │   │   └── active_workout_state.dart
    │   ├── timer/
    │   │   ├── timer_bloc.dart
    │   │   ├── timer_event.dart
    │   │   └── timer_state.dart
    │   ├── history/
    │   │   ├── history_bloc.dart
    │   │   ├── history_event.dart
    │   │   └── history_state.dart
    │   ├── stats/
    │   │   ├── stats_bloc.dart
    │   │   ├── stats_event.dart
    │   │   └── stats_state.dart
    │   └── settings/
    │       ├── settings_bloc.dart
    │       ├── settings_event.dart
    │       └── settings_state.dart
    │
    ├── screens/                   # Page-level widgets
    │   ├── home/
    │   │   └── home_screen.dart
    │   ├── workouts/
    │   │   ├── workout_list_screen.dart
    │   │   ├── workout_builder_screen.dart
    │   │   └── workout_detail_screen.dart
    │   ├── exercises/
    │   │   ├── exercise_list_screen.dart
    │   │   └── exercise_search_screen.dart
    │   ├── active_workout/
    │   │   ├── active_workout_screen.dart
    │   │   └── workout_summary_screen.dart
    │   ├── history/
    │   │   ├── history_screen.dart
    │   │   └── session_detail_screen.dart
    │   ├── stats/
    │   │   ├── stats_dashboard_screen.dart
    │   │   └── exercise_progress_screen.dart
    │   ├── settings/
    │   │   └── settings_screen.dart
    │   └── onboarding/
    │       └── onboarding_screen.dart
    │
    └── widgets/                   # Reusable components
        ├── common/
        │   ├── loading_shimmer.dart
        │   ├── error_widget.dart
        │   └── empty_state.dart
        ├── workout/
        │   ├── workout_card.dart
        │   └── exercise_selector.dart
        ├── exercise/
        │   ├── exercise_card.dart
        │   └── exercise_filter.dart
        ├── active_workout/
        │   ├── exercise_set_item.dart
        │   ├── set_input_widget.dart
        │   └── rest_timer_widget.dart
        ├── history/
        │   └── session_card.dart
        └── stats/
            └── progress_chart.dart

assets/
├── data/
│   ├── exercises.json             # 50+ seeded exercises
│   └── workout_templates.json     # 6 pre-configured templates
└── sounds/
    └── timer_complete.mp3
```

---

## State Management

### BLoC Pattern (Business Logic Component)

**7 BLoCs Total:**

#### 1. WorkoutBloc
**Responsibility:** Workout CRUD + templates  
**Key Events:**
- `LoadWorkouts`
- `CreateWorkout`
- `UpdateWorkout`
- `DeleteWorkout`
- `DuplicateWorkout`
- `LoadTemplates`

**Key States:**
- `WorkoutsLoaded`
- `WorkoutCreated`
- `WorkoutUpdated`
- `WorkoutDeleted`

#### 2. ExerciseBloc
**Responsibility:** Exercise management + search/filter  
**Key Events:**
- `LoadExercises`
- `SearchExercises`
- `FilterExercises`
- `CreateCustomExercise`
- `DeleteCustomExercise`

**Key States:**
- `ExercisesLoaded`
- `ExercisesFiltered`
- `CustomExerciseCreated`

#### 3. ActiveWorkoutBloc
**Responsibility:** Active session state management  
**Key Events:**
- `StartWorkout`
- `AddExercise`
- `TrackSet`
- `CompleteExercise`
- `FinishWorkout`
- `AbandonWorkout`

**Key States:**
- `WorkoutInProgress`
- `SetTracked`
- `WorkoutCompleted`
- `WorkoutAbandoned`

#### 4. TimerBloc
**Responsibility:** Rest timer logic  
**Key Events:**
- `StartTimer`
- `PauseTimer`
- `ResumeTimer`
- `SkipTimer`
- `AdjustTimer`
- `TimerTick`

**Key States:**
- `TimerRunning`
- `TimerPaused`
- `TimerCompleted`

#### 5. HistoryBloc
**Responsibility:** History + session details  
**Key Events:**
- `LoadHistory`
- `FilterHistory`
- `LoadSessionDetails`
- `RepeatWorkout`

**Key States:**
- `HistoryLoaded`
- `SessionDetailsLoaded`

#### 6. StatsBloc
**Responsibility:** Personal records + stats dashboard  
**Key Events:**
- `LoadPersonalRecords`
- `LoadStatsDashboard`
- `LoadProgressCharts`
- `LoadExerciseHistory`

**Key States:**
- `PersonalRecordsLoaded`
- `StatsLoaded`
- `ProgressChartsLoaded`

#### 7. SettingsBloc
**Responsibility:** App settings  
**Key Events:**
- `LoadSettings`
- `UpdateSettings`
- `ToggleTheme`
- `ToggleNotifications`
- `ExportData`

**Key States:**
- `SettingsLoaded`
- `SettingsUpdated`
- `DataExported`

### BLoC Communication

```
┌─────────────────┐
│  ExerciseBloc   │ → Provides exercises
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  WorkoutBloc    │ → Creates workouts with exercises
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ActiveWorkoutBloc│ → Executes workout, tracks sets
└────────┬────────┘
         │
         ├──→ TimerBloc (rest timer)
         │
         └──→ StatsBloc (PRs, history)
```

---

## Database Schema

### SQLite Database (7 Tables)

#### 1. `workouts` table
```sql
CREATE TABLE workouts (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  notes TEXT,
  created_at INTEGER NOT NULL,
  updated_at INTEGER NOT NULL,
  is_template INTEGER DEFAULT 0
);

CREATE INDEX idx_is_template ON workouts(is_template);
CREATE INDEX idx_created_at ON workouts(created_at);
```

#### 2. `workout_exercises` table (Join table)
```sql
CREATE TABLE workout_exercises (
  id TEXT PRIMARY KEY,
  workout_id TEXT NOT NULL,
  exercise_id TEXT NOT NULL,
  order_index INTEGER NOT NULL,
  target_sets INTEGER,
  rest_time INTEGER,
  FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE CASCADE,
  FOREIGN KEY (exercise_id) REFERENCES exercises(id)
);

CREATE INDEX idx_workout_id ON workout_exercises(workout_id);
```

#### 3. `exercises` table
```sql
CREATE TABLE exercises (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  muscle_group TEXT NOT NULL,
  category TEXT NOT NULL,
  equipment_type TEXT NOT NULL,
  is_custom INTEGER DEFAULT 0,
  instructions TEXT,
  created_at INTEGER NOT NULL
);

CREATE INDEX idx_muscle_group ON exercises(muscle_group);
CREATE INDEX idx_is_custom ON exercises(is_custom);
CREATE INDEX idx_name ON exercises(name);
```

#### 4. `workout_sessions` table
```sql
CREATE TABLE workout_sessions (
  id TEXT PRIMARY KEY,
  workout_id TEXT,
  start_time INTEGER NOT NULL,
  end_time INTEGER,
  status TEXT NOT NULL,
  notes TEXT,
  FOREIGN KEY (workout_id) REFERENCES workouts(id) ON DELETE SET NULL
);

CREATE INDEX idx_sessions_start_time ON workout_sessions(start_time);
CREATE INDEX idx_sessions_status ON workout_sessions(status);
```

#### 5. `performed_exercises` table
```sql
CREATE TABLE performed_exercises (
  id TEXT PRIMARY KEY,
  session_id TEXT NOT NULL,
  exercise_id TEXT NOT NULL,
  order_index INTEGER NOT NULL,
  rest_time INTEGER,
  FOREIGN KEY (session_id) REFERENCES workout_sessions(id) ON DELETE CASCADE,
  FOREIGN KEY (exercise_id) REFERENCES exercises(id)
);

CREATE INDEX idx_performed_session ON performed_exercises(session_id);
CREATE INDEX idx_performed_exercise ON performed_exercises(exercise_id);
```

#### 6. `set_records` table
```sql
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

CREATE INDEX idx_set_performed ON set_records(performed_exercise_id);
CREATE INDEX idx_set_timestamp ON set_records(timestamp);
```

#### 7. `personal_records` table
```sql
CREATE TABLE personal_records (
  id TEXT PRIMARY KEY,
  exercise_id TEXT NOT NULL,
  record_type TEXT NOT NULL,
  value REAL NOT NULL,
  achieved_date INTEGER NOT NULL,
  session_id TEXT NOT NULL,
  FOREIGN KEY (exercise_id) REFERENCES exercises(id),
  FOREIGN KEY (session_id) REFERENCES workout_sessions(id)
);

CREATE INDEX idx_pr_exercise ON personal_records(exercise_id);
CREATE INDEX idx_pr_type ON personal_records(record_type);
```

### Database Relationships

```
workouts (1) ──→ (N) workout_exercises ──→ (1) exercises
                                                    ↑
                                                    │
workout_sessions (1) ──→ (N) performed_exercises ──┘
                                ↓
                           set_records

workout_sessions (1) ──→ (N) personal_records ──→ (1) exercises
```

---

## Dependency Injection

### GetIt Configuration

```dart
// lib/core/di/injection.dart

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Database
  final database = await DatabaseHelper.instance.database;
  getIt.registerSingleton<Database>(database);

  // Data Sources
  getIt.registerLazySingleton<ExerciseLocalDataSource>(
    () => ExerciseLocalDataSourceImpl(getIt()),
  );
  // ... other data sources

  // Repositories
  getIt.registerLazySingleton<ExerciseRepository>(
    () => ExerciseRepositoryImpl(getIt()),
  );
  // ... other repositories

  // Use Cases
  getIt.registerLazySingleton(() => GetExercises(getIt()));
  getIt.registerLazySingleton(() => SearchExercises(getIt()));
  // ... other use cases

  // BLoCs (as factories for multiple instances)
  getIt.registerFactory(() => ExerciseBloc(
    getExercises: getIt(),
    searchExercises: getIt(),
    // ... other use cases
  ));
  // ... other blocs

  // Services
  getIt.registerLazySingleton(() => NotificationService());
  getIt.registerLazySingleton(() => SeedService(getIt()));
}
```

---

## Key Design Decisions

### 1. Why Clean Architecture?
- **Testability**: Domain layer can be tested without UI or database
- **Maintainability**: Clear separation allows easy refactoring
- **Scalability**: Easy to add features without breaking existing code
- **Team collaboration**: Different team members can work on different layers

### 2. Why BLoC over other state management?
- **Predictable**: Events → BLoC → States (unidirectional flow)
- **Testable**: Easy to mock and test business logic
- **Scalable**: Works well with complex state requirements
- **Community**: Strong Flutter community support

### 3. Why SQLite over Hive/SharedPreferences?
- **Relational data**: Foreign keys, joins, complex queries
- **ACID compliance**: Transaction safety for critical data
- **Performance**: Optimized for large datasets with indexes
- **Maturity**: Battle-tested, well-documented

### 4. Why Offline-First?
- **User experience**: Works in gym (often poor connectivity)
- **Performance**: No network latency
- **Privacy**: Data stays on device
- **Simplicity**: No backend infrastructure (Phase 1)

### 5. Enum Strategy
```dart
// Using sealed classes for type-safe enums with extensions
enum MuscleGroup {
  chest, back, shoulders, arms, legs, core;
  
  String get displayName => switch (this) {
    chest => 'Chest',
    back => 'Back',
    shoulders => 'Shoulders',
    arms => 'Arms',
    legs => 'Legs',
    core => 'Core',
  };
}
```

---

## Performance Considerations

### Critical Performance KPIs

| KPI | Target | Implementation Strategy |
|-----|--------|------------------------|
| Set entry time | < 10s | Smart defaults, minimal taps, keyboard optimization |
| Exercise list load | < 100ms | SQLite indexes, lazy loading, caching |
| Search/filter | < 50ms | Debouncing, indexed queries, in-memory filtering |
| History load | < 300ms | Pagination (20 items), lazy load details |
| Screen transitions | < 500ms | Hero animations, preloading |
| Animations | 60 FPS | RepaintBoundary, const constructors |

### Optimization Strategies

#### 1. Database Optimization
- **Indexes**: All foreign keys + frequently queried fields
- **Batch operations**: Use transactions for multiple inserts
- **Query optimization**: SELECT only needed columns
- **Pagination**: Load 20-50 items at a time

#### 2. UI Performance
```dart
// Use const constructors
const Text('Label');

// RepaintBoundary for complex widgets
RepaintBoundary(
  child: ComplexChart(),
);

// Lazy loading lists
ListView.builder(
  itemBuilder: (context, index) => ExerciseCard(...),
);
```

#### 3. State Management Performance
- **Equatable**: Prevent unnecessary rebuilds
- **Selective BlocBuilder**: Only rebuild affected widgets
```dart
BlocBuilder<ExerciseBloc, ExerciseState>(
  buildWhen: (previous, current) => 
    previous.exercises != current.exercises,
  builder: (context, state) => ...,
);
```

#### 4. Memory Management
- **Dispose controllers**: TextEditingControllers, AnimationControllers
- **Cancel subscriptions**: BLoC subscriptions, timers
- **Image caching**: Use cached_network_image (future feature)

### Performance Profiling

**Tools:**
- Flutter DevTools (CPU, Memory, Performance)
- Dart Observatory
- Timeline view

**Metrics to track:**
- Frame rendering time
- Memory usage
- Database query duration
- BLoC event processing time

---

## Testing Strategy

### Unit Tests (>80% Coverage)

**Domain Layer:**
- ✅ All Use Cases
- ✅ Entity business logic
- ✅ Repository interfaces (mocked)

**Data Layer:**
- ✅ Models (serialization/deserialization)
- ✅ Repository implementations
- ✅ Data sources (with test database)

**Presentation Layer:**
- ✅ BLoCs (with bloc_test)
- ✅ Widget-level logic

### Widget Tests

**Critical Screens:**
- ✅ ActiveWorkoutScreen (core flow)
- ✅ WorkoutBuilderScreen (CRUD)
- ✅ ExerciseListScreen (search/filter)

**Critical Widgets:**
- ✅ SetInputWidget (< 10s KPI)
- ✅ RestTimerWidget (timer accuracy)
- ✅ ExerciseCard (interactions)

### Integration Tests

**Critical Flows:**
1. Create Workout → Start → Track Sets → Finish
2. Timer: Auto-start → Controls → Complete
3. PR Detection → Celebration → History

---

## Security Considerations

### Data Privacy
- ✅ No data sent to external servers (Phase 1)
- ✅ No user authentication required
- ✅ Data stays on device
- ✅ Export feature uses local sharing only

### Data Integrity
- ✅ SQLite transactions (ACID)
- ✅ Foreign key constraints
- ✅ Input validation at domain layer
- ✅ Auto-save every 30s during active workout

---

## Future Considerations (Phase 2+)

### Backend Integration
- User authentication
- Cloud sync (conflict resolution)
- Social features (share workouts, follow friends)

### Advanced Features
- AI workout recommendations
- Form check (video analysis)
- Wearable integration
- Coach/trainer features

### Platform Expansion
- Web app (Flutter Web)
- Desktop app (macOS, Windows)
- Watch app (Apple Watch, Wear OS)

---

## References

- [Clean Architecture (Uncle Bob)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter BLoC Package](https://bloclibrary.dev/)
- [SQLite Documentation](https://www.sqlite.org/docs.html)
- [Flutter Performance Best Practices](https://docs.flutter.dev/perf/best-practices)

---

*Architecture Document v1.0 - Ready for Implementation*  
*Generated: 2026-01-11*  
*Next Review: After Sprint 2*

