import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

/// Keycloak OIDC authentication service
class AuthService {
  final FlutterAppAuth _appAuth = const FlutterAppAuth();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Keycloak configuration - should be configurable
  static const String _clientId = 'hoppr-frontend';
  static const String _redirectUrl = 'com.hoppr.app://callback';
  static const String _issuer = 'http://localhost:8080/realms/ticket-platform';
  static const String _discoveryUrl =
      'http://localhost:8080/realms/ticket-platform/.well-known/openid-configuration';

  /// Perform login
  Future<AuthResult?> login() async {
    try {
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationServiceConfiguration(
          authorizationEndpoint:
              '$_issuer/protocol/openid-connect/auth',
          tokenEndpoint: '$_issuer/protocol/openid-connect/token',
        ),
        AuthorizationRequest(
          _clientId,
          _redirectUrl,
        ),
      );

      if (result != null) {
        // Store tokens
        await _secureStorage.write(
          key: 'access_token',
          value: result.accessToken,
        );
        await _secureStorage.write(
          key: 'refresh_token',
          value: result.refreshToken,
        );
        await _secureStorage.write(
          key: 'id_token',
          value: result.idToken,
        );

        return AuthResult(
          accessToken: result.accessToken,
          refreshToken: result.refreshToken,
          idToken: result.idToken,
        );
      }
    } catch (e) {
      // Handle error
      return null;
    }
    return null;
  }

  /// Get stored token
  Future<String?> getToken() async {
    return await _secureStorage.read(key: 'access_token');
  }

  /// Get stored refresh token
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: 'refresh_token');
  }

  /// Refresh access token
  Future<String?> refreshToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) return null;

    try {
      final result = await _appAuth.token(
        TokenRequest(
          _clientId,
          _redirectUrl,
          refreshToken: refreshToken,
        ),
        AuthorizationServiceConfiguration(
          authorizationEndpoint:
              '$_issuer/protocol/openid-connect/auth',
          tokenEndpoint: '$_issuer/protocol/openid-connect/token',
        ),
      );

      if (result != null && result.accessToken != null) {
        await _secureStorage.write(
          key: 'access_token',
          value: result.accessToken,
        );
        return result.accessToken;
      }
    } catch (e) {
      // Handle error
    }
    return null;
  }

  /// Get user ID from token
  String? getUserIdFromToken(String? token) {
    if (token == null) return null;
    try {
      final decoded = JwtDecoder.decode(token);
      return decoded['sub'] as String?;
    } catch (e) {
      return null;
    }
  }

  /// Get user email from token
  String? getEmailFromToken(String? token) {
    if (token == null) return null;
    try {
      final decoded = JwtDecoder.decode(token);
      return decoded['email'] as String?;
    } catch (e) {
      return null;
    }
  }

  /// Check if token is expired
  bool isTokenExpired(String? token) {
    if (token == null) return true;
    try {
      return JwtDecoder.isExpired(token);
    } catch (e) {
      return true;
    }
  }

  /// Logout
  Future<void> logout() async {
    await _secureStorage.delete(key: 'access_token');
    await _secureStorage.delete(key: 'refresh_token');
    await _secureStorage.delete(key: 'id_token');
  }
}

class AuthResult {
  final String? accessToken;
  final String? refreshToken;
  final String? idToken;

  AuthResult({
    required this.accessToken,
    required this.refreshToken,
    required this.idToken,
  });
}
