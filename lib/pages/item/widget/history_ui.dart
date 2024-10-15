import 'package:bride_house/util/formatter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DataRow dataRow(
    {required String customer,
    required int category,
    required int price,
    required DateTime outbound,
    required DateTime? inbound}) {
  return DataRow(
    onLongPress: () {},
    cells: [
      DataCell(Align(alignment: Alignment.center, child: Text(customer))),
      DataCell(Align(alignment: Alignment.center, child: Text(categoryMap[category]!))),
      DataCell(Align(alignment: Alignment.center, child: Text(priceFormat.format(price)))),
      DataCell(Align(
        alignment: Alignment.center,
        child: Text(
            '${DateFormat('yyyy-MM-dd').format(outbound)}\n${DateFormat(DateFormat.HOUR_MINUTE).format(outbound)}',
            textAlign: TextAlign.center),
      )),
      DataCell(
        Align(
          alignment: Alignment.center,
          child: inbound != null
              ? Text(
                  '${DateFormat('yyyy-MM-dd').format(inbound)}\n${DateFormat(DateFormat.HOUR_MINUTE).format(inbound)}',
                  textAlign: TextAlign.center)
              : const Text('-'),
        ),
      ),
    ],
  );
}
