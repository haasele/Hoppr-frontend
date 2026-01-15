import 'package:drift/drift.dart';
import 'package:hoppr_frontend/data/cache/database.dart';

part 'search_history_dao.g.dart';

@DriftAccessor(tables: [SearchHistory])
class SearchHistoryDao extends DatabaseAccessor<AppDatabase>
    with _$SearchHistoryDaoMixin {
  SearchHistoryDao(AppDatabase db) : super(db);

  /// Get recent searches (limit to last 10)
  Future<List<SearchHistoryData>> getRecent({int limit = 10}) {
    return (select(searchHistory)
          ..orderBy([(s) => OrderingTerm.desc(s.timestamp)])
          ..limit(limit))
        .get();
  }

  /// Add search query
  Future<void> add(String query) {
    return into(searchHistory).insert(
      SearchHistoryCompanion.insert(
        query: query,
        timestamp: DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Clear search history
  Future<void> clearAll() => delete(searchHistory).go();

  /// Delete specific search
  Future<void> deleteSearch(int id) {
    return (delete(searchHistory)..where((s) => s.id.equals(id))).go();
  }
}
