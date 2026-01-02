import 'package:bride_house/model/custom_table/data_row_model.dart';
import 'package:bride_house/src/widget/custom_table/custom_data_cell.dart';
import 'package:flutter/material.dart';

class CustomDataRow extends StatelessWidget {
  const CustomDataRow({required this.row, this.rowColor, this.cellPadding, super.key});

  final DataRowModel row;
  final Color? rowColor;
  final EdgeInsetsGeometry? cellPadding;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: row.onTap,
      onLongPress: row.onLongPress,
      child: Ink(
        color: rowColor ?? scheme.surface,
        child: Row(
          children: row.cells.map((e) => CustomDataCell(dataCell: e, padding: cellPadding)).toList(),
        ),
      ),
    );
  }
}
