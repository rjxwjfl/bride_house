import 'package:bride_house/dto/response/product_manage/reserve_resp_dto.dart';

class CalendarEventModel {
  int id;
  String username;
  String contact;
  int eventType;
  int price;
  DateTime reservedDate;
  bool outboundFlag;
  DateTime? outboundDate;
  DateTime? inboundDate;

  CalendarEventModel({
    required this.id,
    required this.username,
    required this.contact,
    required this.eventType,
    required this.price,
    required this.reservedDate,
    required this.outboundFlag,
    this.outboundDate,
    this.inboundDate,
  });

  factory CalendarEventModel.dtoToModel(ReservationRespDto dto) {
    return CalendarEventModel(
      id: dto.id,
      username: dto.customer.userName,
      contact: dto.customer.contact,
      eventType: dto.eventType,
      price: dto.price,
      reservedDate: dto.reservedDate,
      outboundFlag: dto.outboundFlag,
      outboundDate: dto.outboundDate,
      inboundDate: dto.inboundDate,
    );
  }
}
