import 'package:bride_house/model/custom_table/data_cell_model.dart';
import 'package:flutter/material.dart';

class CustomDataCell extends StatelessWidget {
  const CustomDataCell({
    required this.dataCell,
    this.padding = const EdgeInsets.all(8.0),
    super.key,
  });

  final DataCellModel dataCell;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: dataCell.flex ?? 1,
      child: Padding(
        padding: padding!,
        child: Center(child: dataCell.child),
      ),
    );
  }
}
