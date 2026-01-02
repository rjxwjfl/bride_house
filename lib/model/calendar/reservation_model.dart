import 'package:bride_house/model/item/item_model.dart';
import 'package:bride_house/model/user/customer_model.dart';
import 'package:bride_house/util/formatter.dart';

class ReservationModel {
  int id;
  ItemModel item;
  CustomerModel customer;
  int eventType;
  int price;
  DateTime reservedDate;
  bool outboundFlag;
  DateTime? outboundDate;
  DateTime? inboundDate;

  ReservationModel({
    required this.id,
    required this.item,
    required this.customer,
    required this.eventType,
    required this.price,
    required this.reservedDate,
    required this.outboundFlag,
    this.outboundDate,
    this.inboundDate,
  });

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      id: map['id'] as int,
      item: ItemModel.fromMap(map['item']),
      customer: CustomerModel.fromMap(map['customer']),
      eventType: map['eventType'] as int,
      price: map['price'] as int,
      reservedDate: fromSqlDateKST(map['reservedDate']),
      outboundFlag: intToBool(map['outboundFlag']),
      outboundDate: map['outboundDate'] != null ? fromSqlDateKST(map['outboundDate']) : null,
      inboundDate: map['inboundDate'] != null ? fromSqlDateKST(map['inboundDate']) : null,
    );
  }
}