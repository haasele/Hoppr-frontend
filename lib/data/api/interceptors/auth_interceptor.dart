import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoppr_frontend/core/constants/api_constants.dart';
import 'package:hoppr_frontend/features/auth/data/auth_provider.dart';

/// Auth interceptor that adds JWT token to requests
/// Uses empty token for public browsing (optional auth)
class AuthInterceptor extends Interceptor {
  final Ref ref;

  AuthInterceptor(this.ref);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final authState = ref.read(authStateProvider);
    
    // Add token if available, otherwise use empty token for public browsing
    final token = authState.token;
    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorizationHeader] = 'Bearer $token';
    }

    handler.next(options);
  }
}
