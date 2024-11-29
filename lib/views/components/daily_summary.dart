import 'package:flutter/material.dart';

class DailySummaryCard extends StatelessWidget {
  const DailySummaryCard(
      {super.key,
      required this.completedTasks,
      required this.totalTasks,
      required this.date});

  final int completedTasks;
  final int totalTasks;
  final String date;

  @override
  Widget build(BuildContext context) {
    final ColorScheme = Theme.of(context).colorScheme;
    final progress = totalTasks > 0 ? completedTasks / totalTasks : 0.0;

    return Card(
      elevation: 0,
      shadowColor: ColorScheme.shadow.withOpacity(0.2),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(colors: [
              ColorScheme.primary,
              ColorScheme.primaryContainer.withOpacity(0.4)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daily Summary',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: ColorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorScheme.primary.withOpacity(0.1),
                  ),
                  child: Text(
                    date,
                    style: TextStyle(
                        color: ColorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: progress,
                    backgroundColor: ColorScheme.surface.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation(ColorScheme.primary),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  '$completedTasks / $totalTasks',
                  style: TextStyle(
                      color: ColorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
