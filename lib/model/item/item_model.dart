import 'package:bride_house/util/formatter.dart';

class ItemModel {
  int id;
  int eventType;
  int itemType;
  int serialNo;
  int state;
  DateTime firstInbound;
  String? image;
  String? thumbnail;
  int wPrice;
  int dPrice;


//<editor-fold desc="Data Methods">
  ItemModel({
    required this.id,
    this.thumbnail,
    this.image,
    required this.eventType,
    required this.itemType,
    required this.serialNo,
    required this.state,
    required this.firstInbound,
    required this.wPrice,
    required this.dPrice,
  });

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as int,
      image: map['image'] != null ? map['image'] as String : null,
      thumbnail: map['thumbnail'] != null ? map['thumbnail'] as String : null,
      eventType: map['eventType'] as int,
      itemType: map['itemType'] as int,
      serialNo: map['serialNo'] as int,
      state: map['state'] as int,
      firstInbound: fromSqlDateKST(map['firstInbound']),
      wPrice: map['wPrice'] as int,
      dPrice: map['dPrice'] as int,
    );
  }

//</editor-fold>
}