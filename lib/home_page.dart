import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stepwise/components/daily_summary.dart';
import 'package:stepwise/components/habit_card_list.dart';
import 'package:stepwise/components/timeline_view.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = useState(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Stepwise",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TimelineView(
                selectedDate: selectedDate.value,
                onSelectedDateChanged: (date) {
                  selectedDate.value = date;
                }),
            const DailySummaryCard(
                completedTasks: 10, totalTasks: 20, date: '2024-11-28'),
            const SizedBox(
              height: 16,
            ),
            const Text("Habits"),
            const SizedBox(
              height: 16,
            ),
            HabitCardList(
              selectedDate: selectedDate.value,
            )
          ],
        ),
      )),
    );
  }
}
