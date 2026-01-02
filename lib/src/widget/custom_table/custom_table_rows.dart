

import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/model/custom_table/data_row_model.dart';
import 'package:bride_house/src/widget/custom_table/custom_data_row.dart';
import 'package:flutter/material.dart';

class CustomTableRows extends StatelessWidget {
  const CustomTableRows({required this.rows, this.style, this.cellPadding, super.key});

  final List<DataRowModel> rows;
  final TextStyle? style;
  final EdgeInsetsGeometry? cellPadding;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: style ?? StyleConfigs.bodyNormal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 44.0, maxHeight: MediaQuery.of(context).size.height - kToolbarHeight * 3),
        child: Scrollbar(
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: rows.length,
            separatorBuilder: (context, index) => const Divider(height: 0.0),
            itemBuilder: (context, index) {
              DataRowModel row = rows[index];
              return CustomDataRow(row: row, cellPadding: cellPadding);
            },
          ),
        ),
      ),
    );
  }
}
