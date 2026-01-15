import 'package:drift/drift.dart';
import 'database_stub.dart' if (dart.library.io) 'database_native.dart' as db_impl;

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
  // Extended fields
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  TextColumn get type => text().nullable()();
  TextColumn get provider => text().nullable()();
  TextColumn get location => text().nullable()();
  TextColumn get zones => text().nullable()(); // Store as JSON string
  TextColumn get imageUrls => text().nullable()(); // Store as JSON string

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
  // Note: autoIncrement() already creates a primary key, so we don't override primaryKey
}

@DriftDatabase(tables: [Tickets, Wishlist, Conversations, SearchHistory])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(db_impl.createDatabaseConnection());

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

