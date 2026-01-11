# 📅 SPRINT PLANNING - PFT MVP

**Date:** 2026-01-11  
**PM:** John 📋  
**Scrum Master:** [Nom]  
**Dev Team:** [Noms]  
**Sprint Duration:** 2 semaines (10 jours ouvrés)

---

## 🎯 OBJECTIF DU DOCUMENT

Ce document contient le **Product Backlog priorisé** et les **propositions de Sprint Planning** pour l'implémentation du MVP PFT sur 6.5 semaines (3-4 sprints de 2 semaines).

---

## 📊 PRODUCT BACKLOG PRIORISÉ (29 STORIES)

### Vue d'Ensemble

**Total Stories:** 29  
**Effort Total:** ~32 jours  
**Sprints Recommandés:** 4 sprints de 2 semaines  
**Velocity Estimée:** 8-10 jours par sprint

---

## 🏆 PRIORISATION DES STORIES

### Priorité P0 - CRITIQUE (Must Have) - 16 stories

**Epic 2: Exercises (Foundation)**
- **Story 2.1** - Exercise Database (1.5j) 🔥 **Sprint 1**
  - _Raison:_ Foundation absolue, bloque tout le reste
  - _Dépendances:_ Aucune
  - _Acceptance Criteria:_ 50+ exercises, load < 100ms

- **Story 2.2** - Search/Filter Exercises (1j) 🔥 **Sprint 1**
  - _Raison:_ UX critique pour trouver exercises
  - _Dépendances:_ 2.1
  - _Acceptance Criteria:_ Search < 50ms, multi-filtres

**Epic 1: Workouts**
- **Story 1.1** - Créer Workout (2.5j) 🔥 **Sprint 2**
  - _Raison:_ Core feature, bloque Epic 3
  - _Dépendances:_ 2.1
  - _Acceptance Criteria:_ CRUD complet, drag & drop

- **Story 1.2** - Templates (1j) **Sprint 2**
  - _Raison:_ Onboarding facilité
  - _Dépendances:_ 1.1
  - _Acceptance Criteria:_ 6 templates pré-configurés

- **Story 1.3** - Edit/Delete Workouts (1j) **Sprint 2**
  - _Raison:_ CRUD complet, évite frustration user
  - _Dépendances:_ 1.1
  - _Acceptance Criteria:_ Edit + delete avec warning

**Epic 3: Active Workout (Core Flow)**
- **Story 3.1** - Start Workout (2j) 🔥 **Sprint 2**
  - _Raison:_ Entry point du core flow
  - _Dépendances:_ 1.1, 2.1
  - _Acceptance Criteria:_ Quick Start, WakeLock, auto-save

- **Story 3.2** - Track Sets (2j) 🔥🔥 **Sprint 2**
  - _Raison:_ **KPI CRITIQUE: < 10s per set**
  - _Dépendances:_ 3.1
  - _Acceptance Criteria:_ Entry < 10s, smart defaults

- **Story 3.3** - Finish Workout (1.5j) 🔥 **Sprint 2**
  - _Raison:_ Complète le core flow
  - _Dépendances:_ 3.2
  - _Acceptance Criteria:_ Complete/Incomplete, summary

**Epic 4: Timer (Killer Feature)**
- **Story 4.1** - Auto Timer (1.5j) 🔥 **Sprint 3**
  - _Raison:_ Différenciation produit
  - _Dépendances:_ 3.2
  - _Acceptance Criteria:_ Auto-start, compound 3min / isolation 90s

- **Story 4.2** - Timer Notifications (1j) 🔥 **Sprint 3**
  - _Raison:_ UX critique du timer
  - _Dépendances:_ 4.1
  - _Acceptance Criteria:_ 10s warning, completion alert

- **Story 4.3** - Timer Controls (0.5j) **Sprint 3**
  - _Raison:_ Flexibilité timer
  - _Dépendances:_ 4.1
  - _Acceptance Criteria:_ Pause, skip, +/-30s

- **Story 4.4** - Custom Rest Time (0.5j) **Sprint 3**
  - _Raison:_ Personnalisation
  - _Dépendances:_ 4.1
  - _Acceptance Criteria:_ Quick select + custom picker

**Epic 5: History**
- **Story 5.1** - Workout History (2j) **Sprint 3**
  - _Raison:_ Rétention user
  - _Dépendances:_ 3.3
  - _Acceptance Criteria:_ Liste chronologique, filtres

- **Story 5.2** - Session Details (1.5j) **Sprint 3**
  - _Raison:_ Comparaison progression
  - _Dépendances:_ 5.1
  - _Acceptance Criteria:_ Details complets, repeat option

**Epic 6: Stats**
- **Story 6.2** - Personal Records (2j) 🏆 **Sprint 4**
  - _Raison:_ Gamification, motivation
  - _Dépendances:_ 3.2
  - _Acceptance Criteria:_ Auto-detection, celebration

**Epic 0: UX Polish**
- **Story 0** - UX Polish (Intégré) **Tous les sprints**
  - _Raison:_ Qualité UX dès le début
  - _Dépendances:_ Aucune
  - _Acceptance Criteria:_ Shimmer, animations 60fps

---

### Priorité P1 - HIGH (Should Have) - 8 stories

**Epic 2:**
- **Story 2.3** - Custom Exercises (0.5j) **Sprint 2**

**Epic 4:**
- **Story 4.5** - Timer Background (1j) **Sprint 3**

**Epic 5:**
- **Story 5.3** - Progress Charts (2j) **Sprint 4**

**Epic 6:**
- **Story 6.1** - Stats Dashboard (1.5j) **Sprint 4**
- **Story 6.3** - Exercise History (1j) **Sprint 4**

**Epic 1:**
- **Story 1.4** - Duplicate Workout (0.5j) **Sprint 4**
- **Story 1.5** - Workout Notes (0.5j) **Sprint 4**

---

### Priorité P2 - MEDIUM (Nice to Have) - 5 stories

**Epic 7: Settings**
- **Story 7.1** - Settings Units (0.5j) **Sprint 4**
- **Story 7.2** - Settings Theme (0.5j) **Sprint 4**
- **Story 7.3** - Settings Notifications (0.5j) **Sprint 4**
- **Story 7.4** - Settings Export (0.5j) **Sprint 4**

**Epic 8: Onboarding**
- **Story 8.1** - Onboarding Tutorial (1j) **Sprint 4**
- **Story 8.2** - First Workout Guide (0.5j) **Sprint 4**

---

## 📅 SPRINT PLANNING PROPOSÉ

### 🎯 SPRINT 1 - FOUNDATION (Jours 1-10)

**Sprint Goal:** "Établir les fondations techniques et la base d'exercices"

**Duration:** 2 semaines (10 jours ouvrés)  
**Capacity:** 8-10 jours  
**Stories:** 2 stories

#### Stories Incluses

| Story | Effort | Priorité | Status |
|-------|--------|----------|--------|
| **2.1** - Exercise Database | 1.5j | P0 🔥 | Selected |
| **2.2** - Search/Filter | 1j | P0 🔥 | Selected |

**Total Effort:** 2.5 jours

**Remarque:** Sprint volontairement léger pour inclure:
- Setup projet Flutter (1j)
- Architecture Clean + BLoC (1j)
- Database setup (1j)
- CI/CD setup (0.5j)
- Documentation ARCHITECTURE.md (0.5j)
- Tests >80% (1.5j)

**Total Réel:** ~8 jours

#### Sprint Backlog

**Setup (Jours 1-3):**
- [ ] Créer projet Flutter
- [ ] pubspec.yaml avec 17 packages
- [ ] Folder structure Clean Architecture
- [ ] Setup GetIt DI
- [ ] Database helper + 7 tables
- [ ] ARCHITECTURE.md documenté
- [ ] CI/CD GitHub Actions

**Story 2.1 (Jours 4-5):**
- [ ] Exercise entity + enums
- [ ] ExerciseModel + serialization
- [ ] ExerciseRepository + datasource
- [ ] Seed service (50+ exercises)
- [ ] ExerciseBloc
- [ ] Exercise list UI
- [ ] Tests >80%

**Story 2.2 (Jours 6-7):**
- [ ] Search functionality
- [ ] Filter by muscle group
- [ ] Filter by category/equipment
- [ ] Debouncing 500ms
- [ ] Tests >80%

**Testing & Polish (Jours 8-10):**
- [ ] Integration tests
- [ ] Performance profiling
- [ ] Bug fixes
- [ ] Sprint review prep

#### Definition of Done (DoD)

- [ ] Code merged to main
- [ ] Tests >80% coverage
- [ ] No critical bugs
- [ ] Performance KPIs met (load < 100ms, search < 50ms)
- [ ] Code review approved
- [ ] Documentation updated

#### Risques Sprint 1

| Risque | Probabilité | Mitigation |
|--------|-------------|-----------|
| Setup plus long que prévu | Moyenne | Buffer de 2 jours inclus |
| Problèmes sqflite iOS | Basse | Tests sur device dès J1 |
| Seed data incomplet | Basse | 50 exercises minimum |

---

### 🎯 SPRINT 2 - CORE FLOW (Jours 11-20)

**Sprint Goal:** "Permettre à l'utilisateur de créer et compléter un workout"

**Duration:** 2 semaines (10 jours ouvrés)  
**Capacity:** 10 jours  
**Stories:** 6 stories

#### Stories Incluses

| Story | Effort | Priorité | Status |
|-------|--------|----------|--------|
| **1.1** - Créer Workout | 2.5j | P0 🔥 | Selected |
| **1.2** - Templates | 1j | P0 🔥 | Selected |
| **1.3** - Edit/Delete | 1j | P0 🔥 | Selected |
| **2.3** - Custom Exercises | 0.5j | P1 | Selected |
| **3.1** - Start Workout | 2j | P0 🔥 | Selected |
| **3.2** - Track Sets | 2j | P0 🔥🔥 | Selected |
| **3.3** - Finish Workout | 1.5j | P0 🔥 | Selected |

**Total Effort:** 10.5 jours

**Ajustement:** Légèrement sur-estimé, mais inclut intégration et tests approfondis

#### Sprint Backlog

**Epic 1 (Jours 11-14):**
- [ ] Story 1.1: Workout CRUD complet
- [ ] Story 1.2: 6 templates
- [ ] Story 1.3: Edit/Delete avec warnings
- [ ] Story 2.3: Custom exercises

**Epic 3 (Jours 15-20):**
- [ ] Story 3.1: Start workout session
- [ ] Story 3.2: Track sets **< 10s KPI** 🔥
- [ ] Story 3.3: Finish/abandon workout

**Integration (Jours 19-20):**
- [ ] Flow end-to-end: Create → Start → Track → Finish
- [ ] Tests intégration
- [ ] Performance profiling (set entry < 10s)

#### KPIs Sprint 2

| KPI | Target | Validation |
|-----|--------|-----------|
| Set entry time | < 10s | Profile avec stopwatch |
| Workout creation | < 2 min | User testing |
| App responsiveness | 60 FPS | DevTools profiler |

#### Risques Sprint 2

| Risque | Probabilité | Mitigation |
|--------|-------------|-----------|
| Set entry > 10s | Moyenne | Smart defaults dès J15 |
| WakeLock problèmes | Basse | Tests device early |
| Scope trop large | Moyenne | Story 2.3 peut glisser au Sprint 3 |

---

### 🎯 SPRINT 3 - KILLER FEATURE (Jours 21-30)

**Sprint Goal:** "Implémenter le timer le plus flexible du marché"

**Duration:** 2 semaines (10 jours ouvrés)  
**Capacity:** 10 jours  
**Stories:** 7 stories

#### Stories Incluses

| Story | Effort | Priorité | Status |
|-------|--------|----------|--------|
| **4.1** - Auto Timer | 1.5j | P0 🔥 | Selected |
| **4.2** - Notifications | 1j | P0 🔥 | Selected |
| **4.3** - Controls | 0.5j | P0 | Selected |
| **4.4** - Custom Rest Time | 0.5j | P0 | Selected |
| **4.5** - Background | 1j | P1 | Selected |
| **5.1** - History | 2j | P0 | Selected |
| **5.2** - Session Details | 1.5j | P0 | Selected |

**Total Effort:** 8 jours

**Buffer:** 2 jours pour tests iOS/Android approfondis

#### Sprint Backlog

**Epic 4 - Timer (Jours 21-25):**
- [ ] Story 4.1: Auto-start après set
- [ ] Story 4.2: Notifications 10s + complete
- [ ] Story 4.3: Pause, skip, +/-30s
- [ ] Story 4.4: Custom rest time picker
- [ ] Story 4.5: Background execution

**Epic 5 - History (Jours 26-30):**
- [ ] Story 5.1: History list + filtres
- [ ] Story 5.2: Session details + repeat

**Tests Critiques (Jours 28-30):**
- [ ] Timer iOS background (scheduled notifs)
- [ ] Timer Android background
- [ ] Interruptions (appels, etc.)

#### KPIs Sprint 3

| KPI | Target | Validation |
|-----|--------|-----------|
| Timer precision | ±1s | Stopwatch validation |
| Background survival | 10+ min | Real device testing |
| Notification latency | < 1s | User perception |

#### Risques Sprint 3

| Risque | Probabilité | Mitigation |
|--------|-------------|-----------|
| iOS timer background | Haute | Scheduled notifications (défini) |
| Notification permissions | Moyenne | Onboarding explicite |
| Audio player issues | Basse | Fallback sans son |

---

### 🎯 SPRINT 4 - POLISH & LAUNCH (Jours 31-40+)

**Sprint Goal:** "Finaliser le MVP avec stats, settings et onboarding"

**Duration:** 2 semaines + buffer (12 jours)  
**Capacity:** 12 jours  
**Stories:** 10 stories

#### Stories Incluses

| Story | Effort | Priorité | Status |
|-------|--------|----------|--------|
| **6.2** - Personal Records | 2j | P0 🏆 | Selected |
| **5.3** - Progress Charts | 2j | P1 | Selected |
| **6.1** - Stats Dashboard | 1.5j | P1 | Selected |
| **6.3** - Exercise History | 1j | P1 | Selected |
| **1.4** - Duplicate Workout | 0.5j | P1 | Selected |
| **1.5** - Workout Notes | 0.5j | P1 | Selected |
| **7.1-7.4** - Settings (4 stories) | 2j | P2 | Selected |
| **8.1** - Onboarding | 1j | P2 | Selected |
| **8.2** - First Workout Guide | 0.5j | P2 | Selected |

**Total Effort:** 11 jours

**Buffer:** 1 jour pour polish final

#### Sprint Backlog

**Epic 6 - Stats (Jours 31-35):**
- [ ] Story 6.2: PRs auto-detection + celebration
- [ ] Story 5.3: Charts (max weight, volume, 1RM)
- [ ] Story 6.1: Stats dashboard
- [ ] Story 6.3: Exercise history

**Epic 1 - Polish (Jours 36-37):**
- [ ] Story 1.4: Duplicate workout
- [ ] Story 1.5: Workout notes

**Epic 7 - Settings (Jours 38-39):**
- [ ] Stories 7.1-7.4: Units, theme, notifs, export

**Epic 8 - Onboarding (Jours 40-41):**
- [ ] Story 8.1: Tutorial interactif
- [ ] Story 8.2: First workout guide

**Final Polish (Jour 42):**
- [ ] Bug fixes
- [ ] Performance optimization
- [ ] Alpha package

#### Definition of Done (DoD) MVP

- [ ] Toutes 29 stories complétées
- [ ] Tests >80% coverage global
- [ ] Performance KPIs validés
- [ ] No critical/high bugs
- [ ] TestFlight/Play Internal uploaded
- [ ] Documentation utilisateur

---

## 📊 SPRINT VELOCITY & CAPACITY

### Estimation Équipe

**Hypothèse:** 1 dev full-time

**Capacity par sprint:**
- Jours ouvrés: 10 jours
- Meetings (daily, review, retro, planning): -1 jour
- Imprévus/support: -1 jour
- **Capacity nette:** 8 jours par sprint

**Velocity observée (à ajuster):**
- Sprint 1: TBD (baseline)
- Sprint 2: TBD
- Sprint 3: TBD
- Sprint 4: TBD

### Ajustements Possibles

**Si velocity < estimée:**
- Déplacer stories P2 (Epic 7, 8) hors MVP
- Focus sur P0/P1 uniquement
- Ajouter Sprint 5 (2 semaines)

**Si velocity > estimée:**
- Ajouter stories P2 plus tôt
- Inclure polish supplémentaire
- Terminer en 3.5 sprints

---

## 🎯 DEPENDENCIES ENTRE STORIES

### Graph de Dépendances

```
Sprint 1:
2.1 (Exercise DB) ───────┐
                         │
Sprint 2:                ▼
                    1.1 (Create Workout) ───┐
2.2 (Search) ───────────────────────────────┤
2.3 (Custom Ex) ────────────────────────────┤
                                            │
1.2 (Templates) ◄───────────────────────────┤
1.3 (Edit/Delete) ◄─────────────────────────┤
                                            │
                                            ▼
                    3.1 (Start Session) ────┐
                                            │
                                            ▼
                    3.2 (Track Sets) ───────┐
                                            │
                                            ▼
                    3.3 (Finish) ───────────┐
                                            │
Sprint 3:                                   │
                    4.1 (Timer) ◄───────────┤
                                            │
4.2 (Notifs) ◄──────────────────────────────┤
4.3 (Controls) ◄────────────────────────────┤
4.4 (Custom Time) ◄─────────────────────────┤
4.5 (Background) ◄──────────────────────────┤
                                            │
                    5.1 (History) ◄─────────┤
                    5.2 (Details) ◄─────────┘

Sprint 4:
6.2 (PRs) ◄─────────── 3.2
5.3 (Charts) ◄───────── 5.1
6.1 (Stats) ◄────────── 3.3
6.3 (Exercise History) ◄─ 5.1
7.x (Settings) - Indépendants
8.x (Onboarding) - Indépendants
```

### Stories Bloquantes Critiques

1. **2.1 - Exercise DB** → Bloque TOUT (base de données)
2. **1.1 - Create Workout** → Bloque Epic 3
3. **3.2 - Track Sets** → Bloque Epic 4, 6
4. **3.3 - Finish** → Bloque Epic 5

**Si une story bloquante est retardée, tout le sprint suivant est impacté !**

---

## 📋 SPRINT CEREMONIES

### Daily Standup (15 min)

**Timing:** Chaque jour, 9h00  
**Format:**
- Ce que j'ai fait hier
- Ce que je fais aujourd'hui
- Blocages/impediments

### Sprint Planning (2h)

**Timing:** Jour 1 de chaque sprint  
**Agenda:**
1. Review Product Backlog (15 min)
2. Sélection stories (30 min)
3. Breakdown tasks (45 min)
4. Estimation capacity (15 min)
5. Commitment (15 min)

### Sprint Review (1h)

**Timing:** Dernier jour du sprint  
**Agenda:**
1. Demo stories complétées (30 min)
2. Feedback stakeholders (15 min)
3. Product Backlog refinement (15 min)

### Sprint Retrospective (1h)

**Timing:** Dernier jour du sprint (après review)  
**Agenda:**
1. What went well (15 min)
2. What didn't go well (15 min)
3. Action items (30 min)

---

## 🚨 RISQUES & MITIGATION

### Risques Globaux

| Risque | Impact | Probabilité | Mitigation |
|--------|--------|-------------|-----------|
| Velocity surestimée | Haute | Moyenne | Buffer 2j par sprint |
| Maladie/absence dev | Haute | Basse | Stories P2 flexibles |
| Scope creep | Haute | Moyenne | Freeze scope après S1 |
| Bugs critiques | Moyenne | Moyenne | Tests >80% dès S1 |
| iOS timer impossible | Haute | Basse | Scheduled notifs ready |

### Plan de Contingence

**Si retard > 1 sprint:**
1. Drop stories P2 (Epic 7, 8)
2. Focus MVP minimal (P0 uniquement)
3. Ajouter Sprint 5

**Si avance > 1 sprint:**
1. Polish supplémentaire
2. Tests exhaustifs
3. Beta testing early

---

## ✅ CHECKLIST SPRINT PLANNING MEETING

### Avant le Meeting

- [x] Product Backlog priorisé
- [x] Stories estimées
- [x] Dépendances identifiées
- [x] Velocity baseline définie
- [ ] Équipe disponible confirmée

### Pendant le Meeting

- [ ] Review Sprint Goal
- [ ] Sélection stories (capacity-based)
- [ ] Breakdown en tasks
- [ ] Identification blocages
- [ ] Commitment équipe

### Après le Meeting

- [ ] Sprint Backlog créé (Jira/Trello/etc.)
- [ ] Tasks assignées
- [ ] DoD validé
- [ ] Calendrier ceremonies

---

## 📊 OUTILS & TRACKING

### Recommandations Outils

**Project Management:**
- Jira / Linear / Monday.com
- Alternative: GitHub Projects

**Communication:**
- Slack / Discord
- Daily standup async possible

**Documentation:**
- Confluence / Notion
- Alternative: GitHub Wiki

**CI/CD:**
- GitHub Actions
- Codecov pour coverage

### Métriques à Tracker

**Par Sprint:**
- Velocity (jours complétés)
- Burndown chart
- Test coverage %
- Bugs opened/closed
- Performance KPIs

**Global MVP:**
- % stories complétées
- Time to market
- Technical debt
- User satisfaction (alpha)

---

## 🎊 RÉSUMÉ POUR LE SM

### Timeline Globale

**Total:** 4 sprints (8 semaines) + buffer  
**Livraison MVP:** ~42 jours ouvrés  
**Date cible:** Mi-mars 2026

### Sprints Breakdown

| Sprint | Goal | Stories | Effort | Risk |
|--------|------|---------|--------|------|
| **Sprint 1** | Foundation | 2 | 8j | Basse |
| **Sprint 2** | Core Flow | 7 | 10j | Moyenne |
| **Sprint 3** | Killer Feature | 7 | 8j | Haute (iOS) |
| **Sprint 4** | Polish | 10 | 11j | Basse |

### Décision Recommandée

✅ **APPROUVER LE PLAN**

**Justification:**
- Stories bien définies (29)
- Effort estimé réaliste (32j)
- Priorisation claire (P0/P1/P2)
- Risques identifiés et mitigés
- Flexibility built-in (Epic 7, 8)

**Next Steps:**
1. ✅ Valider avec dev team
2. ✅ Setup outils (Jira, GitHub, etc.)
3. ✅ Sprint 1 Planning Meeting
4. ✅ GO !

---

*Document de Sprint Planning généré par John (PM) - 2026-01-11*  
*Pour validation avec Scrum Master*  
*29 stories • 4 sprints • 8 semaines • MVP complet*  
*Powered by BMad™ Core*

