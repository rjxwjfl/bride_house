import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/pages/item/widget/history_ui.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return DataTable2(
      columnSpacing: 12.0,
      horizontalMargin: 8.0,
      headingRowDecoration: BoxDecoration(color: scheme.outline.withOpacity(0.1)),
      headingTextStyle: StyleConfigs.captionNormal.copyWith(color: scheme.outline),
      dataTextStyle: StyleConfigs.captionNormal.copyWith(color: scheme.onSurface),
      columns: const [
        DataColumn2(label: Align(alignment: Alignment.center, child: Text('고객명')), size: ColumnSize.S),
        DataColumn2(label: Align(alignment: Alignment.center, child: Text('분류')), size: ColumnSize.S),
        DataColumn2(label: Align(alignment: Alignment.center, child: Text('가격'))),
        DataColumn2(label: Align(alignment: Alignment.center, child: Text('출고일'))),
        DataColumn2(label: Align(alignment: Alignment.center, child: Text('입고일'))),
      ],
      rows: [
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
        dataRow(customer: 'Abbey', category: 2, price: 1543000, outbound: DateTime.now(), inbound: DateTime.now()),
      ],
    );
  }
}
