import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stepwise/views/components/habit_card.dart';
import 'package:stepwise/data/providers/habits_for_date_provider.dart';

class HabitCardList extends HookConsumerWidget {
  const HabitCardList({super.key, required this.selectedDate});

  final DateTime selectedDate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habitsAsyncValue = ref.watch(habitsForDateProvider(selectedDate));
    return habitsAsyncValue.when(
        data: (habits) {
          print('Fetched habits: $habits');
          return Expanded(
              child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                        height: 16,
                      ),
                  itemCount: habits.length,
                  itemBuilder: (context, index) {
                    final habitWithCompletion = habits[index];
                    return HabitCard(
                        title: habitWithCompletion.habit.title,
                        streak: habitWithCompletion.habit.streak,
                        progress: habitWithCompletion.isCompleted ? 1 : 0,
                        habitId: habitWithCompletion.habit.id,
                        isCompleted: habitWithCompletion.isCompleted,
                        date: selectedDate);
                  }));
        },
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
