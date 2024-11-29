import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stepwise/data/database/database.dart';
import 'package:stepwise/data/providers/database_provider.dart';

final habitsForDateProvider =
    StreamProvider.family<List<HabitWithCompletion>, DateTime>((ref, date) {
  final database = ref.watch(databaseProvider);
  return database.watchHabitsForDate(date);
});
