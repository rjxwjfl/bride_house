class HolidayRespDto {
  String summary;
  bool isHoliday;
  DateTime date;

  HolidayRespDto({
    required this.summary,
    required this.isHoliday,
    required this.date,
  });

  factory HolidayRespDto.fromMap(Map<String, dynamic> map) {
    return HolidayRespDto(
      summary: map['dateName'] as String,
      isHoliday: _isHoliday(map['isHoliday']),
      date: DateTime.parse(map['locdate'].toString()),
    );
  }

  @override
  String toString() {
    return 'HolidayRespDto{summary: $summary, isHoliday: $isHoliday, date: $date}';
  }
}

bool _isHoliday(String value){
  if (value == 'Y'){
    return true;
  }
  return false;
}