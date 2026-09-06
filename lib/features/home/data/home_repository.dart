import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/database.dart';
import '../../../../core/database/database_provider.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository(ref.watch(databaseProvider));
});

// Provide stream of all students
final studentsStreamProvider = StreamProvider<List<Student>>((ref) {
  return ref.watch(homeRepositoryProvider).watchStudents();
});

// Provide stream of all transactions
final transactionsStreamProvider = StreamProvider<List<TransactionRecord>>((ref) {
  return ref.watch(homeRepositoryProvider).watchTransactions();
});

// Combine both streams into a single synchronous provider for DashboardStats
final dashboardStatsProvider = Provider<DashboardStats>((ref) {
  final studentsAsync = ref.watch(studentsStreamProvider);
  final transactionsAsync = ref.watch(transactionsStreamProvider);

  // If data is still loading, return default 0s (or could return null to show skeleton)
  final students = studentsAsync.valueOrNull ?? [];
  final transactions = transactionsAsync.valueOrNull ?? [];

  int totalCollected = 0;
  int todayCollected = 0;
  
  final now = DateTime.now();
  final startOfToday = DateTime(now.year, now.month, now.day);

  for (final t in transactions) {
    if (t.type == 'Fee') {
      totalCollected += t.amount;
      if (t.date.isAfter(startOfToday)) {
        todayCollected += t.amount;
      }
    }
  }

  int expectedTotalFees = students.fold(0, (sum, s) => sum + s.totalFees);
  int pendingAmount = expectedTotalFees - totalCollected;
  if (pendingAmount < 0) pendingAmount = 0;

  return DashboardStats(
    totalStudents: students.length,
    collectedAmount: totalCollected,
    pendingAmount: pendingAmount,
    todayCollected: todayCollected,
  );
});

class DashboardStats {
  final int totalStudents;
  final int collectedAmount;
  final int pendingAmount;
  final int todayCollected;

  const DashboardStats({
    this.totalStudents = 0,
    this.collectedAmount = 0,
    this.pendingAmount = 0,
    this.todayCollected = 0,
  });
}

class HomeRepository {
  final AppDatabase _db;

  HomeRepository(this._db);

  Stream<List<Student>> watchStudents() {
    return _db.select(_db.students).watch();
  }

  Stream<List<TransactionRecord>> watchTransactions() {
    return _db.select(_db.transactions).watch();
  }
}
