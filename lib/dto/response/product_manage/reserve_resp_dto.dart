import 'package:bride_house/dto/response/customer/customer_resp_dto.dart';
import 'package:bride_house/util/formatter.dart';

class ReservationRespDto {
  int id;
  CustomerRespDto customer;
  int eventType;
  int price;
  DateTime reservedDate;
  bool outboundFlag;
  DateTime? outboundDate;
  DateTime? inboundDate;

  ReservationRespDto({
    required this.id,
    required this.customer,
    required this.eventType,
    required this.price,
    required this.reservedDate,
    required this.outboundFlag,
    this.outboundDate,
    this.inboundDate,
  });

  factory ReservationRespDto.fromMap(Map<String, dynamic> map) {
    return ReservationRespDto(
      id: map['id'] as int,
      customer: CustomerRespDto.fromMap(map['customer']),
      eventType: map['eventType'] as int,
      price: map['price'] as int,
      reservedDate: fromSqlDateKST(map['reservedDate']),
      outboundFlag: intToBool(map['outboundFlag']),
      outboundDate: map['outboundDate'] != null ? fromSqlDateKST(map['outboundDate']) : null,
      inboundDate: map['inboundDate'] != null ? fromSqlDateKST(map['inboundDate']) : null,
    );
  }
}