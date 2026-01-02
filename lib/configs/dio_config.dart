import 'package:dio/dio.dart';

// gcp url : http://34.47.64.165:3000
// local url : http://10.0.2.2:3000
// web url : http://127.0.0.1:3000
class DioConfig {
  DioConfig._();

  static final BaseOptions _options = BaseOptions(
    baseUrl: 'http://34.47.64.165:3000',
    headers: {'content-Type': 'application/json'},
    responseType: ResponseType.json,
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 10000),
    sendTimeout: const Duration(milliseconds: 5000),
  );

  static final BaseOptions _publicOption = BaseOptions();

  static final BaseOptions _calendarOption = BaseOptions(
    baseUrl: 'https://www.googleapis.com/calendar/v3',
    responseType: ResponseType.json,
  );

  static Dio customDioObject() {
    Dio dio = Dio(_options);
    return dio;
  }

  static Dio calendarDioObject(){
    Dio dio = Dio(_calendarOption);
    return dio;
  }
}
