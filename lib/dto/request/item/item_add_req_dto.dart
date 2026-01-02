import 'dart:io';

import 'package:dio/dio.dart';

class ItemAddReqDto {
  int eventType;
  int itemType;
  int? weddingPrice;
  int? defaultPrice;
  File? file;

  ItemAddReqDto({
    required this.eventType,
    required this.itemType,
    this.weddingPrice,
    this.defaultPrice,
    this.file,
  });

  Future<Map<String, dynamic>> toMap() async{
    return {
      'event_type': eventType,
      'item_type': itemType,
      'wedding_price': weddingPrice,
      'default_price': defaultPrice,
      'file': file != null ? await MultipartFile.fromFile(file!.path) : null
    };
  }
}
