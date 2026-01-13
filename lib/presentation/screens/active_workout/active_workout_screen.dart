import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../l10n/app_localizations.dart';
import '../../blocs/active_workout/active_workout_bloc.dart';
import '../../blocs/active_workout/active_workout_event.dart';
import '../../blocs/active_workout/active_workout_state.dart';

/// Extension pour accéder facilement aux traductions via context
extension _LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Screen for active workout session
class ActiveWorkoutScreen extends StatefulWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _enableWakeLock();
    _initializeElapsed();
    _startTimer();
  }

  void _initializeElapsed() {
    final state = context.read<ActiveWorkoutBloc>().state;
    if (state is ActiveWorkoutActive) {
      _elapsed = DateTime.now().difference(state.session.startTime);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _disableWakeLock();
    super.dispose();
  }

  void _enableWakeLock() async {
    await WakelockPlus.enable();
  }

  void _disableWakeLock() async {
    await WakelockPlus.disable();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        final state = context.read<ActiveWorkoutBloc>().state;
        if (state is ActiveWorkoutActive) {
          setState(() {
            _elapsed = DateTime.now().difference(state.session.startTime);
          });
        }
      }
    });
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActiveWorkoutBloc, ActiveWorkoutState>(
      listener: (context, state) {
        if (state is ActiveWorkoutCompleted) {
          // Navigate back on completion
          Navigator.of(context).pop();
        } else if (state is ActiveWorkoutInitial) {
          // Navigate back if session abandoned
          Navigator.of(context).pop();
        } else if (state is ActiveWorkoutError) {
          // Show error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ActiveWorkoutLoading || state is ActiveWorkoutInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ActiveWorkoutActive) {
          final session = state.session;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                session.workoutId != null
                    ? context.l10n.activeWorkout
                    : context.l10n.quickStart,
              ),
              actions: [
                // Elapsed time
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      _formatDuration(_elapsed),
                      style: AppTextStyles.h4.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                // Close button
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => _showAbandonDialog(context),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Placeholder for exercise tracking (Story 3.2)
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fitness_center,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Suivi des exercices',
                            style: AppTextStyles.h3.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'À implémenter dans Story 3.2',
                            style: AppTextStyles.body2.copyWith(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Complete button
                  ElevatedButton(
                    onPressed: () => _showCompleteDialog(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.success,
                    ),
                    child: Text(
                      'Terminer la séance',
                      style: AppTextStyles.button.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is ActiveWorkoutError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Erreur')),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        color: Colors.red, size: 64),
                    const SizedBox(height: 16),
                    Text(
                      'Une erreur est survenue :',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Retour'),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: Text('No active session')),
        );
      },
    );
  }

  void _showAbandonDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Abandonner la séance ?'),
        content: const Text(
          'Êtes-vous sûr de vouloir abandonner cette séance ? Vos progrès ne seront pas sauvegardés.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<ActiveWorkoutBloc>().add(const AbandonSession());
            },
            child: const Text(
              'Abandonner',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showCompleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Terminer la séance ?'),
        content: const Text(
          'Êtes-vous sûr de vouloir terminer cette séance ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<ActiveWorkoutBloc>().add(const CompleteSession());
            },
            child: const Text('Terminer'),
          ),
        ],
      ),
    );
  }
}
