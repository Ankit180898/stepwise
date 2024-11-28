import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';

class TimelineView extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onSelectedDateChanged;
  const TimelineView(
      {super.key,
      required this.selectedDate,
      required this.onSelectedDateChanged});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: EasyDateTimeLine(
        headerProps: const EasyHeaderProps(
          monthPickerType: MonthPickerType.dropDown,
          showHeader: false,
          showSelectedDate: true,
        ),
        dayProps: EasyDayProps(
            dayStructure: DayStructure.dayNumDayStr,
            activeDayStyle: DayStyle(
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
                dayStrStyle: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                dayNumStyle: TextStyle(
                    color: colorScheme.onPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: colorScheme.outlineVariant, width: 1)),
                dayStrStyle: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 16,
                ),
                dayNumStyle: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.normal)),
            todayStyle: DayStyle(
                decoration: BoxDecoration(
                    color: colorScheme.surfaceTint.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12)),
                dayStrStyle:
                    TextStyle(color: colorScheme.primary, fontSize: 16),
                dayNumStyle: TextStyle(
                    color: colorScheme.onSurfaceVariant, fontSize: 16)),
            todayHighlightColor: colorScheme.primaryContainer.withOpacity(0.3),
            todayHighlightStyle: TodayHighlightStyle.withBackground),
        timeLineProps: const EasyTimeLineProps(separatorPadding: 16),
        initialDate: selectedDate,
        onDateChange: onSelectedDateChanged,
      ),
    );
  }
}
