import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stepwise/data/database/database.dart';
import 'package:stepwise/data/providers/database_provider.dart';

class CreateHabitPage extends HookConsumerWidget {
  const CreateHabitPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final titleController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final isDaily = useState(false);
    final hasReminder = useState(false);
    final reminderTime =
        useState<TimeOfDay?>(const TimeOfDay(hour: 10, minute: 0));
    Future<void> onPressed() async {
      final title = titleController.text;
      final description = descriptionController.text;

      if (title.isEmpty) {
        return;
      }
      final habit = HabitsCompanion.insert(
        title: title,
        desc: Value(description),
        isDaily: Value(isDaily.value),
        createdAt: Value(DateTime.now()),
        reminderTime: Value(reminderTime.value?.format(context)),
      );
      await ref.read(databaseProvider).createHabit(habit);
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Habit'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: 'Habit Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16))),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16))),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Goal',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Daily'),
                Switch(
                    value: isDaily.value,
                    onChanged: (value) => isDaily.value = value)
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text('Reminder',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.alarm, color: colorScheme.primary),
                    const SizedBox(width: 8),
                    const Text("Has Reminder"),
                  ],
                ),
                Switch(
                  value: hasReminder.value,
                  onChanged: (value) {
                    hasReminder.value = value;
                    if (value && reminderTime.value == null) {
                      reminderTime.value = const TimeOfDay(hour: 10, minute: 0);
                    }
                  },
                ),
              ],
            ),
            if (hasReminder.value) ...[
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () async {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: reminderTime.value ?? TimeOfDay.now(),
                  );
                  if (time != null) {
                    reminderTime.value = time;
                  }
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Reminder Time", style: TextStyle(fontSize: 16)),
                        Text(
                          reminderTime.value != null
                              ? "${reminderTime.value!.hour % 12 == 0 ? 12 : reminderTime.value!.hour % 12}:${reminderTime.value!.minute.toString().padLeft(2, '0')} ${reminderTime.value!.hour >= 12 ? 'PM' : 'AM'}"
                              : "No time selected",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                height: 48,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary),
                    onPressed: onPressed,
                    child: const Text("Create Habit",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold))))
          ],
        ),
      ),
    );
  }
}
