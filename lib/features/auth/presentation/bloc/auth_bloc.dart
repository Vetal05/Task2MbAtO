import 'package:flutter/foundation.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/register_user.dart';
import '../../domain/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthBloc extends ChangeNotifier {
  final LoginUser loginUser;
  final RegisterUser registerUser;
  final AuthRepository authRepository;

  AuthBloc({
    required this.loginUser,
    required this.registerUser,
    required this.authRepository,
  });

  AuthState _state = AuthInitial();
  AuthState get state => _state;

  void _emit(AuthState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> checkAuthStatus() async {
    _emit(AuthLoading());
    try {
      final isAuthenticated = await authRepository.isAuthenticated();
      if (isAuthenticated) {
        final user = await authRepository.getCurrentUser();
        _emit(AuthAuthenticated(user!));
      } else {
        _emit(AuthUnauthenticated());
      }
    } catch (e) {
      _emit(AuthError(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    _emit(AuthLoading());

    try {
      final user = await loginUser(email, password);
      _emit(AuthAuthenticated(user));

      if (kDebugMode) {
        print('✅ User logged in: ${user.email}');
      }
    } catch (e) {
      _emit(AuthError(e.toString()));
    }
  }

  Future<void> register(String email, String password, String name) async {
    _emit(AuthLoading());

    try {
      final user = await registerUser(email, password, name);
      _emit(AuthAuthenticated(user));

      if (kDebugMode) {
        print('✅ User registered: ${user.email}');
      }
    } catch (e) {
      _emit(AuthError(e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await authRepository.logout();
      _emit(AuthUnauthenticated());
    } catch (e) {
      _emit(AuthError(e.toString()));
    }
  }
}
