import 'package:flutter/material.dart';

class EventTypeModel {
  String eventType;
  int id;

  EventTypeModel({
    required this.eventType,
    required this.id,
  });
}
List<EventTypeModel> eventTypeList = [
  EventTypeModel(eventType: '본식', id: 1),
  EventTypeModel(eventType: '피로연', id: 2),
  EventTypeModel(eventType: '스튜디오', id: 3),
  EventTypeModel(eventType: '돌잔치', id: 4),
  EventTypeModel(eventType: '연주회', id: 5),
  EventTypeModel(eventType: '아동복', id: 6),
  EventTypeModel(eventType: '악세서리', id: 9)
];

Map<int, Color> eventTypeColors = {
  1: Colors.blue,       // 본식
  2: Colors.pinkAccent, // 피로연
  3: Colors.purple,     // 스튜디오
  4: Colors.orange,     // 돌잔치
  5: Colors.teal,       // 연주회
  6: Colors.green,      // 아동복
  9: Colors.redAccent,  // 악세서리
};
