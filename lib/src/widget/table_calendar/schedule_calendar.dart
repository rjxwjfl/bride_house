import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/model/calendar/reservation_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar(
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
  final Map<DateTime, List<ReservationModel>>? data;
  final bool Function(DateTime)? selectedDayPredicate;
  final void Function(DateTime, DateTime)? onDaySelected;
  final void Function(DateTime)? onPageChanged;
  final void Function(CalendarFormat)? onFormatChanged;

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  late int numberOfWeeks;

  List<ReservationModel> _getEvent(DateTime date) {
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
      return scheme.primary;
    }
    if (isSunday) {
      return scheme.error;
    }
    return scheme.onSurface;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return TableCalendar(
      locale: 'ko_KR',
      eventLoader: _getEvent,
      daysOfWeekHeight: 30.0,
      rowHeight: 60.0,
      calendarFormat: CalendarFormat.month,
      focusedDay: widget.focusedDay,
      firstDay: DateTime(2020, 1, 1),
      lastDay: DateTime(2100, 12, 31),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: StyleConfigs.tableRow.copyWith(color: scheme.outline),
        weekendStyle: StyleConfigs.tableRow.copyWith(color: scheme.outline),
      ),
      headerVisible: false,
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
        weekNumberTextStyle: StyleConfigs.tableRow,
        weekendTextStyle: StyleConfigs.tableRow.copyWith(color: Colors.redAccent),
        weekendDecoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      ),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, focusedDay) {
          final isInMonth = date.month == widget.focusedDay.month;
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              decoration: BoxDecoration(
                color: scheme.surface,
                border: Border.all(color: scheme.outlineVariant),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  '${date.day}',
                  style: StyleConfigs.extraSmallMed.copyWith(color: getDateColor(date).withValues(alpha: isInMonth ? 1.0 : 0.4)),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
        disabledBuilder: (context, date, focusedDay) => const SizedBox(),
        outsideBuilder: (context, date, focusedDay) {
          final isInMonth = date.month == widget.focusedDay.month;
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.2)),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    '${date.day}',
                    style: StyleConfigs.extraSmallMed.copyWith(color: getDateColor(date).withValues(alpha: isInMonth ? 1.0 : 0.4)),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
        selectedBuilder: (context, date, focusedDay) {
          final isInMonth = date.month == widget.focusedDay.month;
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: scheme.surface,
                border: Border.all(color: scheme.primary.withValues(alpha: 0.6)),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: scheme.primary.withValues(alpha: 0.6)),
                  child: Text(
                    '${date.day}',
                    style: StyleConfigs.extraSmallMed.copyWith(color: getDateColor(date).withValues(alpha: isInMonth ? 1.0 : 0.4)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
        todayBuilder: (context, date, focusedDay) {
          final isInMonth = date.month == widget.focusedDay.month;
          return Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              decoration: BoxDecoration(
                color: scheme.surface,
                border: Border.all(color: scheme.outlineVariant),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: scheme.secondary.withValues(alpha: 0.2)),
                  child: Text(
                    '${date.day}',
                    style: StyleConfigs.extraSmallMed.copyWith(color: getDateColor(date).withValues(alpha: isInMonth ? 1.0 : 0.4)),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
        holidayBuilder: (context, date, holiday) => const SizedBox(),
        markerBuilder: (BuildContext context, DateTime date, List<ReservationModel> events) {
          final isInMonth = date.month == widget.focusedDay.month;
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: events.isNotEmpty
                ? Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(2.0),
              ),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: events.length > 2 ? 2 : events.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 4.0),
                        itemBuilder: (context, index) {
                          ReservationModel schedule = events[index];
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: isInMonth ? Colors.red.withValues(alpha: 0.2) : Colors.red.withValues(alpha: 0.1)),
                            child: Text(schedule.customer.username,
                                style: StyleConfigs.extraSmallMed
                                    .copyWith(color: isInMonth ? Colors.red : Colors.red.withValues(alpha: 0.8)),
                                textAlign: TextAlign.center),
                          );
                        },
                      ),
                    ),
                )
                : const SizedBox(),
          );
        },
      ),
      selectedDayPredicate: widget.selectedDayPredicate,
      onDaySelected: widget.onDaySelected,
      onPageChanged: widget.onPageChanged,
      onFormatChanged: widget.onFormatChanged,
    );
  }
}
