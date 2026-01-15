// Web platform database implementation using WasmDatabase
import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

LazyDatabase createDatabaseConnection() {
  return LazyDatabase(() async {
    // Use WasmDatabase with the sqlite3.wasm file
    // driftWorkerUri is required, so we always provide it
    final result = await WasmDatabase.open(
      databaseName: 'hoppr_db',
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.dart.js'),
    );
    if (result.missingFeatures.isNotEmpty) {
      print(
          'Using ${result.chosenImplementation} due to missing browser features: '
          '${result.missingFeatures}');
    }
    return result.resolvedExecutor;
  });
}
