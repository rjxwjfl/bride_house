import 'package:flutter/material.dart';

class ItemTypeModel {
  String itemType;
  int id;

  ItemTypeModel({
    required this.itemType,
    required this.id,
  });
}

List<ItemTypeModel> itemTypeList = [
  ItemTypeModel(itemType: '드레스', id: 1),
  ItemTypeModel(itemType: '아동복', id: 2),
  ItemTypeModel(itemType: '목걸이', id: 3),
  ItemTypeModel(itemType: '티아라', id: 4),
  ItemTypeModel(itemType: '브로치', id: 5),
  ItemTypeModel(itemType: '핀', id: 6),
  ItemTypeModel(itemType: '슈즈', id: 7),
];

Map<int, Color> itemTypeColors = {
  1: Colors.indigo,     // 드레스
  2: Colors.lightGreen, // 아동복
  3: Colors.deepPurple, // 목걸이
  4: Colors.pink,       // 티아라
  5: Colors.brown,      // 브로치
  6: Colors.cyan,       // 핀
  7: Colors.amber,      // 슈즈
};