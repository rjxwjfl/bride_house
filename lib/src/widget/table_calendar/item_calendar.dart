import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/model/calendar_event_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ItemCalendar extends StatefulWidget {
  const ItemCalendar(
      {this.selectedDay,
      required this.focusedDay,
      this.data,
      this.selectedDayPredicate,
      this.onDaySelected,
      this.onPageChanged,
      this.onFormatChanged,
      super.key});

  final DateTime? selectedDay;
  final DateTime focusedDay;
  final Map<DateTime, List<CalendarEventModel>>? data;
  final bool Function(DateTime)? selectedDayPredicate;
  final void Function(DateTime, DateTime)? onDaySelected;
  final void Function(DateTime)? onPageChanged;
  final void Function(CalendarFormat)? onFormatChanged;

  @override
  State<ItemCalendar> createState() => _ItemCalendarState();
}

class _ItemCalendarState extends State<ItemCalendar> {
  List<CalendarEventModel> _getEvent(DateTime date) {
    DateTime day = DateTime(date.year, date.month, date.day);
    return widget.data?[day] ?? [];
  }

  // final isHoliday = event.isNotEmpty && event[0].event == true;
  // final isCele = event.isNotEmpty && event[0].event == false;

  Color getDateColor(DateTime date) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    final isSaturday = date.weekday == DateTime.saturday;
    final isSunday = date.weekday == DateTime.sunday;
    // if (isHoliday) {
    //   return Colors.red;
    // }
    // if (isCele) {
    //   return Colors.brown;
    // }
    if (isSaturday) {
      return Colors.blue;
    }
    if (isSunday) {
      return Colors.red;
    }
    return scheme.onSurface;
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return TableCalendar(
      locale: 'ko_KR',
      eventLoader: _getEvent,
      daysOfWeekHeight: 35.0,
      rowHeight: 50.0,
      calendarFormat: CalendarFormat.month,
      focusedDay: widget.focusedDay,
      firstDay: DateTime(2020, 1, 1),
      lastDay: DateTime(2100, 12, 31),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: StyleConfigs.leadBold.copyWith(color: scheme.outline),
        weekendStyle: StyleConfigs.leadBold.copyWith(color: scheme.outline),
      ),
      headerVisible: true,
      headerStyle: HeaderStyle(
        titleCentered: true,
        titleTextFormatter: (date, locale) => DateFormat(DateFormat.YEAR_ABBR_MONTH).format(date),
        titleTextStyle: StyleConfigs.subtitleBold,
        leftChevronPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        leftChevronMargin: EdgeInsets.zero,
        rightChevronPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        rightChevronMargin: EdgeInsets.zero,
        headerPadding: const EdgeInsets.symmetric(vertical: 2.0),
        formatButtonVisible: false,
      ),
      calendarStyle: CalendarStyle(
        tablePadding: const EdgeInsets.all(8.0),
        cellMargin: const EdgeInsets.symmetric(vertical: 2.0),
        markersAlignment: Alignment.center,
        weekNumberTextStyle: StyleConfigs.bodyNormal,
        weekendTextStyle: StyleConfigs.bodyNormal.copyWith(color: Colors.redAccent),
        weekendDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, focusedDay) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
          child: Container(
            decoration: BoxDecoration(
              color: scheme.surface,
              border: Border.all(color: scheme.outlineVariant),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        disabledBuilder: (context, date, focusedDay) => const SizedBox(),
        outsideBuilder: (context, date, focusedDay) => const SizedBox(),
        selectedBuilder: (context, date, focusedDay) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
          child: Container(
            decoration: BoxDecoration(
              color: scheme.primary.withValues(alpha:0.2),
              border: Border.all(color: scheme.primary, width: 1.5),
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
        todayBuilder: (context, date, focusedDay) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
          child: Container(
            decoration:
                BoxDecoration(border: Border.all(color: scheme.primary, width: 1.5), borderRadius: BorderRadius.circular(4.0)),
          ),
        ),
        holidayBuilder: (context, date, holiday) => const SizedBox(),
        markerBuilder: (BuildContext context, DateTime date, List<CalendarEventModel> events) {
          final isInMonth = date.month == widget.focusedDay.month;
          return Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 6.0),
            child: Column(
              children: [
                Expanded(
                  child: Text('${date.day}',
                      style: StyleConfigs.bodyNormal.copyWith(color: getDateColor(date).withValues(alpha:isInMonth ? 1.0 : 0.4))),
                ),
                if (events.isNotEmpty) _stateBadge(events.first)
              ],
            ),
          );
        },
      ),
      selectedDayPredicate: widget.selectedDayPredicate,
      onDaySelected: widget.onDaySelected,
      onPageChanged: widget.onPageChanged,
      onFormatChanged: widget.onFormatChanged,
    );
  }

  Widget _stateBadge(CalendarEventModel event) {
    double iconSize = 18.0;
    if (!event.outboundFlag) {
      return Icon(Icons.schedule_rounded, size: iconSize, color: Colors.deepOrange);
    } else if (event.outboundFlag && event.inboundDate == null) {
      return Icon(Icons.output_rounded, size: iconSize, color: Colors.blueGrey);
    }
    return Icon(Icons.input_rounded, size: iconSize, color: Colors.green);
  }
}
