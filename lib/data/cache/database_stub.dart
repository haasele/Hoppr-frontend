// Stub file for web platform
import 'package:drift/drift.dart';
import 'package:drift/web.dart';

LazyDatabase createDatabaseConnection() {
  return LazyDatabase(() async {
    return WebDatabase('hoppr_db');
  });
}
