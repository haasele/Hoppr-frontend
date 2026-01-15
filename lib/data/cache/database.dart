import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:hoppr_frontend/data/cache/daos/ticket_dao.dart';
import 'package:hoppr_frontend/data/cache/daos/wishlist_dao.dart';
import 'package:hoppr_frontend/data/cache/daos/chat_dao.dart';
import 'package:hoppr_frontend/data/cache/daos/search_history_dao.dart';

part 'database.g.dart';

/// Tickets table
class Tickets extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().named('user_id')();
  TextColumn get status => text()();
  TextColumn get fileHash => text().named('file_hash')();
  TextColumn get filePath => text().named('file_path')();
  TextColumn get expiresAt => text().named('expires_at')();
  TextColumn get createdAt => text().named('created_at')();
  TextColumn get updatedAt => text().named('updated_at')();
  TextColumn get cachedAt => text().named('cached_at')();

  @override
  Set<Column> get primaryKey => {id};
}

/// Wishlist table
class Wishlist extends Table {
  TextColumn get ticketId => text().named('ticket_id')();
  TextColumn get addedAt => text().named('added_at')();

  @override
  Set<Column> get primaryKey => {ticketId};
}

/// Conversations table
class Conversations extends Table {
  TextColumn get id => text()();
  TextColumn get userId => text().named('user_id')();
  TextColumn get ticketId => text().named('ticket_id').nullable()();
  TextColumn get lastMessage => text().named('last_message').nullable()();
  TextColumn get lastMessageAt => text().named('last_message_at').nullable()();
  IntColumn get unreadCount => integer().named('unread_count').withDefault(const Constant(0))();
  TextColumn get cachedAt => text().named('cached_at')();

  @override
  Set<Column> get primaryKey => {id};
}

/// Search history table
class SearchHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get query => text()();
  TextColumn get timestamp => text()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Tickets, Wishlist, Conversations, SearchHistory], daos: [TicketDao, WishlistDao, ChatDao, SearchHistoryDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // Handle migrations here
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'hoppr.db'));
    return NativeDatabase(file);
  });
}
