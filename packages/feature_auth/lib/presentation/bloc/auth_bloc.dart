import 'package:core/error/failures.dart';
import 'package:core/usecases/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/check_auth_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final CheckAuthUseCase checkAuthUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.checkAuthUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_loginEvent);
    on<LogoutEvent>(_logoutEvent);
    on<CheckAuthenticationEvent>(_checkAuthenticationEvent);
  }

  Future<void> _loginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final params = LoginParams(email: event.email, password: event.password);
    final result = await loginUseCase(params);
    result.fold(
      (failure) {
        if (failure is InvalidCredentialsFailure) {
          emit(AuthError(message: 'Invalid credentials'));
        } else if (failure is ServerFailure) {
          emit(AuthError(message: 'An error occurred during login'));
        }
      }, //
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  Future<void> _logoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await logoutUseCase(NoParams());
    result.fold((failure) {
      if (failure is CacheFailure) {
        emit(AuthError(message: 'An error occurred during logout'));
      } else if (failure is ServerFailure) {
        emit(AuthError(message: 'An error occurred during logout'));
      }
    }, (success) => emit(AuthUnauthenticated()));
  }

  Future<void> _checkAuthenticationEvent(CheckAuthenticationEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final result = await checkAuthUseCase(NoParams());
    await result.fold(
      (failure) async {
        emit(AuthUnauthenticated());
      },
      (isAuthenticated) async {
        if (isAuthenticated) {
          final userResult = await getCurrentUserUseCase(NoParams());
          userResult.fold(
            (failure) => emit(AuthUnauthenticated()), //
            (user) => emit(AuthAuthenticated(user: user!)),
          );
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }
}
