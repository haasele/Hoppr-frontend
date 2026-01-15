// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TicketDtoImpl _$$TicketDtoImplFromJson(Map<String, dynamic> json) =>
    _$TicketDtoImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      status: json['status'] as String,
      fileHash: json['file_hash'] as String,
      filePath: json['file_path'] as String,
      expiresAt: json['expires_at'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      title: json['title'] as String?,
      description: json['description'] as String?,
      type: json['type'] as String?,
      provider: json['provider'] as String?,
      location: json['location'] as String?,
      zones:
          (json['zones'] as List<dynamic>?)?.map((e) => e as String).toList(),
      imageUrls: (json['image_urls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$TicketDtoImplToJson(_$TicketDtoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'status': instance.status,
      'file_hash': instance.fileHash,
      'file_path': instance.filePath,
      'expires_at': instance.expiresAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'title': instance.title,
      'description': instance.description,
      'type': instance.type,
      'provider': instance.provider,
      'location': instance.location,
      'zones': instance.zones,
      'image_urls': instance.imageUrls,
    };

_$CreateTicketRequestImpl _$$CreateTicketRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateTicketRequestImpl(
      expiresAt: json['expires_at'] as String,
      contentType: json['content_type'] as String,
    );

Map<String, dynamic> _$$CreateTicketRequestImplToJson(
        _$CreateTicketRequestImpl instance) =>
    <String, dynamic>{
      'expires_at': instance.expiresAt,
      'content_type': instance.contentType,
    };

_$CreateTicketResponseImpl _$$CreateTicketResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CreateTicketResponseImpl(
      ticketId: json['ticket_id'] as String,
      uploadUrl: json['upload_url'] as String,
      uploadUrlExpiresAt: json['upload_url_expires_at'] as String,
    );

Map<String, dynamic> _$$CreateTicketResponseImplToJson(
        _$CreateTicketResponseImpl instance) =>
    <String, dynamic>{
      'ticket_id': instance.ticketId,
      'upload_url': instance.uploadUrl,
      'upload_url_expires_at': instance.uploadUrlExpiresAt,
    };

_$ConfirmUploadRequestImpl _$$ConfirmUploadRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$ConfirmUploadRequestImpl(
      fileHash: json['file_hash'] as String,
    );

Map<String, dynamic> _$$ConfirmUploadRequestImplToJson(
        _$ConfirmUploadRequestImpl instance) =>
    <String, dynamic>{
      'file_hash': instance.fileHash,
    };

_$ErrorResponseImpl _$$ErrorResponseImplFromJson(Map<String, dynamic> json) =>
    _$ErrorResponseImpl(
      code: json['code'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$ErrorResponseImplToJson(_$ErrorResponseImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
