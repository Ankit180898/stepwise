import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stepwise/data/providers/database_provider.dart';

final dailySummaryProvider =
    StreamProvider.family<(int completedTasks, int totalTasks), DateTime>(
        (ref, date) {
  final database = ref.watch(databaseProvider);
  return database.watchDailySummary(date);
});
