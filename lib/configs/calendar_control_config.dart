import 'package:bride_house/dto/response/holiday_resp_dto.dart';
import 'package:bride_house/repository/calendar_repository.dart';
import 'package:calendar_view/calendar_view.dart';

class CalendarControlConfig {
  final EventController eventController = EventController();
  final CalendarRepository _repository;


  CalendarControlConfig(this._repository);

  Future<void> getHolidayData() async {
    // 내부저장소에 저장할 경우 여기에 내부저장소 데이터를 불러오는 부분을 넣어야한다.
    List<HolidayRespDto> list = await _repository.getHolidays();
    List<CalendarEventData> events = list.map((e) => CalendarEventData(title: e.summary, date: e.date, event: e.isHoliday)).toList();

    eventController.addAll(events);
  }
}
