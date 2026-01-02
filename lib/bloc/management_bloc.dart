import 'dart:async';

import 'package:bride_house/dto/request/management/reservation_req_dto.dart';
import 'package:bride_house/dto/response/product_manage/product_schedule_resp_dto.dart';
import 'package:bride_house/dto/response/product_manage/reserve_resp_dto.dart';
import 'package:bride_house/model/calendar/reservation_model.dart';
import 'package:bride_house/model/item_reservation_model.dart';
import 'package:bride_house/repository/management_repository.dart';

class ManagementBloc {
  final ManagementRepository _repository;
  List<ReservationRespDto>? _itemResList;
  List<ReservationModel>? _resList;

  final StreamController<List<ReservationRespDto>> _reserveStream = StreamController.broadcast();
  final StreamController<List<ReservationModel>> _resListStream = StreamController.broadcast();
  Stream<List<ReservationRespDto>> get reserveStream => _reserveStream.stream;
  Stream<List<ReservationModel>> get resListStream => _resListStream.stream;

  ManagementBloc(this._repository);

  Future<void> getReservation(int itemId) async {
    _itemResList = await _repository.getReservation(itemId: itemId);
    sinkHistory();
  }

  sinkHistory(){
    _reserveStream.sink.add(_itemResList ?? []);
  }

  Future<void> getResList() async {
    _resList = await _repository.getResList();
    sinkResList();
  }

  sinkResList() {
    _resListStream.sink.add(_resList ?? []);
  }

  Future<void> addReservation(ItemReservationModel model) async {
    await _repository.addReservation(ReservationReqDto.fromModel(model));
  }

  Future<void> setOutbound(int itemId, int id) async {
    await _repository.setOutbound(itemId,id);
  }

  Future<void> setInbound(int itemId, int id) async {
    await _repository.setInbound(itemId,id);
  }

  Future<void> cancelReservation(int itemId, int id) async {
    await _repository.cancelReservation(itemId,id);
  }
}
