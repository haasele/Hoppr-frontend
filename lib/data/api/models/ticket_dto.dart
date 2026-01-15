import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket_dto.freezed.dart';
part 'ticket_dto.g.dart';

@freezed
class TicketDto with _$TicketDto {
  const factory TicketDto({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    required String status,
    @JsonKey(name: 'file_hash') required String fileHash,
    @JsonKey(name: 'file_path') required String filePath,
    @JsonKey(name: 'expires_at') required String expiresAt,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    // Extended fields
    String? title,
    String? description,
    String? type,
    String? provider,
    String? location,
    List<String>? zones,
    @JsonKey(name: 'image_urls') List<String>? imageUrls,
  }) = _TicketDto;

  factory TicketDto.fromJson(Map<String, dynamic> json) =>
      _$TicketDtoFromJson(json);
}

@freezed
class CreateTicketRequest with _$CreateTicketRequest {
  const factory CreateTicketRequest({
    @JsonKey(name: 'expires_at') required String expiresAt,
    @JsonKey(name: 'content_type') required String contentType,
  }) = _CreateTicketRequest;

  factory CreateTicketRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTicketRequestFromJson(json);
}

@freezed
class CreateTicketResponse with _$CreateTicketResponse {
  const factory CreateTicketResponse({
    @JsonKey(name: 'ticket_id') required String ticketId,
    @JsonKey(name: 'upload_url') required String uploadUrl,
    @JsonKey(name: 'upload_url_expires_at')
        required String uploadUrlExpiresAt,
  }) = _CreateTicketResponse;

  factory CreateTicketResponse.fromJson(Map<String, dynamic> json) =>
      _$CreateTicketResponseFromJson(json);
}

@freezed
class ConfirmUploadRequest with _$ConfirmUploadRequest {
  const factory ConfirmUploadRequest({
    @JsonKey(name: 'file_hash') required String fileHash,
  }) = _ConfirmUploadRequest;

  factory ConfirmUploadRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmUploadRequestFromJson(json);
}

@freezed
class ErrorResponse with _$ErrorResponse {
  const factory ErrorResponse({
    required String code,
    required String message,
  }) = _ErrorResponse;

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);
}
