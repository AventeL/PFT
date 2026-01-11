# 🏋️ PFT - Performance Fitness Tracker

[![Flutter](https://img.shields.io/badge/Flutter-3.0+-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.0+-blue.svg)](https://dart.dev/)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

> Track your workouts with the most intelligent rest timer on the market. Offline-first. No BS.

---

## 🎯 MVP Status

**Phase:** Sprint Planning Complete - Ready for Implementation  
**Stories:** 29/29 (100%)  
**Architecture:** Clean Architecture + BLoC  
**Target Launch:** Q1 2026

---

## 📋 Quick Start

### Prerequisites

- Flutter SDK 3.0+
- Dart 3.0+
- Android Studio / VS Code
- iOS: Xcode 14+
- Android: Android SDK 21+

### Installation

```bash
# Clone the repo
git clone <repo-url>
cd PFT

# Install dependencies
flutter pub get

# Run code generation (after implementing models)
flutter pub run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

### First Time Setup

The app will automatically:
1. Create SQLite database (7 tables)
2. Seed 52 exercises
3. Load 6 workout templates
4. Initialize settings

---

## 🏗️ Architecture

**Pattern:** Clean Architecture (Uncle Bob)  
**State Management:** BLoC (flutter_bloc)  
**Database:** SQLite (sqflite)  
**DI:** GetIt

### Project Structure

```
lib/
├── core/           # Shared utilities, DI, services
├── data/           # Models, datasources, repository implementations
├── domain/         # Entities, repository interfaces, use cases
└── presentation/   # BLoCs, screens, widgets
```

See [ARCHITECTURE.md](docs/ARCHITECTURE.md) for details.

---

## 📚 Documentation

### For Developers

- **[ARCHITECTURE.md](docs/ARCHITECTURE.md)** - Architecture deep dive
- **[SPRINT-PLANNING.md](docs/SPRINT-PLANNING.md)** - 4 sprints breakdown
- **[IMPLEMENTATION-READINESS-REPORT.md](docs/IMPLEMENTATION-READINESS-REPORT.md)** - Readiness assessment

### For Product/PM

- **[PRD](.bmad-core/outputs/pft-mvp-prd.md)** - Product Requirements Document
- **[Stories Index](docs/stories/INDEX.md)** - All 29 user stories
- **[Roadmap](docs/stories/ROADMAP.md)** - Feature roadmap

---

## 🚀 Sprint Planning

### Sprint 1: Foundation (Days 1-10)
- ✅ Setup project + Clean Architecture
- ✅ Database + seed data
- ✅ Story 2.1: Exercise Database
- ✅ Story 2.2: Search/Filter Exercises

### Sprint 2: Core Flow (Days 11-20)
- Story 1.1-1.3: Workout CRUD
- Story 3.1-3.3: Active workout session
- **KPI:** Set entry < 10 seconds

### Sprint 3: Killer Feature (Days 21-30)
- Story 4.1-4.5: Rest timer (auto-start, notifications, background)
- Story 5.1-5.2: History

### Sprint 4: Polish (Days 31-42)
- Story 6.x: Stats & PRs
- Story 7.x: Settings
- Story 8.x: Onboarding
- Final polish + alpha release

**Total:** 42 days → MVP Ready

---

## 🎯 Performance KPIs

| KPI | Target | Status |
|-----|--------|--------|
| Set entry time | < 10s | 🎯 Target |
| Exercise list load | < 100ms | 🎯 Target |
| Search/filter | < 50ms | 🎯 Target |
| History load | < 300ms | 🎯 Target |
| Animations | 60 FPS | 🎯 Target |
| Test coverage | > 80% | 🎯 Target |

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# View coverage (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

**Coverage Target:** >80%

---

## 📦 Tech Stack

### Core (5)
- `flutter_bloc` - State management
- `sqflite` - Local database
- `get_it` - Dependency injection
- `uuid` - ID generation
- `equatable` - Value equality

### Features (6)
- `wakelock_plus` - Keep screen on
- `flutter_local_notifications` - Timer alerts
- `audioplayers` - Timer sound
- `shared_preferences` - Settings
- `intl` - Date formatting
- `timezone` - Scheduled notifications

### UX (3)
- `shimmer` - Loading states
- `confetti` - PR celebrations
- `fl_chart` - Progress charts

### Utils (3)
- `path_provider` - File storage
- `share_plus` - Data export
- `introduction_screen` - Onboarding

---

## 🗄️ Database Schema

**7 Tables:**
1. `workouts` - Workout definitions
2. `workout_exercises` - Exercises in workouts
3. `exercises` - Exercise database (52 seeded)
4. `workout_sessions` - Completed sessions
5. `performed_exercises` - Exercises in sessions
6. `set_records` - Individual sets (reps, weight, RPE)
7. `personal_records` - PRs by exercise

**Indexes:** 10 strategic indexes for performance

See [ARCHITECTURE.md](docs/ARCHITECTURE.md) for SQL schema.

---

## 🎨 Design Principles

### UX Guidelines (Story 0)

**Loading States:**
- ✅ Shimmer effects (no spinners)
- ✅ Skeleton screens
- ✅ Show structure while loading

**Animations:**
- ✅ < 300ms transitions
- ✅ 60 FPS guaranteed
- ✅ Non-blocking (user can interact)
- ✅ `easeInOut` / `easeOut` curves

**Performance:**
- ✅ Set entry < 10s (CRITICAL)
- ✅ RepaintBoundary for complex widgets
- ✅ Const constructors everywhere

---

## 🔥 Killer Features

### 1. Smart Rest Timer
- Auto-starts after each set
- Compound: 3min, Isolation: 90s
- Notifications: 10s warning + completion
- Background execution (iOS/Android)
- Controls: pause, skip, ±30s

### 2. Personal Records
- Auto-detection (max weight, reps, volume)
- Confetti celebration 🎊
- History tracking

### 3. Offline-First
- 100% functional without internet
- No login required (Phase 1)
- All data local (SQLite)

---

## 🐛 Known Issues

None yet - we're just starting! 🚀

---

## 📝 Contributing

### Story Loop Workflow

1. Pick a story from [Sprint Planning](docs/SPRINT-PLANNING.md)
2. Read story file in `docs/stories/`
3. Implement following Clean Architecture
4. Write tests (>80% coverage)
5. Update story status
6. Move to next story

### Code Standards

- Clean Architecture layers respected
- BLoC for all state management
- Repository pattern for data access
- Equatable for value objects
- Tests for all business logic

---

## 🎯 Success Metrics (MVP Launch)

- [ ] 10 alpha users (3+ sessions/week)
- [ ] 80% session completion rate
- [ ] < 10s set entry time
- [ ] 99% crash-free rate
- [ ] >80% test coverage

---

## 📞 Team

- **PM:** John 📋
- **Architect:** Winston 🏗️
- **Scrum Master:** Bob 🏃
- **Dev:** [Your name here]

---

## 🚀 Let's Build!

**Next Steps:**
1. ✅ Read [ARCHITECTURE.md](docs/ARCHITECTURE.md)
2. ✅ Pick Story 2.1 from [Sprint Planning](docs/SPRINT-PLANNING.md)
3. ✅ Implement following [Story 2.1](docs/stories/2.1.exercise-database.md)
4. ✅ Write tests
5. ✅ Repeat!

**Timeline:** 42 days → MVP in your hands! 💪

---

*Generated by BMad™ Core - 2026-01-11*  
*Ready for Story Loops! 🔄*

