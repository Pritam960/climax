import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'climax_app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftDatabase(tables: [Users, Students, Transactions, SyncQueue])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

@DataClassName('Student')
class Students extends Table {
  DateTimeColumn get enrolledAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get id => text()(); // local UUID
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  TextColumn get name => text()();
  TextColumn get phone => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
  TextColumn get profileImageUrl => text().nullable()(); // R2 Image URL
  TextColumn get remoteId => text().nullable()(); // Supabase UUID

  IntColumn get totalFees => integer()();
}

// Sync queue for complex operations
@DataClassName('SyncQueueItem')
class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get operation => text()(); // "INSERT", "UPDATE", "DELETE"
  DateTimeColumn get queuedAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get recordId => text()();
  TextColumn get targetTable => text()(); // Renamed from tableName
}

@DataClassName('TransactionRecord')
class Transactions extends Table {
  IntColumn get amount => integer()();
  DateTimeColumn get date => dateTime().withDefault(currentDateAndTime)();
  TextColumn get id => text()();
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();
  @override
  Set<Column> get primaryKey => {id};
  TextColumn get remoteId => text().nullable()();
  TextColumn get studentId => text().references(Students, #id)();

  TextColumn get type => text()(); // e.g. "Fee", "Refund"
}

@DataClassName('User')
class Users extends Table {
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get email => text()();
  TextColumn get id => text()(); // local ID or remote UUID
  TextColumn get name => text()();
  @override
  Set<Column> get primaryKey => {id};

  TextColumn get role => text()();
}
