import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/abandon_workout_session.dart';
import '../../../domain/usecases/complete_workout_session.dart';
import '../../../domain/usecases/get_active_session.dart';
import '../../../domain/usecases/start_workout_session.dart' as usecases;
import 'active_workout_event.dart';
import 'active_workout_state.dart';

/// BLoC for managing active workout sessions
class ActiveWorkoutBloc extends Bloc<ActiveWorkoutEvent, ActiveWorkoutState> {
  final usecases.StartWorkoutSession _startWorkoutSession;
  final GetActiveSession _getActiveSession;
  final CompleteWorkoutSession _completeWorkoutSession;
  final AbandonWorkoutSession _abandonWorkoutSession;

  ActiveWorkoutBloc({
    required usecases.StartWorkoutSession startWorkoutSession,
    required GetActiveSession getActiveSession,
    required CompleteWorkoutSession completeWorkoutSession,
    required AbandonWorkoutSession abandonWorkoutSession,
  })  : _startWorkoutSession = startWorkoutSession,
        _getActiveSession = getActiveSession,
        _completeWorkoutSession = completeWorkoutSession,
        _abandonWorkoutSession = abandonWorkoutSession,
        super(const ActiveWorkoutInitial()) {
    on<StartWorkoutSession>(_onStartWorkoutSession);
    on<LoadActiveSession>(_onLoadActiveSession);
    on<UpdateSession>(_onUpdateSession);
    on<CompleteSession>(_onCompleteSession);
    on<AbandonSession>(_onAbandonSession);
  }

  /// Handle StartWorkoutSession event
  Future<void> _onStartWorkoutSession(
    StartWorkoutSession event,
    Emitter<ActiveWorkoutState> emit,
  ) async {
    try {
      emit(const ActiveWorkoutLoading());

      final session = await _startWorkoutSession(workout: event.workout);

      emit(ActiveWorkoutActive(session));
    } catch (e) {
      emit(ActiveWorkoutError('Failed to start workout: ${e.toString()}'));
    }
  }

  /// Handle LoadActiveSession event
  Future<void> _onLoadActiveSession(
    LoadActiveSession event,
    Emitter<ActiveWorkoutState> emit,
  ) async {
    try {
      emit(const ActiveWorkoutLoading());

      final session = await _getActiveSession();

      if (session != null) {
        emit(ActiveWorkoutActive(session));
      } else {
        emit(const ActiveWorkoutInitial());
      }
    } catch (e) {
      emit(ActiveWorkoutError('Failed to load session: ${e.toString()}'));
    }
  }

  /// Handle UpdateSession event
  Future<void> _onUpdateSession(
    UpdateSession event,
    Emitter<ActiveWorkoutState> emit,
  ) async {
    try {
      emit(ActiveWorkoutActive(event.session));
    } catch (e) {
      emit(ActiveWorkoutError('Failed to update session: ${e.toString()}'));
    }
  }

  /// Handle CompleteSession event
  Future<void> _onCompleteSession(
    CompleteSession event,
    Emitter<ActiveWorkoutState> emit,
  ) async {
    try {
      if (state is! ActiveWorkoutActive) {
        emit(const ActiveWorkoutError('No active session to complete'));
        return;
      }

      final currentSession = (state as ActiveWorkoutActive).session;

      // Persist completion to database
      await _completeWorkoutSession(currentSession);

      emit(ActiveWorkoutCompleted(currentSession));
    } catch (e) {
      emit(ActiveWorkoutError('Failed to complete session: ${e.toString()}'));
    }
  }

  /// Handle AbandonSession event
  Future<void> _onAbandonSession(
    AbandonSession event,
    Emitter<ActiveWorkoutState> emit,
  ) async {
    try {
      if (state is! ActiveWorkoutActive) {
        emit(const ActiveWorkoutError('No active session to abandon'));
        return;
      }

      final currentSession = (state as ActiveWorkoutActive).session;

      // Persist abandonment to database
      await _abandonWorkoutSession(currentSession);

      emit(const ActiveWorkoutInitial());
    } catch (e) {
      emit(ActiveWorkoutError('Failed to abandon session: ${e.toString()}'));
    }
  }
}
