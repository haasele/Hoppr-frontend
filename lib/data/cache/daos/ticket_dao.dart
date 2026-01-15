import 'package:drift/drift.dart';
import 'package:hoppr_frontend/data/cache/database.dart';

part 'ticket_dao.g.dart';

@DriftAccessor(tables: [Tickets])
class TicketDao extends DatabaseAccessor<AppDatabase> with _$TicketDaoMixin {
  TicketDao(AppDatabase db) : super(db);

  /// Get all tickets
  Future<List<Ticket>> getAllTickets() => select(tickets).get();

  /// Get ticket by ID
  Future<Ticket?> getTicketById(String id) {
    return (select(tickets)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// Insert or update ticket
  Future<void> upsertTicket(TicketsCompanion ticket) {
    return into(tickets).insertOnConflictUpdate(ticket);
  }

  /// Insert or update multiple tickets
  Future<void> upsertTickets(List<TicketsCompanion> ticketList) async {
    await batch((batch) {
      for (final ticket in ticketList) {
        batch.insert(tickets, ticket, mode: InsertMode.insertOrReplace);
      }
    });
  }

  /// Delete ticket
  Future<void> deleteTicket(String id) {
    return (delete(tickets)..where((t) => t.id.equals(id))).go();
  }

  /// Clear all tickets
  Future<void> clearAll() => delete(tickets).go();

  /// Get tickets with pagination
  Future<List<Ticket>> getTicketsPaginated({
    int limit = 20,
    int offset = 0,
  }) {
    return (select(tickets)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit, offset: offset))
        .get();
  }
}
