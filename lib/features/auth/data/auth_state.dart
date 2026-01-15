import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    String? token,
    String? refreshToken,
    String? userId,
    String? email,
    @Default(false) bool isAuthenticated,
  }) = _AuthState;

  const AuthState._();
}
