// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TicketDto _$TicketDtoFromJson(Map<String, dynamic> json) {
  return _TicketDto.fromJson(json);
}

/// @nodoc
mixin _$TicketDto {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_hash')
  String get fileHash => throw _privateConstructorUsedError;
  @JsonKey(name: 'file_path')
  String get filePath => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_at')
  String get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  String get updatedAt => throw _privateConstructorUsedError; // Extended fields
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get provider => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  List<String>? get zones => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_urls')
  List<String>? get imageUrls => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TicketDtoCopyWith<TicketDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TicketDtoCopyWith<$Res> {
  factory $TicketDtoCopyWith(TicketDto value, $Res Function(TicketDto) then) =
      _$TicketDtoCopyWithImpl<$Res, TicketDto>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String status,
      @JsonKey(name: 'file_hash') String fileHash,
      @JsonKey(name: 'file_path') String filePath,
      @JsonKey(name: 'expires_at') String expiresAt,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt,
      String? title,
      String? description,
      String? type,
      String? provider,
      String? location,
      List<String>? zones,
      @JsonKey(name: 'image_urls') List<String>? imageUrls});
}

/// @nodoc
class _$TicketDtoCopyWithImpl<$Res, $Val extends TicketDto>
    implements $TicketDtoCopyWith<$Res> {
  _$TicketDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? status = null,
    Object? fileHash = null,
    Object? filePath = null,
    Object? expiresAt = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? type = freezed,
    Object? provider = freezed,
    Object? location = freezed,
    Object? zones = freezed,
    Object? imageUrls = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      fileHash: null == fileHash
          ? _value.fileHash
          : fileHash // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      zones: freezed == zones
          ? _value.zones
          : zones // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      imageUrls: freezed == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TicketDtoImplCopyWith<$Res>
    implements $TicketDtoCopyWith<$Res> {
  factory _$$TicketDtoImplCopyWith(
          _$TicketDtoImpl value, $Res Function(_$TicketDtoImpl) then) =
      __$$TicketDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'user_id') String userId,
      String status,
      @JsonKey(name: 'file_hash') String fileHash,
      @JsonKey(name: 'file_path') String filePath,
      @JsonKey(name: 'expires_at') String expiresAt,
      @JsonKey(name: 'created_at') String createdAt,
      @JsonKey(name: 'updated_at') String updatedAt,
      String? title,
      String? description,
      String? type,
      String? provider,
      String? location,
      List<String>? zones,
      @JsonKey(name: 'image_urls') List<String>? imageUrls});
}

/// @nodoc
class __$$TicketDtoImplCopyWithImpl<$Res>
    extends _$TicketDtoCopyWithImpl<$Res, _$TicketDtoImpl>
    implements _$$TicketDtoImplCopyWith<$Res> {
  __$$TicketDtoImplCopyWithImpl(
      _$TicketDtoImpl _value, $Res Function(_$TicketDtoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? status = null,
    Object? fileHash = null,
    Object? filePath = null,
    Object? expiresAt = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? title = freezed,
    Object? description = freezed,
    Object? type = freezed,
    Object? provider = freezed,
    Object? location = freezed,
    Object? zones = freezed,
    Object? imageUrls = freezed,
  }) {
    return _then(_$TicketDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      fileHash: null == fileHash
          ? _value.fileHash
          : fileHash // ignore: cast_nullable_to_non_nullable
              as String,
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      provider: freezed == provider
          ? _value.provider
          : provider // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      zones: freezed == zones
          ? _value._zones
          : zones // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      imageUrls: freezed == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TicketDtoImpl implements _TicketDto {
  const _$TicketDtoImpl(
      {required this.id,
      @JsonKey(name: 'user_id') required this.userId,
      required this.status,
      @JsonKey(name: 'file_hash') required this.fileHash,
      @JsonKey(name: 'file_path') required this.filePath,
      @JsonKey(name: 'expires_at') required this.expiresAt,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt,
      this.title,
      this.description,
      this.type,
      this.provider,
      this.location,
      final List<String>? zones,
      @JsonKey(name: 'image_urls') final List<String>? imageUrls})
      : _zones = zones,
        _imageUrls = imageUrls;

  factory _$TicketDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TicketDtoImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  final String status;
  @override
  @JsonKey(name: 'file_hash')
  final String fileHash;
  @override
  @JsonKey(name: 'file_path')
  final String filePath;
  @override
  @JsonKey(name: 'expires_at')
  final String expiresAt;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final String updatedAt;
// Extended fields
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? type;
  @override
  final String? provider;
  @override
  final String? location;
  final List<String>? _zones;
  @override
  List<String>? get zones {
    final value = _zones;
    if (value == null) return null;
    if (_zones is EqualUnmodifiableListView) return _zones;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _imageUrls;
  @override
  @JsonKey(name: 'image_urls')
  List<String>? get imageUrls {
    final value = _imageUrls;
    if (value == null) return null;
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TicketDto(id: $id, userId: $userId, status: $status, fileHash: $fileHash, filePath: $filePath, expiresAt: $expiresAt, createdAt: $createdAt, updatedAt: $updatedAt, title: $title, description: $description, type: $type, provider: $provider, location: $location, zones: $zones, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TicketDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.fileHash, fileHash) ||
                other.fileHash == fileHash) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.provider, provider) ||
                other.provider == provider) &&
            (identical(other.location, location) ||
                other.location == location) &&
            const DeepCollectionEquality().equals(other._zones, _zones) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      status,
      fileHash,
      filePath,
      expiresAt,
      createdAt,
      updatedAt,
      title,
      description,
      type,
      provider,
      location,
      const DeepCollectionEquality().hash(_zones),
      const DeepCollectionEquality().hash(_imageUrls));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TicketDtoImplCopyWith<_$TicketDtoImpl> get copyWith =>
      __$$TicketDtoImplCopyWithImpl<_$TicketDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TicketDtoImplToJson(
      this,
    );
  }
}

abstract class _TicketDto implements TicketDto {
  const factory _TicketDto(
          {required final String id,
          @JsonKey(name: 'user_id') required final String userId,
          required final String status,
          @JsonKey(name: 'file_hash') required final String fileHash,
          @JsonKey(name: 'file_path') required final String filePath,
          @JsonKey(name: 'expires_at') required final String expiresAt,
          @JsonKey(name: 'created_at') required final String createdAt,
          @JsonKey(name: 'updated_at') required final String updatedAt,
          final String? title,
          final String? description,
          final String? type,
          final String? provider,
          final String? location,
          final List<String>? zones,
          @JsonKey(name: 'image_urls') final List<String>? imageUrls}) =
      _$TicketDtoImpl;

  factory _TicketDto.fromJson(Map<String, dynamic> json) =
      _$TicketDtoImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'user_id')
  String get userId;
  @override
  String get status;
  @override
  @JsonKey(name: 'file_hash')
  String get fileHash;
  @override
  @JsonKey(name: 'file_path')
  String get filePath;
  @override
  @JsonKey(name: 'expires_at')
  String get expiresAt;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  String get updatedAt;
  @override // Extended fields
  String? get title;
  @override
  String? get description;
  @override
  String? get type;
  @override
  String? get provider;
  @override
  String? get location;
  @override
  List<String>? get zones;
  @override
  @JsonKey(name: 'image_urls')
  List<String>? get imageUrls;
  @override
  @JsonKey(ignore: true)
  _$$TicketDtoImplCopyWith<_$TicketDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateTicketRequest _$CreateTicketRequestFromJson(Map<String, dynamic> json) {
  return _CreateTicketRequest.fromJson(json);
}

/// @nodoc
mixin _$CreateTicketRequest {
  @JsonKey(name: 'expires_at')
  String get expiresAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'content_type')
  String get contentType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateTicketRequestCopyWith<CreateTicketRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTicketRequestCopyWith<$Res> {
  factory $CreateTicketRequestCopyWith(
          CreateTicketRequest value, $Res Function(CreateTicketRequest) then) =
      _$CreateTicketRequestCopyWithImpl<$Res, CreateTicketRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'expires_at') String expiresAt,
      @JsonKey(name: 'content_type') String contentType});
}

/// @nodoc
class _$CreateTicketRequestCopyWithImpl<$Res, $Val extends CreateTicketRequest>
    implements $CreateTicketRequestCopyWith<$Res> {
  _$CreateTicketRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expiresAt = null,
    Object? contentType = null,
  }) {
    return _then(_value.copyWith(
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateTicketRequestImplCopyWith<$Res>
    implements $CreateTicketRequestCopyWith<$Res> {
  factory _$$CreateTicketRequestImplCopyWith(_$CreateTicketRequestImpl value,
          $Res Function(_$CreateTicketRequestImpl) then) =
      __$$CreateTicketRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'expires_at') String expiresAt,
      @JsonKey(name: 'content_type') String contentType});
}

/// @nodoc
class __$$CreateTicketRequestImplCopyWithImpl<$Res>
    extends _$CreateTicketRequestCopyWithImpl<$Res, _$CreateTicketRequestImpl>
    implements _$$CreateTicketRequestImplCopyWith<$Res> {
  __$$CreateTicketRequestImplCopyWithImpl(_$CreateTicketRequestImpl _value,
      $Res Function(_$CreateTicketRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? expiresAt = null,
    Object? contentType = null,
  }) {
    return _then(_$CreateTicketRequestImpl(
      expiresAt: null == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as String,
      contentType: null == contentType
          ? _value.contentType
          : contentType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateTicketRequestImpl implements _CreateTicketRequest {
  const _$CreateTicketRequestImpl(
      {@JsonKey(name: 'expires_at') required this.expiresAt,
      @JsonKey(name: 'content_type') required this.contentType});

  factory _$CreateTicketRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateTicketRequestImplFromJson(json);

  @override
  @JsonKey(name: 'expires_at')
  final String expiresAt;
  @override
  @JsonKey(name: 'content_type')
  final String contentType;

  @override
  String toString() {
    return 'CreateTicketRequest(expiresAt: $expiresAt, contentType: $contentType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTicketRequestImpl &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.contentType, contentType) ||
                other.contentType == contentType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, expiresAt, contentType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTicketRequestImplCopyWith<_$CreateTicketRequestImpl> get copyWith =>
      __$$CreateTicketRequestImplCopyWithImpl<_$CreateTicketRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateTicketRequestImplToJson(
      this,
    );
  }
}

abstract class _CreateTicketRequest implements CreateTicketRequest {
  const factory _CreateTicketRequest(
          {@JsonKey(name: 'expires_at') required final String expiresAt,
          @JsonKey(name: 'content_type') required final String contentType}) =
      _$CreateTicketRequestImpl;

  factory _CreateTicketRequest.fromJson(Map<String, dynamic> json) =
      _$CreateTicketRequestImpl.fromJson;

  @override
  @JsonKey(name: 'expires_at')
  String get expiresAt;
  @override
  @JsonKey(name: 'content_type')
  String get contentType;
  @override
  @JsonKey(ignore: true)
  _$$CreateTicketRequestImplCopyWith<_$CreateTicketRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CreateTicketResponse _$CreateTicketResponseFromJson(Map<String, dynamic> json) {
  return _CreateTicketResponse.fromJson(json);
}

/// @nodoc
mixin _$CreateTicketResponse {
  @JsonKey(name: 'ticket_id')
  String get ticketId => throw _privateConstructorUsedError;
  @JsonKey(name: 'upload_url')
  String get uploadUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'upload_url_expires_at')
  String get uploadUrlExpiresAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreateTicketResponseCopyWith<CreateTicketResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateTicketResponseCopyWith<$Res> {
  factory $CreateTicketResponseCopyWith(CreateTicketResponse value,
          $Res Function(CreateTicketResponse) then) =
      _$CreateTicketResponseCopyWithImpl<$Res, CreateTicketResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'ticket_id') String ticketId,
      @JsonKey(name: 'upload_url') String uploadUrl,
      @JsonKey(name: 'upload_url_expires_at') String uploadUrlExpiresAt});
}

/// @nodoc
class _$CreateTicketResponseCopyWithImpl<$Res,
        $Val extends CreateTicketResponse>
    implements $CreateTicketResponseCopyWith<$Res> {
  _$CreateTicketResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticketId = null,
    Object? uploadUrl = null,
    Object? uploadUrlExpiresAt = null,
  }) {
    return _then(_value.copyWith(
      ticketId: null == ticketId
          ? _value.ticketId
          : ticketId // ignore: cast_nullable_to_non_nullable
              as String,
      uploadUrl: null == uploadUrl
          ? _value.uploadUrl
          : uploadUrl // ignore: cast_nullable_to_non_nullable
              as String,
      uploadUrlExpiresAt: null == uploadUrlExpiresAt
          ? _value.uploadUrlExpiresAt
          : uploadUrlExpiresAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateTicketResponseImplCopyWith<$Res>
    implements $CreateTicketResponseCopyWith<$Res> {
  factory _$$CreateTicketResponseImplCopyWith(_$CreateTicketResponseImpl value,
          $Res Function(_$CreateTicketResponseImpl) then) =
      __$$CreateTicketResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ticket_id') String ticketId,
      @JsonKey(name: 'upload_url') String uploadUrl,
      @JsonKey(name: 'upload_url_expires_at') String uploadUrlExpiresAt});
}

/// @nodoc
class __$$CreateTicketResponseImplCopyWithImpl<$Res>
    extends _$CreateTicketResponseCopyWithImpl<$Res, _$CreateTicketResponseImpl>
    implements _$$CreateTicketResponseImplCopyWith<$Res> {
  __$$CreateTicketResponseImplCopyWithImpl(_$CreateTicketResponseImpl _value,
      $Res Function(_$CreateTicketResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ticketId = null,
    Object? uploadUrl = null,
    Object? uploadUrlExpiresAt = null,
  }) {
    return _then(_$CreateTicketResponseImpl(
      ticketId: null == ticketId
          ? _value.ticketId
          : ticketId // ignore: cast_nullable_to_non_nullable
              as String,
      uploadUrl: null == uploadUrl
          ? _value.uploadUrl
          : uploadUrl // ignore: cast_nullable_to_non_nullable
              as String,
      uploadUrlExpiresAt: null == uploadUrlExpiresAt
          ? _value.uploadUrlExpiresAt
          : uploadUrlExpiresAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateTicketResponseImpl implements _CreateTicketResponse {
  const _$CreateTicketResponseImpl(
      {@JsonKey(name: 'ticket_id') required this.ticketId,
      @JsonKey(name: 'upload_url') required this.uploadUrl,
      @JsonKey(name: 'upload_url_expires_at')
      required this.uploadUrlExpiresAt});

  factory _$CreateTicketResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateTicketResponseImplFromJson(json);

  @override
  @JsonKey(name: 'ticket_id')
  final String ticketId;
  @override
  @JsonKey(name: 'upload_url')
  final String uploadUrl;
  @override
  @JsonKey(name: 'upload_url_expires_at')
  final String uploadUrlExpiresAt;

  @override
  String toString() {
    return 'CreateTicketResponse(ticketId: $ticketId, uploadUrl: $uploadUrl, uploadUrlExpiresAt: $uploadUrlExpiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateTicketResponseImpl &&
            (identical(other.ticketId, ticketId) ||
                other.ticketId == ticketId) &&
            (identical(other.uploadUrl, uploadUrl) ||
                other.uploadUrl == uploadUrl) &&
            (identical(other.uploadUrlExpiresAt, uploadUrlExpiresAt) ||
                other.uploadUrlExpiresAt == uploadUrlExpiresAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, ticketId, uploadUrl, uploadUrlExpiresAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateTicketResponseImplCopyWith<_$CreateTicketResponseImpl>
      get copyWith =>
          __$$CreateTicketResponseImplCopyWithImpl<_$CreateTicketResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateTicketResponseImplToJson(
      this,
    );
  }
}

abstract class _CreateTicketResponse implements CreateTicketResponse {
  const factory _CreateTicketResponse(
      {@JsonKey(name: 'ticket_id') required final String ticketId,
      @JsonKey(name: 'upload_url') required final String uploadUrl,
      @JsonKey(name: 'upload_url_expires_at')
      required final String uploadUrlExpiresAt}) = _$CreateTicketResponseImpl;

  factory _CreateTicketResponse.fromJson(Map<String, dynamic> json) =
      _$CreateTicketResponseImpl.fromJson;

  @override
  @JsonKey(name: 'ticket_id')
  String get ticketId;
  @override
  @JsonKey(name: 'upload_url')
  String get uploadUrl;
  @override
  @JsonKey(name: 'upload_url_expires_at')
  String get uploadUrlExpiresAt;
  @override
  @JsonKey(ignore: true)
  _$$CreateTicketResponseImplCopyWith<_$CreateTicketResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ConfirmUploadRequest _$ConfirmUploadRequestFromJson(Map<String, dynamic> json) {
  return _ConfirmUploadRequest.fromJson(json);
}

/// @nodoc
mixin _$ConfirmUploadRequest {
  @JsonKey(name: 'file_hash')
  String get fileHash => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfirmUploadRequestCopyWith<ConfirmUploadRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfirmUploadRequestCopyWith<$Res> {
  factory $ConfirmUploadRequestCopyWith(ConfirmUploadRequest value,
          $Res Function(ConfirmUploadRequest) then) =
      _$ConfirmUploadRequestCopyWithImpl<$Res, ConfirmUploadRequest>;
  @useResult
  $Res call({@JsonKey(name: 'file_hash') String fileHash});
}

/// @nodoc
class _$ConfirmUploadRequestCopyWithImpl<$Res,
        $Val extends ConfirmUploadRequest>
    implements $ConfirmUploadRequestCopyWith<$Res> {
  _$ConfirmUploadRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileHash = null,
  }) {
    return _then(_value.copyWith(
      fileHash: null == fileHash
          ? _value.fileHash
          : fileHash // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfirmUploadRequestImplCopyWith<$Res>
    implements $ConfirmUploadRequestCopyWith<$Res> {
  factory _$$ConfirmUploadRequestImplCopyWith(_$ConfirmUploadRequestImpl value,
          $Res Function(_$ConfirmUploadRequestImpl) then) =
      __$$ConfirmUploadRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'file_hash') String fileHash});
}

/// @nodoc
class __$$ConfirmUploadRequestImplCopyWithImpl<$Res>
    extends _$ConfirmUploadRequestCopyWithImpl<$Res, _$ConfirmUploadRequestImpl>
    implements _$$ConfirmUploadRequestImplCopyWith<$Res> {
  __$$ConfirmUploadRequestImplCopyWithImpl(_$ConfirmUploadRequestImpl _value,
      $Res Function(_$ConfirmUploadRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileHash = null,
  }) {
    return _then(_$ConfirmUploadRequestImpl(
      fileHash: null == fileHash
          ? _value.fileHash
          : fileHash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfirmUploadRequestImpl implements _ConfirmUploadRequest {
  const _$ConfirmUploadRequestImpl(
      {@JsonKey(name: 'file_hash') required this.fileHash});

  factory _$ConfirmUploadRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfirmUploadRequestImplFromJson(json);

  @override
  @JsonKey(name: 'file_hash')
  final String fileHash;

  @override
  String toString() {
    return 'ConfirmUploadRequest(fileHash: $fileHash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfirmUploadRequestImpl &&
            (identical(other.fileHash, fileHash) ||
                other.fileHash == fileHash));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fileHash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfirmUploadRequestImplCopyWith<_$ConfirmUploadRequestImpl>
      get copyWith =>
          __$$ConfirmUploadRequestImplCopyWithImpl<_$ConfirmUploadRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfirmUploadRequestImplToJson(
      this,
    );
  }
}

abstract class _ConfirmUploadRequest implements ConfirmUploadRequest {
  const factory _ConfirmUploadRequest(
          {@JsonKey(name: 'file_hash') required final String fileHash}) =
      _$ConfirmUploadRequestImpl;

  factory _ConfirmUploadRequest.fromJson(Map<String, dynamic> json) =
      _$ConfirmUploadRequestImpl.fromJson;

  @override
  @JsonKey(name: 'file_hash')
  String get fileHash;
  @override
  @JsonKey(ignore: true)
  _$$ConfirmUploadRequestImplCopyWith<_$ConfirmUploadRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) {
  return _ErrorResponse.fromJson(json);
}

/// @nodoc
mixin _$ErrorResponse {
  String get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ErrorResponseCopyWith<ErrorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ErrorResponseCopyWith<$Res> {
  factory $ErrorResponseCopyWith(
          ErrorResponse value, $Res Function(ErrorResponse) then) =
      _$ErrorResponseCopyWithImpl<$Res, ErrorResponse>;
  @useResult
  $Res call({String code, String message});
}

/// @nodoc
class _$ErrorResponseCopyWithImpl<$Res, $Val extends ErrorResponse>
    implements $ErrorResponseCopyWith<$Res> {
  _$ErrorResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ErrorResponseImplCopyWith<$Res>
    implements $ErrorResponseCopyWith<$Res> {
  factory _$$ErrorResponseImplCopyWith(
          _$ErrorResponseImpl value, $Res Function(_$ErrorResponseImpl) then) =
      __$$ErrorResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String message});
}

/// @nodoc
class __$$ErrorResponseImplCopyWithImpl<$Res>
    extends _$ErrorResponseCopyWithImpl<$Res, _$ErrorResponseImpl>
    implements _$$ErrorResponseImplCopyWith<$Res> {
  __$$ErrorResponseImplCopyWithImpl(
      _$ErrorResponseImpl _value, $Res Function(_$ErrorResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_$ErrorResponseImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ErrorResponseImpl implements _ErrorResponse {
  const _$ErrorResponseImpl({required this.code, required this.message});

  factory _$ErrorResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ErrorResponseImplFromJson(json);

  @override
  final String code;
  @override
  final String message;

  @override
  String toString() {
    return 'ErrorResponse(code: $code, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorResponseImplCopyWith<_$ErrorResponseImpl> get copyWith =>
      __$$ErrorResponseImplCopyWithImpl<_$ErrorResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ErrorResponseImplToJson(
      this,
    );
  }
}

abstract class _ErrorResponse implements ErrorResponse {
  const factory _ErrorResponse(
      {required final String code,
      required final String message}) = _$ErrorResponseImpl;

  factory _ErrorResponse.fromJson(Map<String, dynamic> json) =
      _$ErrorResponseImpl.fromJson;

  @override
  String get code;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ErrorResponseImplCopyWith<_$ErrorResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
