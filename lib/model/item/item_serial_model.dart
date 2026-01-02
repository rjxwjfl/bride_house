class ItemSerialModel {
  int id;
  int eventType;
  int itemType;
  int serialNo;

  ItemSerialModel({
    required this.id,
    required this.eventType,
    required this.itemType,
    required this.serialNo,
  });

  factory ItemSerialModel.fromMap(Map<String, dynamic> map) {
    return ItemSerialModel(
      id: map['id'] as int,
      eventType: map['event_type'] as int,
      itemType: map['item_type'] as int,
      serialNo: map['serial_no'] as int,
    );
  }
}