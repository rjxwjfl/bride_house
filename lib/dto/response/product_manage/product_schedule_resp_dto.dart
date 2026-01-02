import 'package:bride_house/dto/response/customer/customer_resp_dto.dart';
import 'package:bride_house/model/item/item_model.dart';
import 'package:bride_house/dto/response/product_manage/reserve_resp_dto.dart';
import 'package:bride_house/util/formatter.dart';

class ProductScheduleRespDto extends ReservationRespDto {
  ItemModel item;

  ProductScheduleRespDto({
    required super.id,
    required this.item,
    required super.customer,
    required super.eventType,
    required super.price,
    required super.reservedDate,
    required super.outboundFlag,
    super.outboundDate,
    super.inboundDate,
  });

  factory ProductScheduleRespDto.fromMap(Map<String, dynamic> map) {
    return ProductScheduleRespDto(
      id: map['id'] as int,
      item: ItemModel.fromMap(map['item']),
      customer: CustomerRespDto.fromMap(map['customer']),
      eventType: map['event_type'] as int,
      price: map['price'] as int,
      reservedDate: fromSqlDateKST(map['reserved_date']),
      outboundFlag: intToBool(map['outbound_flag']),
      outboundDate: map['outbound_date'] != null ? fromSqlDateKST(map['outbound_date']) : null,
      inboundDate: map['inbound_date'] != null ? fromSqlDateKST(map['inbound_date']) : null,
    );
  }
}
