import 'package:freezed_annotation/freezed_annotation.dart';

part 'ticket.freezed.dart';

@freezed
class Ticket with _$Ticket {
  const factory Ticket({
    required String id,
    required String userId,
    required String status,
    required String fileHash,
    required String filePath,
    required DateTime expiresAt,
    required DateTime createdAt,
    required DateTime updatedAt,
    // Extended fields for UI (may not be in backend yet)
    String? title,
    String? description,
    String? type,
    String? provider,
    String? location,
    List<String>? zones,
    List<String>? imageUrls,
  }) = _Ticket;

  const Ticket._();
}
