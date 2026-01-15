import 'package:dio/dio.dart';
import 'package:hoppr_frontend/data/api/models/ticket_dto.dart';

/// Error interceptor for handling API errors
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Try to parse error response
    if (err.response != null) {
      try {
        final errorResponse = ErrorResponse.fromJson(
          err.response!.data as Map<String, dynamic>,
        );
        handler.reject(
          DioException(
            requestOptions: err.requestOptions,
            response: err.response,
            type: err.type,
            error: errorResponse,
          ),
        );
        return;
      } catch (_) {
        // If parsing fails, continue with original error
      }
    }

    handler.next(err);
  }
}
