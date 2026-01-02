import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/dto/response/product_manage/reserve_resp_dto.dart';
import 'package:bride_house/main.dart';
import 'package:bride_house/model/custom_table/data_row_model.dart';
import 'package:bride_house/model/custom_table/header_model.dart';
import 'package:bride_house/model/item_reservation_model.dart';
import 'package:bride_house/src/widget/animated_progress_indicator.dart';
import 'package:bride_house/src/widget/custom_table/custom_table.dart';
import 'package:flutter/material.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({this.onTap, required this.itemId, super.key});

  final void Function()? onTap;
  final int itemId;

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0.0,
        title: Text('출입고 이력', style: StyleConfigs.titleBold.copyWith(color: scheme.onSurface.withOpacity(0.9))),
      ),
      body: StreamBuilder<List<ReservationRespDto>>(
        stream: pmBloc.reserveStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            pmBloc.sinkHistory();
            return const AnimatedProgressIndicator();
          }

          List<ReservationRespDto> list = snapshot.data!;

          list.sort((a, b) => b.reservedDate.compareTo(a.reservedDate));

          return CustomTable(
            headers: [
              HeaderModel(title: '예약일', flex: 3),
              HeaderModel(title: '고객명', flex: 2),
              HeaderModel(title: '가격', flex: 3),
              HeaderModel(title: '출고', flex: 2),
              HeaderModel(title: '출고일', flex: 3),
              HeaderModel(title: '입고일', flex: 3),
            ],
            rows: list.map((e) => historyDataRow(history: e)).toList(),
            headerColor: scheme.outlineVariant.withOpacity(0.4),
            headerTextStyle: StyleConfigs.extraSmallMed,
            rowTextStyle: StyleConfigs.extraSmall.copyWith(color: scheme.outline),
            borderRadius: BorderRadius.zero,
          );
        },
      ),
    );
  }
}
