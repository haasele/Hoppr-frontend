import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import 'package:hoppr_frontend/core/constants/api_constants.dart';
import 'package:hoppr_frontend/data/api/models/chat_dto.dart';
import 'package:hoppr_frontend/data/api/models/ticket_dto.dart';
import 'package:hoppr_frontend/data/api/models/user_dto.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Tickets
  @GET(ApiConstants.tickets)
  Future<List<TicketDto>> getTickets({
    @Query('limit') int? limit,
    @Query('offset') int? offset,
    @Query('search') String? search,
    @Query('type') String? type,
    @Query('provider') String? provider,
    @Query('location') String? location,
  });

  @GET('${ApiConstants.ticketDetail}/{id}')
  Future<TicketDto> getTicket(@Path('id') String id);

  @POST(ApiConstants.tickets)
  Future<CreateTicketResponse> createTicket(
    @Body() CreateTicketRequest request,
    @Header(ApiConstants.idempotencyKeyHeader) String idempotencyKey,
  );

  @POST('${ApiConstants.ticketDetail}/{id}/confirm')
  Future<TicketDto> confirmUpload(
    @Path('id') String id,
    @Body() ConfirmUploadRequest request,
    @Header(ApiConstants.idempotencyKeyHeader) String idempotencyKey,
  );

  // Users
  @GET('${ApiConstants.users}/{id}')
  Future<UserDto> getUser(@Path('id') String id);

  // Conversations
  @GET(ApiConstants.conversations)
  Future<List<ConversationDto>> getConversations();

  @GET('${ApiConstants.conversations}/{id}/messages')
  Future<List<MessageDto>> getMessages(@Path('id') String conversationId);

  // Wishlist
  @GET(ApiConstants.wishlist)
  Future<List<TicketDto>> getWishlist();

  @POST(ApiConstants.wishlist)
  Future<void> addToWishlist(@Body() Map<String, String> request);

  @DELETE('${ApiConstants.wishlist}/{id}')
  Future<void> removeFromWishlist(@Path('id') String ticketId);
}

/// API service provider
final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(apiClientProvider);
  return ApiService(dio);
});
