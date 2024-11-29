import 'package:drift/drift.dart';

class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get desc => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  TextColumn get reminderTime => text().nullable()();
  IntColumn get streak => integer().withDefault(const Constant(0))();
  IntColumn get totalCompletion => integer().withDefault(const Constant(0))();
  BoolColumn get isDaily => boolean().withDefault(const Constant(false))();
}

class HabitCompletions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer()();
  DateTimeColumn get completedAt => dateTime()();
}
