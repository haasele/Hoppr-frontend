import 'package:drift/drift.dart';
import 'package:hoppr_frontend/data/cache/database.dart';

@DriftAccessor(tables: [Conversations])
class ChatDao extends DatabaseAccessor<AppDatabase> with _$ChatDaoMixin {
  ChatDao(AppDatabase db) : super(db);

  /// Get all conversations
  Future<List<Conversation>> getAll() => select(conversations).get();

  /// Get conversation by ID
  Future<Conversation?> getById(String id) {
    return (select(conversations)..where((c) => c.id.equals(id)))
        .getSingleOrNull();
  }

  /// Insert or update conversation
  Future<void> upsert(ConversationsCompanion conversation) {
    return into(conversations).insertOnConflictUpdate(conversation);
  }

  /// Insert or update multiple conversations
  Future<void> upsertAll(List<ConversationsCompanion> conversationList) {
    return batch((batch) {
      for (final conversation in conversationList) {
        batch.insertOnConflictUpdate(conversations, conversation);
      }
    });
  }

  /// Delete conversation
  Future<void> delete(String id) {
    return (delete(conversations)..where((c) => c.id.equals(id))).go();
  }

  /// Clear all conversations
  Future<void> clearAll() => delete(conversations).go();
}
