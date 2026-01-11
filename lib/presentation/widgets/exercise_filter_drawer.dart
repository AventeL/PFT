import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/app_text_styles.dart';
import '../../l10n/app_localizations.dart';
import '../blocs/exercise/exercise_bloc.dart';
import '../blocs/exercise/exercise_event.dart';
import '../blocs/exercise/exercise_state.dart';
import 'exercise_filter_chips.dart';

/// Extension pour accéder facilement aux traductions via context
extension _LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Drawer contenant les filtres d'exercices
class ExerciseFilterDrawer extends StatelessWidget {
  const ExerciseFilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          if (state is! ExercisesLoaded) {
            return const SizedBox.shrink();
          }

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drawer Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.filter_list, size: 28),
                      const SizedBox(width: 12),
                      Text(
                        context.l10n.filter,
                        style: AppTextStyles.h3,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                const Divider(),

                // Filters
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ExerciseFilterChips(
                      selectedMuscleGroups: state.selectedMuscleGroups,
                      selectedCategories: state.selectedCategories,
                      selectedEquipmentTypes: state.selectedEquipmentTypes,
                      onMuscleGroupsChanged: (groups) {
                        context
                            .read<ExerciseBloc>()
                            .add(FilterByMuscleGroupsEvent(groups));
                      },
                      onCategoriesChanged: (categories) {
                        context
                            .read<ExerciseBloc>()
                            .add(FilterByCategoriesEvent(categories));
                      },
                      onEquipmentTypesChanged: (types) {
                        context
                            .read<ExerciseBloc>()
                            .add(FilterByEquipmentTypesEvent(types));
                      },
                      onClearFilters: () {
                        context
                            .read<ExerciseBloc>()
                            .add(const ClearFiltersEvent());
                      },
                      hasActiveFilters: state.selectedMuscleGroups.isNotEmpty ||
                          state.selectedCategories.isNotEmpty ||
                          state.selectedEquipmentTypes.isNotEmpty,
                    ),
                  ),
                ),

                // Bottom buttons
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (state.selectedMuscleGroups.isNotEmpty ||
                          state.selectedCategories.isNotEmpty ||
                          state.selectedEquipmentTypes.isNotEmpty)
                        OutlinedButton.icon(
                          onPressed: () {
                            context
                                .read<ExerciseBloc>()
                                .add(const ClearFiltersEvent());
                          },
                          icon: const Icon(Icons.clear_all),
                          label: Text(context.l10n.clear),
                        ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(context.l10n.apply),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
