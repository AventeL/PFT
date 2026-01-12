import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/exercise/exercise_bloc.dart';
import '../../blocs/workout/workout_bloc.dart';
import '../exercise_list/exercise_list_screen.dart';
import '../workout_list/workout_list_screen.dart';

/// Extension pour accéder facilement aux traductions via context
extension _LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Home screen with navigation to main features
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.appFullName),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            // Welcome message
            Text(
              'Bienvenue dans PFT',
              style: AppTextStyles.h2,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              'Votre assistant d\'entraînement personnel',
              style: AppTextStyles.body1.copyWith(
                color: AppColors.textSecondaryLight,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 48),

            // Workouts card
            _buildFeatureCard(
              context,
              icon: Icons.fitness_center,
              title: context.l10n.myWorkouts,
              description: 'Créez et gérez vos entraînements',
              color: AppColors.primary,
              onTap: () {
                // Capture blocs before navigation
                final workoutBloc = context.read<WorkoutBloc>();
                final exerciseBloc = context.read<ExerciseBloc>();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => MultiBlocProvider(
                      providers: [
                        BlocProvider.value(value: workoutBloc),
                        BlocProvider.value(value: exerciseBloc),
                      ],
                      child: const WorkoutListScreen(),
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 16),

            // Exercises card
            _buildFeatureCard(
              context,
              icon: Icons.list,
              title: context.l10n.exercises,
              description: 'Explorez la bibliothèque d\'exercices',
              color: AppColors.secondary,
              onTap: () {
                // Capture bloc before navigation
                final exerciseBloc = context.read<ExerciseBloc>();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: exerciseBloc,
                      child: const ExerciseListScreen(),
                    ),
                  ),
                );
              },
            ),

            const Spacer(),

            // Version info
            Text(
              'Version 1.0.0',
              style: AppTextStyles.caption.copyWith(
                color: AppColors.textDisabledLight,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.h4,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: AppTextStyles.body2.copyWith(
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 20,
                color: AppColors.textSecondaryLight,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
