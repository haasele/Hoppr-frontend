/// API configuration constants
class ApiConstants {
  // Base URL - can be configured via environment
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080/api/v1',
  );

  // Endpoints
  static const String tickets = '/tickets';
  static const String ticketDetail = '/tickets';
  static const String users = '/users';
  static const String conversations = '/conversations';
  static const String wishlist = '/wishlist';

  // Headers
  static const String authorizationHeader = 'Authorization';
  static const String idempotencyKeyHeader = 'Idempotency-Key';
  static const String contentTypeHeader = 'Content-Type';
  static const String applicationJson = 'application/json';
}
