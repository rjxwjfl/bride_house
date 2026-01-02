import 'dart:async';
import 'dart:io';

import 'package:bride_house/dto/request/item/item_add_req_dto.dart';
import 'package:bride_house/dto/request/item/price_edit_req_dto.dart';
import 'package:bride_house/model/item/item_model.dart';
import 'package:bride_house/repository/item_repository.dart';

class ItemBloc {
  ItemBloc(this._repository);

  final ItemRepository _repository;

  int? _currentItemId;
  ItemModel? _currentItem;
  List<ItemModel>? _list;

  final StreamController<List<ItemModel>> _listStream = StreamController.broadcast();
  final StreamController<ItemModel?> _itemStream = StreamController.broadcast();

  Stream<List<ItemModel>> get listStream => _listStream.stream;

  Stream<ItemModel?> get itemStream => _itemStream.stream;

  Future<void> setItemId(int itemId) async {
    _currentItemId = itemId;
    await getItem();
  }

  Future<void> getItemList() async {
    _list = await _repository.getItemList();
    sinkList();
  }

  void sinkList() {
    _listStream.sink.add(_list ?? []);
  }

  Future<void> getItem() async {
    if (_currentItemId != null) {
      _currentItem = _list!.firstWhere((e) => e.id == _currentItemId);
    }
    _itemStream.sink.add(_currentItem);
  }

  void sinkItem(ItemModel item) {
    _itemStream.sink.add(item);
  }

  Future<void> addItem({required ItemAddReqDto item}) async {
    await _repository.addItem(item: item);
    await getItemList();
  }

  Future<void> editPrice(PriceEditReqDto price) async {
    await _repository.editPrice(price: price);
    await getItemList();
    await getItem();
  }

  Future<void> insertImage(int itemId, File file) async {
    await _repository.insertImage(itemId: itemId, file: file);
    await getItemList();
    await getItem();
  }

  Future<void> updateImage(int itemId, File file) async {
    await _repository.updateImage(itemId: itemId, file: file);
    await getItemList();
    await getItem();
  }
}
