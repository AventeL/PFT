import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'l10n/app_localizations.dart';
import 'presentation/blocs/exercise/exercise_bloc.dart';
import 'presentation/blocs/exercise/exercise_event.dart';
import 'presentation/blocs/workout/workout_bloc.dart';
import 'presentation/screens/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PFT - Performance Fitness Tracker',
      debugShowCheckedModeBanner: false,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr', ''),
        Locale('en', ''),
      ],
      locale: const Locale('fr', ''),

      // Utilisation du thème unifié
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                sl<ExerciseBloc>()..add(const SeedExercisesIfNeeded()),
          ),
          BlocProvider(
            create: (context) => sl<WorkoutBloc>(),
          ),
        ],
        child: const HomeScreen(),
      ),
    );
  }
}
