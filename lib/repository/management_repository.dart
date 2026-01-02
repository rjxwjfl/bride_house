import 'package:bride_house/configs/dio_config.dart';
import 'package:bride_house/dto/request/management/reservation_req_dto.dart';
import 'package:bride_house/dto/response/product_manage/product_schedule_resp_dto.dart';
import 'package:bride_house/dto/response/product_manage/reserve_resp_dto.dart';
import 'package:bride_house/model/calendar/reservation_model.dart';
import 'package:bride_house/util/formatter.dart';
import 'package:dio/dio.dart';

class ManagementRepository {
  final Dio _dio = DioConfig.customDioObject();

  Future<List<ReservationRespDto>> getReservation({required int itemId}) async {
    Response req = await _dio.get('/history/$itemId');

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }

    List<dynamic> data = req.data['result'];
    List<ReservationRespDto> res = data.map((e) => ReservationRespDto.fromMap(e)).toList();

    return res;
  }

  Future<List<ReservationModel>> getResList() async{
    Response req = await _dio.get('/history');

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }

    List<dynamic> data = req.data['result'];
    List<ReservationModel> res = data.map((e) => ReservationModel.fromMap(e)).toList();

    return res;
  }

  Future<void> addReservation(ReservationReqDto dto) async {
    Response req = await _dio.post('/history/${dto.id}', data: dto.toMap());

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }
  }

  Future<void> setOutbound(int itemId, int hId) async{
    Response req = await _dio.put('/history/$itemId/outbound/$hId', data: {'outbound_date' : toSqlDate(DateTime.now())});

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }
  }

  Future<void> setInbound(int itemId, int hId) async {
    Response req = await _dio.put('/history/$itemId/inbound/$hId', data: {'inbound_date' : toSqlDate(DateTime.now())});

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }
  }

  Future<void> cancelReservation(int itemId, int hId) async {
    Response req = await _dio.delete('/history/$itemId/cancel/$hId');

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }
  }
}
