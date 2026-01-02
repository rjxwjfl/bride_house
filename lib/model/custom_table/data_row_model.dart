import 'package:bride_house/dto/response/product_manage/reserve_resp_dto.dart';
import 'package:bride_house/model/custom_table/data_cell_model.dart';
import 'package:bride_house/util/formatter.dart';
import 'package:flutter/material.dart';

class DataRowModel {
  bool? selected = false;
  void Function(bool?)? onSelectChanged;
  void Function()? onTap;
  void Function()? onLongPress;
  WidgetStateProperty<Color?>? color;
  WidgetStateProperty<MouseCursor?>? mouseCursor;
  List<DataCellModel> cells;

  DataRowModel({
    this.selected,
    this.onSelectChanged,
    this.onTap,
    this.onLongPress,
    this.color,
    this.mouseCursor,
    required this.cells,
  });
}

DataRowModel historyDataRow({required ReservationRespDto history, void Function()? onLongPress}) {
  return DataRowModel(
    onLongPress: onLongPress,
    cells: [
      DataCellModel(child: Text(toDateIndicator(history.reservedDate), textAlign: TextAlign.center), flex: 3),
      DataCellModel(child: Text(history.customer.userName), flex: 2),
      DataCellModel(child: Text(priceFormat.format(history.price)), flex: 3),
      DataCellModel(
          child: history.outboundFlag
              ? const Icon(Icons.circle_outlined, color: Colors.green, size: 14.0)
              : const Icon(Icons.clear_rounded, color: Colors.red, size: 14.0), flex: 2),
      DataCellModel(child: Text(toDateIndicator(history.outboundDate), textAlign: TextAlign.center), flex: 3),
      DataCellModel(child: Text(toDateIndicator(history.inboundDate), textAlign: TextAlign.center), flex: 3),
    ],
  );
}

DataRowModel priceDataRow({void Function()? onTap, required String title, required int price}) {
  return DataRowModel(
    onTap: onTap,
    cells: [
      DataCellModel(child: Text(title)),
      DataCellModel(child: Text(priceFormat.format(price)), flex: 2),
    ],
  );
}
