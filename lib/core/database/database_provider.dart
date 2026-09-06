import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database.dart';

/// Provides the singleton instance of the Drift local database.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});
