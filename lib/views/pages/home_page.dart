import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stepwise/views/components/daily_summary.dart';
import 'package:stepwise/views/components/habit_card_list.dart';
import 'package:stepwise/views/components/timeline_view.dart';
import 'package:stepwise/data/providers/daily_summary_provider.dart';
import 'package:intl/intl.dart';
import 'package:stepwise/views/pages/create_habit_page.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = useState(DateTime.now());
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Stepwise",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withOpacity(0.2),
              blurRadius: 16,
              spreadRadius: 4,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CreateHabitPage())),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: const Text(
                  "Create Habit",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              )),
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
            const SizedBox(
              height: 16,
            ),
            ref.watch(dailySummaryProvider(selectedDate.value)).when(
                data: (data) {
                  return DailySummaryCard(
                      completedTasks: data.$1,
                      totalTasks: data.$2,
                      date:
                          DateFormat('yyyy-MM-dd').format(selectedDate.value));
                },
                error: (Object error, StackTrace stackTrace) =>
                    Text(error.toString()),
                loading: () => const SizedBox.shrink()),
            const SizedBox(
              height: 16,
            ),
            const Text("Habits",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
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
