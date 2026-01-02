import 'dart:io';

import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/dto/response/product_manage/product_schedule_resp_dto.dart';
import 'package:bride_house/model/calendar_event_model.dart';
import 'package:bride_house/model/calendar/reservation_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

int stringToInt(String value) {
  return int.parse(value);
}

NumberFormat priceFormat = NumberFormat('###,###,###,###');

String toSqlDate(DateTime date) {
  DateFormat format = DateFormat('yyyy-MM-dd HH:mm:ss');
  return format.format(date);
}

String toDateIndicator(DateTime? date) {
  DateFormat format = DateFormat('yyyy.MM.dd HH:mm');
  if (date == null) {
    return '-';
  }
  return format.format(date);
}

String reservationDateTime(DateTime date) {
  String dateString = DateFormat(DateFormat.YEAR_NUM_MONTH_DAY, getLocaleName()).format(date);
  String timeString = DateFormat(DateFormat.HOUR24_MINUTE, getLocaleName()).format(date);
  return '$dateString  $timeString';
}

DateTime fromSqlDateKST(String date) => DateTime.parse(date).add(const Duration(hours: 9));

const categoryMap = {0: '본식', 1: '피로연', 2: '스튜디오', 3: '돌잔치'};

const colorMap = {1: Color(0xffffffff), 2: Color(0xffd3d3d3), 3: Color(0xff808080), 4: Color(0xff222222), 5: Color(0xff000000)};

Widget stateIndicator({required int state, double? size = 14.0}) {
  var stateMap = {0: '출고 가능', 1: '출고중', 2: '예약중', 3: '수선중'};

  var stateIconMap = {
    0: Icon(Icons.check, color: Colors.green, size: size),
    1: Icon(Icons.not_interested, color: Colors.red, size: size),
    2: Icon(Icons.perm_contact_calendar_outlined, color: Colors.orange, size: size),
    3: Icon(Icons.home_repair_service_outlined, color: Colors.blue, size: size),
  };

  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      stateIconMap[state]!,
      const SizedBox(width: 4.0),
      Text(stateMap[state]!, style: StyleConfigs.captionMed),
    ],
  );
}

Map<DateTime, List<ReservationModel>> calendarScheduleFormer(List<ReservationModel>? data) {
  Map<DateTime, List<ReservationModel>> map = {};

  if (data != null) {
    for (ReservationModel event in data) {
      DateTime date = event.reservedDate;
      DateTime dateKey = DateTime(date.year, date.month, date.day);

      map.putIfAbsent(dateKey, () => []).add(event);
    }
  }
  return map;
}

Map<DateTime, List<CalendarEventModel>> calendarEventFormer(List<CalendarEventModel>? data) {
  Map<DateTime, List<CalendarEventModel>> map = {};

  if (data != null) {
    for (CalendarEventModel event in data) {
      DateTime date = event.reservedDate;
      DateTime dateKey = DateTime(date.year, date.month, date.day);

      map.putIfAbsent(dateKey, () => []).add(event);
    }
  }
  return map;
}

bool intToBool(int val) {
  const map = {0: false, 1: true};
  return map[val]!;
}

int boolToInt(bool flag) {
  const map = {false: 0, true: 1};
  return map[flag]!;
}

String getLocaleName() {
  if (kIsWeb) {
    return 'ko_KR';
  } else {
    // 다른 플랫폼에서 localeName을 사용하는 코드
    return Platform.localeName;
  }
}
