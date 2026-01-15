import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoppr_frontend/features/auth/data/auth_service.dart';
import 'package:hoppr_frontend/features/auth/data/auth_state.dart';

/// Auth service provider
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

/// Auth state provider
final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthStateNotifier(authService);
});

class AuthStateNotifier extends StateNotifier<AuthState> {
  final AuthService _authService;

  AuthStateNotifier(this._authService) : super(const AuthState()) {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final token = await _authService.getToken();
    if (token != null && !_authService.isTokenExpired(token)) {
      final userId = _authService.getUserIdFromToken(token);
      final email = _authService.getEmailFromToken(token);
      state = AuthState(
        token: token,
        userId: userId,
        email: email,
        isAuthenticated: true,
      );
    }
  }

  Future<bool> login() async {
    final result = await _authService.login();
    if (result != null && result.accessToken != null) {
      final userId = _authService.getUserIdFromToken(result.accessToken);
      final email = _authService.getEmailFromToken(result.accessToken);
      state = AuthState(
        token: result.accessToken,
        refreshToken: result.refreshToken,
        userId: userId,
        email: email,
        isAuthenticated: true,
      );
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _authService.logout();
    state = const AuthState();
  }

  Future<void> refreshTokenIfNeeded() async {
    if (state.token != null &&
        _authService.isTokenExpired(state.token)) {
      final newToken = await _authService.refreshToken();
      if (newToken != null) {
        final userId = _authService.getUserIdFromToken(newToken);
        final email = _authService.getEmailFromToken(newToken);
        state = state.copyWith(
          token: newToken,
          userId: userId,
          email: email,
        );
      } else {
        // Refresh failed, logout
        await logout();
      }
    }
  }
}
