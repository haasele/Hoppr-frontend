import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoppr_frontend/data/cache/database.dart';

/// Database provider
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});
