import 'dart:async';
import 'dart:io';

import 'package:bride_house/configs/dio_config.dart';
import 'package:bride_house/dto/request/item/item_add_req_dto.dart';
import 'package:bride_house/dto/request/item/price_edit_req_dto.dart';
import 'package:bride_house/model/item/item_model.dart';
import 'package:dio/dio.dart';

class ItemRepository {
  final Dio _dio = DioConfig.customDioObject();

  Future<ItemModel?> getItem({required int code}) async {
    Response req = await _dio.get('/item/$code');

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }

    if (req.data['result'].length != 0) {
      return ItemModel.fromMap(req.data['result'][0]);
    }
    return null;
  }

  Future<List<ItemModel>> getItemList() async {
    Response req = await _dio.get('/item/list');

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }

    List<dynamic> data = req.data['result'];
    List<ItemModel> res = data.map((e) => ItemModel.fromMap(e)).toList();

    return res;
  }

  Future<bool> checkSerial({required int serialNo}) async {
    Response req = await _dio.get('/item/dupcheck/$serialNo');

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }

    // 중복된 시리얼코드가 존재함.
    if (req.data['result'].length != 0) {
      return true;
    }

    // 중복 없음
    return false;
  }

  Future<void> addItem({required ItemAddReqDto item}) async {
    FormData? data = FormData.fromMap(await item.toMap());

    Response req = await _dio.post('/item/add', data: data);

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }
  }

  Future<void> editPrice({required PriceEditReqDto price}) async {
    Response req = await _dio.put('/item/${price.itemId}/price', data: price.toMap());

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }
  }

  Future<void> insertImage({required int itemId, required File file}) async {
    FormData data = FormData.fromMap({'file': await MultipartFile.fromFile(file.path)});

    Response req = await _dio.post('/item/$itemId/image', data: data);

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }
  }

  Future<void> updateImage({required int itemId, required File file}) async {
    FormData data = FormData.fromMap({'file': await MultipartFile.fromFile(file.path)});

    Response req = await _dio.put('/item/$itemId/image', data: data);

    if (req.statusCode != 200) {
      throw Exception(req.data['error']);
    }
  }

  Future<void> setReservation() async{}

  Future<void> setOutbound() async {

  }
}
