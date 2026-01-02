import 'package:bride_house/model/item_reservation_model.dart';
import 'package:bride_house/util/formatter.dart';

class ReservationReqDto {
  int id; // itemId
  String username;
  String contact;
  int eventType;
  int price;
  DateTime reservedDate;

  ReservationReqDto({
    required this.id,
    required this.username,
    required this.contact,
    required this.eventType,
    required this.price,
    required this.reservedDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'contact': contact,
      'event_type': eventType,
      'price': price,
      'reserved_date': toSqlDate(reservedDate),
    };
  }

  factory ReservationReqDto.fromModel(ItemReservationModel model) {
    return ReservationReqDto(
      id: model.id,
      username: model.username,
      contact: model.contact,
      eventType: model.eventType,
      price: model.price,
      reservedDate: model.reservedDate,
    );
  }
}
