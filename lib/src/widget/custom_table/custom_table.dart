import 'package:bride_house/model/custom_table/data_cell_model.dart';
import 'package:bride_house/model/custom_table/data_row_model.dart';
import 'package:bride_house/model/custom_table/header_model.dart';
import 'package:bride_house/src/widget/custom_table/custom_table_rows.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTable extends StatelessWidget {
  const CustomTable(
      {required this.headers,
      required this.rows,
      this.headerTextStyle,
      this.headerColor,
      this.rowTextStyle,
      this.rowColor,
        this.headerCellPadding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0), 
      this.rowCellPadding = const EdgeInsets.all(8.0),
      this.defaultCellValue = '-',
      this.boxDecoration,
      this.borderRadius,
      super.key});

  final List<HeaderModel> headers;
  final List<DataRowModel> rows;
  final TextStyle? headerTextStyle;
  final Color? headerColor;
  final TextStyle? rowTextStyle;
  final Color? rowColor;
  final EdgeInsetsGeometry headerCellPadding;
  final EdgeInsetsGeometry rowCellPadding;
  final String defaultCellValue;
  final BoxDecoration? boxDecoration;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: boxDecoration ??
          BoxDecoration(
            border: Border.all(color: scheme.outlineVariant),
            borderRadius: borderRadius ?? BorderRadius.circular(12.0),
          ),
      child: ClipRRect(
        borderRadius: boxDecoration?.borderRadius ?? borderRadius ?? BorderRadius.circular(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _tableHeader(),
              CustomTableRows(rows: rows, style: rowTextStyle, cellPadding: rowCellPadding),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableHeader() {
    return Container(
      decoration: BoxDecoration(color: headerColor),
      child: Row(
        children: headers.map((e) => _tableHeaderCell(e)).toList(),
      ),
    );
  }

  Widget _tableHeaderCell(HeaderModel header) {
    return Expanded(
      flex: header.flex ?? 1,
      child: Padding(
        padding: headerCellPadding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(header.title, style: headerTextStyle),
            _sortButton(onTap: header.onTap),
          ],
        ),
      ),
    );
  }

  Widget _sortButton({void Function()? onTap}) {
    if (onTap == null) {
      return const SizedBox();
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 4.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: const Padding(
            padding: EdgeInsets.all(2.0),
            child: Icon(CupertinoIcons.chevron_up_chevron_down, size: 12.0, color: Colors.indigo),
          ),
        ),
      );
    }
  }
}
