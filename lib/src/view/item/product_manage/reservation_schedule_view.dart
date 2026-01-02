import 'package:bride_house/model/item/item_model.dart';
import 'package:bride_house/src/widget/bottom_sheet/bottom_sheet.dart';
import 'package:bride_house/src/widget/table_calendar/schedule_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationScheduleView extends StatefulWidget {
  const ReservationScheduleView({required this.item, super.key});

  final ItemModel item;

  @override
  State<ReservationScheduleView> createState() => _ReservationScheduleViewState();
}

class _ReservationScheduleViewState extends State<ReservationScheduleView> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat(DateFormat.YEAR_ABBR_MONTH).format(_focusedDay)),
      ),
      body: ScheduleCalendar(
        selectedDay: _selectedDay,
        focusedDay: _focusedDay,
        selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
          }
          defaultBottomSheet(
            context: context,
            child: Text(DateFormat(DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY, 'ko_KR').format(_selectedDay)),
          );
        },
        onPageChanged: (focusedDay) {
          setState(() {
            _focusedDay = focusedDay;
          });
        },
      ),
    );
  }
}
