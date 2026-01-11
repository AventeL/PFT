import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../domain/entities/exercise_enums.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/exercise/exercise_bloc.dart';
import '../../blocs/exercise/exercise_event.dart';
import '../../blocs/exercise/exercise_state.dart';
import '../../widgets/common/shimmer_widget.dart';
import '../../widgets/exercise_filter_drawer.dart';
import '../../widgets/exercise_list_item.dart';

/// Extension pour accéder facilement aux traductions via context
extension _LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Screen to display list of exercises grouped by muscle group
class ExerciseListScreen extends StatefulWidget {
  const ExerciseListScreen({super.key});

  @override
  State<ExerciseListScreen> createState() => _ExerciseListScreenState();
}

class _ExerciseListScreenState extends State<ExerciseListScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // Load exercises on screen init
    context.read<ExerciseBloc>().add(const LoadExercises());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<ExerciseBloc>().add(SearchExercisesEvent(query));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.exercises),
        elevation: 2,
        actions: [
          // Filter button with badge
          BlocBuilder<ExerciseBloc, ExerciseState>(
            builder: (context, state) {
              final hasFilters = state is ExercisesLoaded &&
                  (state.selectedMuscleGroups.isNotEmpty ||
                      state.selectedCategories.isNotEmpty ||
                      state.selectedEquipmentTypes.isNotEmpty);

              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                  if (hasFilters)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          _getActiveFiltersCount(state).toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      endDrawer: const ExerciseFilterDrawer(),
      body: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          // Loading state - Show shimmer effect
          if (state is ExerciseLoading) {
            return const ExerciseListShimmer();
          }

          // Error state
          if (state is ExerciseError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline,
                      size: 64, color: AppColors.error),
                  const SizedBox(height: 16),
                  Text(context.l10n.errorLoadingData, style: AppTextStyles.h4),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: AppTextStyles.body2.copyWith(
                      color: AppColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<ExerciseBloc>().add(const LoadExercises());
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(context.l10n.cancel),
                  ),
                ],
              ),
            );
          }

          // Loaded state
          if (state is ExercisesLoaded) {
            return Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: context.l10n.searchExercises,
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                context
                                    .read<ExerciseBloc>()
                                    .add(const SearchExercisesEvent(''));
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                // Results count
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        '${state.resultCount} ${context.l10n.exerciseCount}',
                        style: AppTextStyles.body2.copyWith(
                          color: AppColors.textSecondaryLight,
                        ),
                      ),
                      if (state.hasActiveFilters) ...[
                        const SizedBox(width: 8),
                        Text(
                          '(${state.allExercises.length} total)',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textDisabledLight,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // Exercise List
                Expanded(
                  child: _buildExerciseList(state),
                ),
              ],
            );
          }

          // Initial state
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.fitness_center,
                    size: 64, color: AppColors.primary),
                const SizedBox(height: 16),
                Text(context.l10n.loading, style: AppTextStyles.h4),
              ],
            ),
          );
        },
      ),
    );
  }

  int _getActiveFiltersCount(ExerciseState state) {
    if (state is! ExercisesLoaded) return 0;
    return state.selectedMuscleGroups.length +
        state.selectedCategories.length +
        state.selectedEquipmentTypes.length;
  }

  Widget _buildExerciseList(ExercisesLoaded state) {
    final exercises = state.filteredExercises;

    // Empty state
    if (exercises.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.textDisabledLight,
            ),
            const SizedBox(height: 16),
            Text(context.l10n.noExercisesFound, style: AppTextStyles.h4),
            const SizedBox(height: 8),
            if (state.hasActiveFilters)
              Text(
                'Essayez d\'ajuster vos filtres',
                style: AppTextStyles.body2.copyWith(
                  color: AppColors.textSecondaryLight,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      );
    }

    // Group exercises by muscle group
    final groupedExercises = <MuscleGroup, List>{};
    for (final exercise in exercises) {
      if (!groupedExercises.containsKey(exercise.muscleGroup)) {
        groupedExercises[exercise.muscleGroup] = [];
      }
      groupedExercises[exercise.muscleGroup]!.add(exercise);
    }

    return ListView.builder(
      itemCount: groupedExercises.length,
      itemBuilder: (context, index) {
        final muscleGroup = groupedExercises.keys.elementAt(index);
        final groupExercises = groupedExercises[muscleGroup]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Muscle group header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.getMuscleGroupColor(
                        muscleGroup.name,
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _getMuscleGroupName(context, muscleGroup.name),
                    style: AppTextStyles.h4,
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.getMuscleGroupColor(
                        muscleGroup.name,
                      ).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${groupExercises.length}',
                      style: AppTextStyles.caption.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Exercises in this group
            ...groupExercises.map(
              (exercise) => ExerciseListItem(
                exercise: exercise,
                onTap: () {
                  // TODO: Navigate to exercise details or select
                },
              ),
            ),
            const SizedBox(height: 8),
          ],
        );
      },
    );
  }

  String _getMuscleGroupName(BuildContext context, String muscleGroup) {
    final l10n = context.l10n;
    return switch (muscleGroup.toLowerCase()) {
      'chest' => l10n.muscleGroupChest,
      'back' => l10n.muscleGroupBack,
      'shoulders' => l10n.muscleGroupShoulders,
      'legs' => l10n.muscleGroupLegs,
      'arms' => l10n.muscleGroupArms,
      'core' => l10n.muscleGroupCore,
      'cardio' => l10n.muscleGroupCardio,
      'fullbody' || 'full body' => l10n.muscleGroupFullBody,
      _ => l10n.muscleGroupOther,
    };
  }
}
