import 'package:drift/drift.dart';
import 'package:hoppr_frontend/data/cache/database.dart';

@DriftAccessor(tables: [Wishlist])
class WishlistDao extends DatabaseAccessor<AppDatabase> with _$WishlistDaoMixin {
  WishlistDao(AppDatabase db) : super(db);

  /// Get all wishlist items
  Future<List<WishlistItem>> getAll() => select(wishlist).get();

  /// Check if ticket is in wishlist
  Future<bool> isInWishlist(String ticketId) async {
    final item = await (select(wishlist)
          ..where((w) => w.ticketId.equals(ticketId)))
        .getSingleOrNull();
    return item != null;
  }

  /// Add to wishlist
  Future<void> add(String ticketId) {
    return into(wishlist).insert(
      WishlistCompanion.insert(
        ticketId: ticketId,
        addedAt: DateTime.now().toIso8601String(),
      ),
    );
  }

  /// Remove from wishlist
  Future<void> remove(String ticketId) {
    return (delete(wishlist)..where((w) => w.ticketId.equals(ticketId))).go();
  }

  /// Clear wishlist
  Future<void> clearAll() => delete(wishlist).go();
}
