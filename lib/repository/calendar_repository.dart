import 'package:bride_house/configs/dio_config.dart';
import 'package:bride_house/dto/response/holiday_resp_dto.dart';
import 'package:dio/dio.dart';

class CalendarRepository {
  final Dio _dio = DioConfig.calendarDioObject();

  // final Map<String, dynamic> _options = {
  //   "CALENDAR_ID": "ko.south_korea%23holiday%40group.v.calendar.google.com",
  //   "API_KEY": "AIzaSyBSWR3CWYOolyjqmFO1Z_FMfSIe37xXTWI",
  // };
  String _secretKey = 'pP48C4BQCPTcrP+x6mCCc3YrBuC6OtEnK4fgF3PFRAMMNj2IED/JWzrj85mcFQuLcw1Tjy6njgh03FsO43f3hA==';
  String _holidayUrl = "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo";
  String _divisionUrl = "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/get24DivisionsInfo";

  Future<List<HolidayRespDto>> getHolidays() async {
    int currentYear = DateTime.now().year;
    List<HolidayRespDto> result = [];

    for (int year = currentYear - 2; year <= currentYear + 2; year++) {
      Response holidayReq = await _dio.get(
        _holidayUrl,
        queryParameters: {'solYear': year, 'ServiceKey': _secretKey, '_type': 'json', 'numOfRows': 100},
      );

      if (holidayReq.statusCode != 200) {
        throw Exception(holidayReq.data['error']);
      }

      List<dynamic> list = holidayReq.data['response']['body']['items']['item'];
      result.addAll(list.map((e) => HolidayRespDto.fromMap(e)).toList());
    }

    return result;
  }
}
