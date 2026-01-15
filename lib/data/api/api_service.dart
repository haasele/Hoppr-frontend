import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoppr_frontend/core/constants/api_constants.dart';
import 'package:hoppr_frontend/data/api/api_client.dart';
import 'package:hoppr_frontend/data/api/models/chat_dto.dart';
import 'package:hoppr_frontend/data/api/models/ticket_dto.dart';
import 'package:hoppr_frontend/data/api/models/user_dto.dart';

// TODO: Re-enable retrofit generation once package compatibility is fixed
// For now, using manual implementation
abstract class ApiService {
  final Dio _dio;
  final String _baseUrl;

  ApiService(this._dio, {String? baseUrl}) : _baseUrl = baseUrl ?? ApiConstants.baseUrl;

  // Tickets
  Future<List<TicketDto>> getTickets({
    int? limit,
    int? offset,
    String? search,
    String? type,
    String? provider,
    String? location,
  }) async {
    final queryParams = <String, dynamic>{};
    if (limit != null) queryParams['limit'] = limit;
    if (offset != null) queryParams['offset'] = offset;
    if (search != null) queryParams['search'] = search;
    if (type != null) queryParams['type'] = type;
    if (provider != null) queryParams['provider'] = provider;
    if (location != null) queryParams['location'] = location;

    final response = await _dio.get(
      '$_baseUrl${ApiConstants.tickets}',
      queryParameters: queryParams,
    );
    return (response.data as List)
        .map((json) => TicketDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<TicketDto> getTicket(String id) async {
    final response = await _dio.get('$_baseUrl${ApiConstants.ticketDetail}/$id');
    return TicketDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<CreateTicketResponse> createTicket(
    CreateTicketRequest request,
    String idempotencyKey,
  ) async {
    final response = await _dio.post(
      '$_baseUrl${ApiConstants.tickets}',
      data: request.toJson(),
      options: Options(
        headers: {ApiConstants.idempotencyKeyHeader: idempotencyKey},
      ),
    );
    return CreateTicketResponse.fromJson(response.data as Map<String, dynamic>);
  }

  Future<TicketDto> confirmUpload(
    String id,
    ConfirmUploadRequest request,
    String idempotencyKey,
  ) async {
    final response = await _dio.post(
      '$_baseUrl${ApiConstants.ticketDetail}/$id/confirm',
      data: request.toJson(),
      options: Options(
        headers: {ApiConstants.idempotencyKeyHeader: idempotencyKey},
      ),
    );
    return TicketDto.fromJson(response.data as Map<String, dynamic>);
  }

  // Users
  Future<UserDto> getUser(String id) async {
    final response = await _dio.get('$_baseUrl${ApiConstants.users}/$id');
    return UserDto.fromJson(response.data as Map<String, dynamic>);
  }

  // Conversations
  Future<List<ConversationDto>> getConversations() async {
    final response = await _dio.get('$_baseUrl${ApiConstants.conversations}');
    return (response.data as List)
        .map((json) => ConversationDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<List<MessageDto>> getMessages(String conversationId) async {
    final response = await _dio.get(
      '$_baseUrl${ApiConstants.conversations}/$conversationId/messages',
    );
    return (response.data as List)
        .map((json) => MessageDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // Wishlist
  Future<List<TicketDto>> getWishlist() async {
    final response = await _dio.get('$_baseUrl${ApiConstants.wishlist}');
    return (response.data as List)
        .map((json) => TicketDto.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> addToWishlist(Map<String, String> request) async {
    await _dio.post(
      '$_baseUrl${ApiConstants.wishlist}',
      data: request,
    );
  }

  Future<void> removeFromWishlist(String ticketId) async {
    await _dio.delete('$_baseUrl${ApiConstants.wishlist}/$ticketId');
  }
}

/// API service provider
final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(apiClientProvider);
  return _ApiServiceImpl(dio);
});

class _ApiServiceImpl extends ApiService {
  _ApiServiceImpl(super.dio) : super();
}
