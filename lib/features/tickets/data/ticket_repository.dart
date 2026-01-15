import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoppr_frontend/data/api/api_service.dart';
import 'package:hoppr_frontend/data/api/models/ticket_dto.dart';
import 'package:hoppr_frontend/data/cache/database.dart' as database;
import 'package:hoppr_frontend/data/cache/database_provider.dart';
import 'package:hoppr_frontend/data/cache/daos/ticket_dao.dart';
import 'package:hoppr_frontend/features/tickets/domain/ticket.dart';

/// Ticket repository provider
final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final database = ref.watch(databaseProvider);
  return TicketRepository(apiService, database);
});

class TicketRepository {
  final ApiService _apiService;
  final database.AppDatabase _database;

  TicketRepository(this._apiService, this._database);

  /// Get tickets with caching
  Future<List<Ticket>> getTickets({
    int? limit,
    int? offset,
    String? search,
    String? type,
    String? provider,
    String? location,
  }) async {
    try {
      // Try API first
      final dtos = await _apiService.getTickets(
        limit: limit,
        offset: offset,
        search: search,
        type: type,
        provider: provider,
        location: location,
      );

      // Cache tickets
      final ticketDao = TicketDao(_database);
      await ticketDao.upsertTickets(
        dtos.map((dto) => _dtoToCompanion(dto)).toList(),
      );

      return dtos.map((dto) => _dtoToDomain(dto)).toList();
    } catch (e) {
      // Fallback to cache
      final ticketDao = TicketDao(_database);
      final cached = await ticketDao.getTicketsPaginated(
        limit: limit ?? 20,
        offset: offset ?? 0,
      );
      return cached.map((t) => _cacheToDomain(t)).toList();
    }
  }

  /// Get ticket by ID
  Future<Ticket?> getTicketById(String id) async {
    try {
      final dto = await _apiService.getTicket(id);
      // Cache it
      final ticketDao = TicketDao(_database);
      await ticketDao.upsertTicket(_dtoToCompanion(dto));
      return _dtoToDomain(dto);
    } catch (e) {
      // Fallback to cache
      final ticketDao = TicketDao(_database);
      final cached = await ticketDao.getTicketById(id);
      return cached != null ? _cacheToDomain(cached) : null;
    }
  }

  database.TicketsCompanion _dtoToCompanion(TicketDto dto) {
    // Convert lists to JSON strings for storage
    String? zonesJson;
    if (dto.zones != null && dto.zones!.isNotEmpty) {
      zonesJson = jsonEncode(dto.zones);
    }
    String? imageUrlsJson;
    if (dto.imageUrls != null && dto.imageUrls!.isNotEmpty) {
      imageUrlsJson = jsonEncode(dto.imageUrls);
    }

    return database.TicketsCompanion.insert(
      id: dto.id,
      userId: dto.userId,
      status: dto.status,
      fileHash: dto.fileHash,
      filePath: dto.filePath,
      expiresAt: dto.expiresAt,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      cachedAt: DateTime.now().toIso8601String(),
      // Extended fields
      title: Value(dto.title),
      description: Value(dto.description),
      type: Value(dto.type),
      provider: Value(dto.provider),
      location: Value(dto.location),
      zones: Value(zonesJson),
      imageUrls: Value(imageUrlsJson),
    );
  }

  Ticket _dtoToDomain(TicketDto dto) {
    return Ticket(
      id: dto.id,
      userId: dto.userId,
      status: dto.status,
      fileHash: dto.fileHash,
      filePath: dto.filePath,
      expiresAt: DateTime.parse(dto.expiresAt),
      createdAt: DateTime.parse(dto.createdAt),
      updatedAt: DateTime.parse(dto.updatedAt),
      // Extended fields
      title: dto.title,
      description: dto.description,
      type: dto.type,
      provider: dto.provider,
      location: dto.location,
      zones: dto.zones,
      imageUrls: dto.imageUrls,
    );
  }

  Ticket _cacheToDomain(database.Ticket cached) {
    // Parse JSON strings back to lists
    List<String>? zones;
    if (cached.zones != null && cached.zones!.isNotEmpty) {
      try {
        zones = List<String>.from(jsonDecode(cached.zones!));
      } catch (e) {
        // Fallback: try comma-separated
        zones = cached.zones!.split(',').where((s) => s.isNotEmpty).toList();
      }
    }
    List<String>? imageUrls;
    if (cached.imageUrls != null && cached.imageUrls!.isNotEmpty) {
      try {
        imageUrls = List<String>.from(jsonDecode(cached.imageUrls!));
      } catch (e) {
        // Fallback: try comma-separated
        imageUrls = cached.imageUrls!.split(',').where((s) => s.isNotEmpty).toList();
      }
    }

    return Ticket(
      id: cached.id,
      userId: cached.userId,
      status: cached.status,
      fileHash: cached.fileHash,
      filePath: cached.filePath,
      expiresAt: DateTime.parse(cached.expiresAt),
      createdAt: DateTime.parse(cached.createdAt),
      updatedAt: DateTime.parse(cached.updatedAt),
      // Extended fields from cache
      title: cached.title,
      description: cached.description,
      type: cached.type,
      provider: cached.provider,
      location: cached.location,
      zones: zones,
      imageUrls: imageUrls,
    );
  }
}
