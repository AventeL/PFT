# 🎨 EXEMPLES D'UTILISATION DU SYSTÈME DE DESIGN

**Guide pratique avec exemples de code réels**

---

## 🎯 EXEMPLES PAR CAS D'USAGE

### 1. Créer un écran avec loading

```dart
import 'package:flutter/material.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../widgets/common/shimmer_widget.dart';

class MyScreen extends StatelessWidget {
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.myTitle), // ✅ Français
      ),
      body: isLoading
          ? const ExerciseListShimmer() // ✅ Shimmer au lieu de spinner
          : _buildContent(),
    );
  }
}
```

### 2. Afficher une liste d'items

```dart
class ItemWidget extends StatelessWidget {
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card( // ✅ Thème déjà appliqué automatiquement
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.primary.withValues(alpha: 0.2), // ✅ Couleur système
          child: Icon(
            Icons.fitness_center,
            color: AppColors.primary, // ✅ Couleur système
          ),
        ),
        title: Text(
          item.name,
          style: AppTextStyles.exerciseName, // ✅ Style uniforme
        ),
        subtitle: Text(
          AppStrings.getMuscleGroupName(item.muscleGroup), // ✅ Traduction dynamique
          style: AppTextStyles.caption, // ✅ Style uniforme
        ),
        trailing: Chip(
          label: Text(item.category),
          backgroundColor: AppColors.getCategoryColor(item.category) // ✅ Couleur automatique
              .withValues(alpha: 0.2),
        ),
      ),
    );
  }
}
```

### 3. Afficher un header de section

```dart
Widget _buildSectionHeader(String title, int count) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        // Barre colorée à gauche
        Container(
          width: 4,
          height: 24,
          decoration: BoxDecoration(
            color: AppColors.primary, // ✅ Couleur système
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),

        // Titre
        Text(
          title,
          style: AppTextStyles.h4, // ✅ Style uniforme
        ),
        const SizedBox(width: 8),

        // Badge de count
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.2), // ✅ Couleur système
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$count',
            style: AppTextStyles.caption.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
```

### 4. Gérer les états (Loading, Error, Empty, Success)

```dart
Widget _buildBody(MyState state) {
  // Loading
  if (state is Loading) {
    return const ExerciseListShimmer(); // ✅ Shimmer
  }

  // Error
  if (state is Error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: AppColors.error, // ✅ Couleur sémantique
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.errorLoadingData, // ✅ Texte français
            style: AppTextStyles.h4, // ✅ Style uniforme
          ),
          const SizedBox(height: 8),
          Text(
            state.message,
            style: AppTextStyles.body2.copyWith(
              color: AppColors.textSecondaryLight, // ✅ Couleur texte
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon( // ✅ Thème déjà appliqué
            onPressed: _retry,
            icon: const Icon(Icons.refresh),
            label: Text(AppStrings.retry), // ✅ Texte français
          ),
        ],
      ),
    );
  }

  // Empty
  if (state is Success && state.items.isEmpty) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: AppColors.textDisabledLight, // ✅ Couleur disabled
          ),
          const SizedBox(height: 16),
          Text(
            AppStrings.emptyList, // ✅ Texte français
            style: AppTextStyles.h4, // ✅ Style uniforme
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.emptyListDescription, // ✅ Texte français
            style: AppTextStyles.body2.copyWith(
              color: AppColors.textSecondaryLight,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Success with data
  return _buildList(state.items);
}
```

### 5. Créer un bouton d'action

```dart
// Primary action button
ElevatedButton
( // ✅ Thème déjà appliqué
onPressed: _onStartWorkout,
child: Text(AppStrings.startWorkout), // ✅ Texte français
)

// Secondary action
TextButton( // ✅ Thème déjà appliqué
onPressed: _onCancel,
child: Text(AppStrings.cancel), // ✅ Texte français
)

// Outlined action
OutlinedButton( // ✅ Thème déjà appliqué
onPressed: _onEdit,
child: Text(AppStrings.edit), // ✅ Texte français
)

// FAB
FloatingActionButton( // ✅ Thème déjà appliqué
onPressed: _onAdd,
child: const Icon(Icons.add),
)
```

### 6. Afficher un dialog

```dart
void _showConfirmDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) =>
        AlertDialog( // ✅ Thème déjà appliqué
          title: Text(AppStrings.confirmDelete), // ✅ Texte français
          content: Text(AppStrings.confirmDeleteMessage), // ✅ Texte français
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppStrings.cancel), // ✅ Texte français
            ),
            ElevatedButton(
              onPressed: _onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error, // ✅ Bouton rouge pour delete
              ),
              child: Text(AppStrings.delete), // ✅ Texte français
            ),
          ],
        ),
  );
}
```

### 7. Créer un formulaire

```dart
class MyForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TextField avec thème automatique
        TextField(
          decoration: InputDecoration(
            labelText: AppStrings.exerciseName, // ✅ Texte français
            hintText: AppStrings.enterExerciseName, // ✅ Texte français
            prefixIcon: Icon(Icons.fitness_center),
          ),
        ),
        const SizedBox(height: 16),

        // Dropdown
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: AppStrings.muscleGroup, // ✅ Texte français
          ),
          items: muscleGroups.map((group) {
            return DropdownMenuItem(
              value: group,
              child: Text(
                AppStrings.getMuscleGroupName(group), // ✅ Traduction
              ),
            );
          }).toList(),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
```

### 8. Afficher des stats avec couleurs

```dart
class StatsCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card( // ✅ Thème déjà appliqué
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: AppColors.primary, // ✅ Couleur système
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: AppTextStyles.statsNumber, // ✅ Style stats spécial
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Utilisation
Row
(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
StatsCard(
label: AppStrings.totalWorkouts, // ✅ Texte français
value: '42',
icon: Icons.fitness_center,
),
StatsCard(
label: AppStrings.totalSets, // ✅ Texte français
value: '324',
icon: Icons.format_list_numbered,
)
,
]
,
)
```

### 9. Timer avec couleurs spéciales

```dart
class TimerDisplay extends StatelessWidget {
  final int secondsRemaining;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    // Couleur selon l'état
    Color timerColor;
    if (!isActive) {
      timerColor = AppColors.timerPaused; // ✅ Orange
    } else if (secondsRemaining > 10) {
      timerColor = AppColors.timerActive; // ✅ Vert
    } else if (secondsRemaining > 5) {
      timerColor = AppColors.timerAlmostDone; // ✅ Jaune
    } else {
      timerColor = AppColors.timerDone; // ✅ Rouge
    }

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: timerColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: timerColor, width: 2),
      ),
      child: Text(
        _formatTime(secondsRemaining),
        style: AppTextStyles.timerDisplay.copyWith( // ✅ Style timer spécial
          color: timerColor,
        ),
      ),
    );
  }
}
```

### 10. Chip personnalisé par type

```dart
Widget _buildMuscleChip(String muscleGroup) {
  final color = AppColors.getMuscleGroupColor(muscleGroup); // ✅ Couleur auto
  final name = AppStrings.getMuscleGroupName(muscleGroup); // ✅ Traduction auto

  return Chip(
    label: Text(name, style: AppTextStyles.caption),
    backgroundColor: color.withValues(alpha: 0.2),
    avatar: CircleAvatar(
      backgroundColor: color,
      child: Icon(Icons.fitness_center, size: 16, color: Colors.white),
    ),
  );
}

Widget _buildEquipmentIcon(String equipment) {
  final color = AppColors.getEquipmentColor(equipment); // ✅ Couleur auto

  IconData icon;
  switch (equipment) {
    case 'barbell':
      icon = Icons.fitness_center;
      break;
    case 'dumbbell':
      icon = Icons.fitness_center;
      break;
    case 'machine':
      icon = Icons.settings;
      break;
    case 'bodyweight':
      icon = Icons.accessibility_new;
      break;
    default:
      icon = Icons.help;
  }

  return CircleAvatar(
    backgroundColor: color.withValues(alpha: 0.2),
    child: Icon(icon, color: color, size: 20),
  );
}
```

---

## 🎯 ANTI-PATTERNS À ÉVITER

### ❌ MAUVAIS EXEMPLES

```dart
// ❌ Couleur hardcodée
color: Colors.blue

// ❌ Couleur avec hex
color: Color
(0xFF1234AB)

// ❌ Texte hardcodé
Text('Loading...')

// ❌ Texte en anglais
Text('Exercises')

// ❌ Taille de texte hardcodée
TextStyle(fontSize: 24)

// ❌ Loading basique
if (isLoading) return CircularProgressIndicator();

// ❌ Couleur directe du thème
Theme.of(context
)
.
primaryColor
```

### ✅ BONS EXEMPLES

```dart
// ✅ Couleur système
color: AppColors.primary

// ✅ Couleur avec helper
color: AppColors.getMuscleGroupColor
('chest
'
)

// ✅ Texte français
Text(AppStrings.loading)

// ✅ Texte traduit
Text(AppStrings.exercises)

// ✅ Style système
style: AppTextStyles.h3

// ✅ Loading professionnel
if (isLoading) return const ExerciseListShimmer();

// ✅ Couleur via ColorScheme si nécessaire
Theme.of(context
)
.
colorScheme
.
surface
```

---

## 📋 CHECKLIST AVANT DE COMMIT

Avant de commit du code, vérifier :

- [ ] Aucun `Colors.xxx` (sauf `Colors.white` et `Colors.black`)
- [ ] Aucun `Color(0xFFxxxxxx)`
- [ ] Aucun string hardcodé visible par l'utilisateur
- [ ] Aucun `fontSize: xx` direct (utiliser `AppTextStyles`)
- [ ] Aucun `CircularProgressIndicator` (utiliser shimmer)
- [ ] Tous les textes en français
- [ ] Imports corrects (`app_colors.dart`, `app_strings.dart`, etc.)

---

## 🚀 RÉSUMÉ RAPIDE

### Pour chaque widget, demandez-vous :

1. **Couleur ?** → `AppColors.*`
2. **Texte ?** → `AppStrings.*`
3. **Style de texte ?** → `AppTextStyles.*`
4. **Loading ?** → `*Shimmer()` widget
5. **Thème ?** → Déjà appliqué automatiquement

### Fichiers à importer

```dart
// Dans 95% des cas
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

// Si loading states
import '../../widgets/common/shimmer_widget.dart';
```

---

*Exemples d'utilisation - John (PM) 📋*  
*Date: 2026-01-11*

