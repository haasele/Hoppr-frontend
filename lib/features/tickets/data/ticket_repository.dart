import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoppr_frontend/data/api/api_service.dart';
import 'package:hoppr_frontend/data/api/models/ticket_dto.dart';
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
  final AppDatabase _database;

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
      final ticketDao = _database.ticketDao;
      await ticketDao.upsertTickets(
        dtos.map((dto) => _dtoToCompanion(dto)).toList(),
      );

      return dtos.map((dto) => _dtoToDomain(dto)).toList();
    } catch (e) {
      // Fallback to cache
      final ticketDao = _database.ticketDao;
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
      final ticketDao = _database.ticketDao;
      await ticketDao.upsertTicket(_dtoToCompanion(dto));
      return _dtoToDomain(dto);
    } catch (e) {
      // Fallback to cache
      final ticketDao = _database.ticketDao;
      final cached = await ticketDao.getTicketById(id);
      return cached != null ? _cacheToDomain(cached) : null;
    }
  }

  TicketsCompanion _dtoToCompanion(TicketDto dto) {
    return TicketsCompanion.insert(
      id: dto.id,
      userId: dto.userId,
      status: dto.status,
      fileHash: dto.fileHash,
      filePath: dto.filePath,
      expiresAt: dto.expiresAt,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      cachedAt: DateTime.now().toIso8601String(),
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
    );
  }

  Ticket _cacheToDomain(Ticket ticket) {
    return Ticket(
      id: ticket.id,
      userId: ticket.userId,
      status: ticket.status,
      fileHash: ticket.fileHash,
      filePath: ticket.filePath,
      expiresAt: DateTime.parse(ticket.expiresAt),
      createdAt: DateTime.parse(ticket.createdAt),
      updatedAt: DateTime.parse(ticket.updatedAt),
    );
  }
}
