# PFT MVP - Story Roadmap

**Generated:** 2026-01-11  
**Status:** Planning Phase  
**Total Stories:** ~25-30 (estimated)

---

## Overview

Ce document présente la roadmap complète des user stories pour le MVP de PFT, organisées par Epic (Feature). Chaque story sera créée progressivement selon les besoins du développement.

---

## Epic 1: Gestion des séances d'entraînement (Feature 1)
**Priority:** P0 - Must Have  
**Effort Estimate:** 5 jours

### Stories
- [x] **1.1 - Créer une séance personnalisée** ✅ CREATED
  - Status: Draft
  - File: `docs/stories/1.1.create-workout.md`
  - AC Count: 7
  - Est: 2-3 jours

- [ ] **1.2 - Utiliser templates pré-configurés**
  - Status: Not Started
  - AC Count: 4
  - Templates: Push/Pull/Legs, Upper/Lower, Full Body
  - Est: 1 jour

- [ ] **1.3 - Éditer/supprimer séances existantes**
  - Status: Not Started
  - AC Count: 5
  - Est: 1 jour

- [ ] **1.4 - Dupliquer une séance existante**
  - Status: Not Started
  - AC Count: 4
  - Est: 0.5 jour

- [ ] **1.5 - Ajouter notes à une séance**
  - Status: Not Started
  - AC Count: 4
  - Est: 0.5 jour

---

## Epic 2: Base de données d'exercices (Feature 2)
**Priority:** P0 - Must Have  
**Effort Estimate:** 3 jours

### Stories
- [x] **2.1 - Accéder à une base d'exercices pré-chargée** ✅ CREATED
  - Status: Draft
  - File: `docs/stories/2.1.exercise-database.md`
  - AC Count: 5
  - 50+ exercises in JSON
  - Est: 1.5 jours

- [x] **2.2 - Rechercher et filtrer exercices** ✅ CREATED
  - Status: Draft
  - File: `docs/stories/2.2.search-filter-exercises.md`
  - AC Count: 6
  - Search by name, filter by muscle group
  - Est: 1 jour

- [ ] **2.3 - Créer exercices personnalisés**
  - Status: Not Started
  - AC Count: 6
  - Custom exercises with tags
  - Est: 0.5 jour

---

## Epic 3: Exécution de séance (Feature 3)
**Priority:** P0 - Must Have  
**Effort Estimate:** 5 jours

### Stories
- [x] **3.1 - Démarrer une séance d'entraînement** ✅ CREATED
  - Status: Draft
  - File: `docs/stories/3.1.start-workout-session.md`
  - AC Count: 7
  - Active workout mode
  - Est: 2 jours

- [x] **3.2 - Tracker séries et performances** ✅ CREATED
  - Status: Draft
  - File: `docs/stories/3.2.track-sets.md`
  - AC Count: 8
  - Quick set entry (<10s)
  - Est: 2 jours

- [x] **3.3 - Terminer/Abandonner séance** ✅ CREATED
  - Status: Draft
  - File: `docs/stories/3.3.finish-abandon-workout.md`
  - AC Count: 7
  - Complete or abandon with confirmation
  - Est: 1.5 jours

---

## Epic 4: Timer de repos (Feature 4) 🔥 KILLER FEATURE
**Priority:** P0 - Must Have  
**Effort Estimate:** 3 jours

### Stories
- [x] **4.1 - Timer automatique entre séries** ✅ CREATED
  - Status: Draft
  - File: `docs/stories/4.1.auto-timer.md`
  - AC Count: 6
  - Auto-start after set
  - Est: 1.5 jours

- [x] **4.2 - Notifications timer (son + vibration)** ✅ CREATED
  - Status: Draft
  - File: `docs/stories/4.2.timer-notifications.md`
  - AC Count: 5
  - 10s warning, completion alert
  - Est: 1 jour

- [ ] **4.3 - Personnalisation temps de repos**
  - Status: Not Started
  - AC Count: 5
  - Custom rest times per exercise
  - Est: 0.5 jour

- [ ] **4.4 - Contrôles timer (pause, skip, extend)**
  - Status: Not Started
  - AC Count: 5
  - Timer controls overlay
  - Est: 0.5 jour

- [ ] **4.5 - Timer en background**
  - Status: Not Started
  - AC Count: 4
  - Background timer + notifications
  - Est: 0.5 jour

---

## Epic 5: Historique des séances (Feature 5)
**Priority:** P0 - Must Have  
**Effort Estimate:** 3 jours

### Stories
- [ ] **5.1 - Consulter historique complet**
  - Status: Not Started
  - AC Count: 6
  - List all past workouts
  - Est: 1.5 jours

- [ ] **5.2 - Détails d'une séance passée**
  - Status: Not Started
  - AC Count: 5
  - View session details
  - Est: 1 jour

- [ ] **5.3 - Supprimer séance de l'historique**
  - Status: Not Started
  - AC Count: 3
  - Delete with confirmation
  - Est: 0.5 jour

---

## Epic 6: Statistiques et progression (Feature 6)
**Priority:** P1 - Should Have  
**Effort Estimate:** 5 jours

### Stories
- [ ] **6.1 - Graphique progression par exercice**
  - Status: Not Started
  - AC Count: 6
  - Charts with fl_chart
  - Est: 2 jours

- [ ] **6.2 - Personal Records (PRs)**
  - Status: Not Started
  - AC Count: 5
  - Track max weight, reps, volume
  - Est: 1.5 jours

- [ ] **6.3 - Vue d'ensemble statistiques globales**
  - Status: Not Started
  - AC Count: 6
  - Dashboard with key metrics
  - Est: 1.5 jours

---

## Epic 7: Settings et préférences (Feature 7)
**Priority:** P1 - Should Have  
**Effort Estimate:** 2 jours

### Stories
- [ ] **7.1 - Unités de mesure (kg/lb)**
  - Status: Not Started
  - AC Count: 4
  - Toggle kg/lbs
  - Est: 0.5 jour

- [ ] **7.2 - Dark/Light mode**
  - Status: Not Started
  - AC Count: 3
  - Theme switching
  - Est: 0.5 jour

- [ ] **7.3 - Notifications preferences**
  - Status: Not Started
  - AC Count: 4
  - Enable/disable sounds, vibrations
  - Est: 0.5 jour

- [ ] **7.4 - Export/Import données**
  - Status: Not Started
  - AC Count: 5
  - JSON export/import
  - Est: 0.5 jour

---

## Epic 8: Onboarding (Feature 8)
**Priority:** P1 - Should Have  
**Effort Estimate:** 2 jours

### Stories
- [ ] **8.1 - Premier lancement et tutorial**
  - Status: Not Started
  - AC Count: 5
  - Interactive onboarding
  - Est: 1.5 jours

- [ ] **8.2 - Setup initial (unités, préférences)**
  - Status: Not Started
  - AC Count: 4
  - Initial preferences
  - Est: 0.5 jour

---

## Development Sequence Recommendation

### Phase 1: Foundation (Week 1-2)
1. Story 2.1 - Exercise Database (prerequisite for everything)
2. Story 1.1 - Create Workout (core feature)
3. Story 2.2 - Search/Filter Exercises

### Phase 2: Core Workout Flow (Week 3-4)
4. Story 3.1 - Start Workout Session
5. Story 3.2 - Track Sets
6. Story 4.1 - Auto Timer
7. Story 4.2 - Timer Notifications

### Phase 3: History & Polish (Week 5-6)
8. Story 5.1 - View History
9. Story 5.2 - Session Details
10. Story 1.2 - Workout Templates
11. Story 4.3-4.5 - Timer Controls & Background

### Phase 4: Stats & Settings (Week 7-8)
12. Story 6.1 - Progress Charts
13. Story 6.2 - Personal Records
14. Story 7.1-7.3 - Settings
15. Story 1.3-1.5 - Edit/Delete Workouts

### Phase 5: Final Polish (Week 9-10)
16. Story 8.1-8.2 - Onboarding
17. Story 2.3 - Custom Exercises
18. Story 6.3 - Stats Dashboard
19. Story 3.3 - Pause/Resume
20. Remaining stories + bug fixes

---

## Story Creation Status

**Created:** 8 / ~25-30  
**Progress:** 27-32%  
**Next Stories to Create:** 
- 5.1 - Historique complet (HAUTE PRIORITÉ)
- 5.2 - Détails séance passée
- 1.2 - Workout Templates
- 6.2 - Personal Records

---

**Last Updated:** 2026-01-11 by John (PM)

