import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/workout.dart';
import '../../blocs/exercise/exercise_bloc.dart';
import '../../blocs/workout/workout_bloc.dart';
import '../../blocs/workout/workout_event.dart';
import '../../blocs/workout/workout_state.dart';
import '../../widgets/template_card.dart';
import 'template_preview_screen.dart';

/// Screen to display all available workout templates
class TemplateListScreen extends StatelessWidget {
  const TemplateListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Templates'),
      ),
      body: BlocBuilder<WorkoutBloc, WorkoutState>(
        builder: (context, state) {
          if (state is WorkoutLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is WorkoutError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading templates',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WorkoutBloc>().add(const LoadTemplates());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is TemplatesLoaded) {
            final templates = state.templates;

            if (templates.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.inbox_outlined, size: 64),
                    const SizedBox(height: 16),
                    Text(
                      'No templates available',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: templates.length,
              itemBuilder: (context, index) {
                final template = templates[index];
                return TemplateCard(
                  template: template,
                  onTap: () => _navigateToPreview(context, template),
                );
              },
            );
          }

          // Initial state - load templates
          context.read<WorkoutBloc>().add(const LoadTemplates());
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  void _navigateToPreview(BuildContext context, Workout template) {
    // Capture blocs before navigation
    final workoutBloc = context.read<WorkoutBloc>();
    final exerciseBloc = context.read<ExerciseBloc>();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: workoutBloc),
            BlocProvider.value(value: exerciseBloc),
          ],
          child: TemplatePreviewScreen(template: template),
        ),
      ),
    );
  }
}
