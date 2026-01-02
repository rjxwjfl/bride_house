

class ItemReservationModel {
  int id; // itemId
  String username;
  String contact;
  int eventType;
  int price;
  DateTime reservedDate;

  ItemReservationModel({
    required this.id,
    required this.username,
    required this.contact,
    required this.eventType,
    required this.price,
    required this.reservedDate,
  });

  @override
  String toString() {
    return 'ReservationModel{id: $id, username: $username, contact: $contact, eventType: $eventType, price: $price, reservedDate: $reservedDate}';
  }
}
