import 'package:bride_house/configs/style_config.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

class CalendarView {
  CalendarView._();

  static final List<String> _weeks = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  static EventController controller = EventController();

  static MonthView monthView({required BuildContext context, required void Function(List<CalendarEventData> event, DateTime date) onTap}) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return MonthView(
      controller: controller,
      headerBuilder: MonthHeader.hidden,
      startDay: WeekDays.sunday,
      onCellTap: onTap,
      showBorder: false,
      useAvailableVerticalSpace: true,
      weekDayBuilder: (weekday) {
        return Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              _weeks[weekday],
              style: StyleConfigs.bodyMed.copyWith(
                color: weekday == 5
                    ? Colors.blue
                    : weekday == 6
                        ? Colors.red
                        : scheme.onSurface,
              ),
            ),
          ),
        );
      },
      cellBuilder: (date, event, isToday, isInMonth, hide) {
        final isSaturday = date.weekday == DateTime.saturday;
        final isSunday = date.weekday == DateTime.sunday;

        return Container(
          decoration: BoxDecoration(
          ),
          child: Column(
            children: [
              if (isToday)
                Container(
                  decoration: BoxDecoration(
                    color: scheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${date.day}',
                      style: StyleConfigs.bodyMed.copyWith(
                        color: isSaturday
                            ? Colors.blue
                            : isSunday
                                ? Colors.red
                                : scheme.onSurface,
                      ),
                    ),
                  ),
                )
              else if (isInMonth)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${date.day}',
                    style: StyleConfigs.bodyNormal.copyWith(
                      color: isSaturday
                          ? Colors.blue
                          : isSunday
                              ? Colors.red
                              : scheme.onSurface,
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('${date.day}', style: StyleConfigs.bodyNormal.copyWith(color: scheme.outlineVariant)),
                ),
            ],
          ),
        );
      },
    );
  }

  static WeekView weekView = WeekView(
    controller: controller,
  );
  static DayView dayView = DayView(
    controller: controller,
  );
}
