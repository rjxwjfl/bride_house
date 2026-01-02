import 'dart:io';

import 'package:bride_house/configs/image_picker_config.dart';
import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/model/item/item_model.dart';
import 'package:bride_house/dto/response/product_manage/reserve_resp_dto.dart';
import 'package:bride_house/generated/assets.dart';
import 'package:bride_house/main.dart';
import 'package:bride_house/model/calendar_event_model.dart';
import 'package:bride_house/model/custom_table/data_row_model.dart';
import 'package:bride_house/model/custom_table/header_model.dart';
import 'package:bride_house/src/view/item/history_view.dart';
import 'package:bride_house/src/view/item/product_manage/dialog/reservation_dialog.dart';
import 'package:bride_house/src/view/item/product_manage/price_edit_view.dart';
import 'package:bride_house/src/widget/animated_progress_indicator.dart';
import 'package:bride_house/src/widget/bottom_sheet/bottom_sheet.dart';
import 'package:bride_house/src/widget/bottom_sheet/bottom_sheet_linear_button.dart';
import 'package:bride_house/src/widget/button/custom_button_ui.dart';
import 'package:bride_house/src/widget/custom_table/custom_table.dart';
import 'package:bride_house/src/widget/dialog/show_alert_dialog.dart';
import 'package:bride_house/src/widget/event_type_indicator.dart';
import 'package:bride_house/src/widget/image_preview.dart';
import 'package:bride_house/src/widget/item_type_indicator.dart';
import 'package:bride_house/src/widget/none_glow_inkwell.dart';
import 'package:bride_house/src/widget/table_calendar/item_calendar.dart';
import 'package:bride_house/util/formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ItemView extends StatefulWidget {
  const ItemView({required this.itemId, super.key});

  final int itemId;

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  late Map<DateTime, List<CalendarEventModel>> _map;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  Future<void> _outbound(int itemId, int historyId) async {
    await pmBloc.setOutbound(itemId, historyId);
    await pmBloc.getReservation(itemId);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _inbound(int itemId, int historyId) async {
    await pmBloc.setInbound(itemId, historyId);
    await pmBloc.getReservation(itemId);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _cancel(int itemId, int historyId) async {
    await pmBloc.cancelReservation(itemId, historyId);
    await pmBloc.getReservation(itemId);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<File?> _imagePicker() async {
    ImagePicker imagePicker = ImagePicker();
    ImagePickerConfig config = ImagePickerConfig(imagePicker);

    File? file = await config.getImage(ImageSource.gallery);
    return file;
  }

  Future<void> _insertImage() async {
    File? file = await _imagePicker();
    if (file != null) {
      await itemBloc.insertImage(widget.itemId, file);
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _updateImage() async {
    File? file = await _imagePicker();
    if (file != null) {
      await itemBloc.updateImage(widget.itemId, file);
    }
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _focusedDay = DateTime.now();
    _selectedDay = _focusedDay;
    _map = {};
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(CupertinoIcons.ellipses_bubble)),
          IconButton(
              onPressed: () =>
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context) => HistoryView(itemId: widget.itemId))),
              icon: const Icon(Icons.history))
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<ItemModel?>(
            stream: itemBloc.itemStream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                itemBloc.setItemId(widget.itemId);
                return const AnimatedProgressIndicator();
              }

              ItemModel item = snapshot.data!;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: size.height * 0.3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          NonGlowInkWell(
                            onTap: () => menuBottomSheet(
                              context: context,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    if (item.thumbnail != null)
                                      BottomSheetLinearButton(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(builder: (context) => ImagePreview(url: item.image!)));
                                          },
                                          child: const Text('이미지 보기')),
                                    if (item.thumbnail != null)
                                      BottomSheetLinearButton(
                                        onTap: () async => _updateImage(),
                                        child: const Text('이미지 수정'),
                                      )
                                    else
                                      BottomSheetLinearButton(
                                        onTap: () async => _insertImage(),
                                        child: Text('이미지 업로드'),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            child: Container(
                              width: size.width * 0.3,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: scheme.surface,
                                border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.4)),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Color.fromRGBO(50, 50, 93, 0.25),
                                      offset: Offset(0, 6),
                                      blurRadius: 4.5,
                                      spreadRadius: -2.0),
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.3),
                                      offset: Offset(0, 6),
                                      blurRadius: 4.0,
                                      spreadRadius: -8.0),
                                ],
                                image: item.thumbnail != null
                                    ? DecorationImage(
                                        image: NetworkImage(item.thumbnail!),
                                        fit: BoxFit.fitHeight,
                                      )
                                    : item.image != null ? DecorationImage(
                                  image: NetworkImage(item.image!),
                                  fit: BoxFit.fitHeight,
                                ): const DecorationImage(image: AssetImage(Assets.imagesNoImageIcon), fit: BoxFit.fitWidth),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        '${item.eventType}${item.itemType}${item.serialNo.toString().padLeft(4, '0')}',
                                        style: StyleConfigs.extraTitleBold,
                                      ),
                                      const SizedBox(height: 4.0),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          EventTypeIndicator(
                                            eventType: item.eventType,
                                            style: StyleConfigs.captionMed.copyWith(color: scheme.primary),
                                          ),
                                          const SizedBox(width: 4.0),
                                          ItemTypeIndicator(
                                            itemType: item.itemType,
                                            style: StyleConfigs.captionMed.copyWith(color: scheme.secondary),
                                          ),
                                        ],
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: stateIndicator(state: item.state),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: NonGlowInkWell(
                                    onTap: () => defaultBottomSheet(context: context, child: PriceEditView(item: item)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '가격 조정',
                                            style: StyleConfigs.captionNormal.copyWith(color: scheme.outline),
                                          ),
                                          Icon(Icons.arrow_right, size: 14.0, color: scheme.outline)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                CustomTable(
                                  headers: [
                                    HeaderModel(title: '유형'),
                                    HeaderModel(title: '가격', flex: 2),
                                  ],
                                  rows: [
                                    priceDataRow(title: '본식', price: item.wPrice),
                                    priceDataRow(title: '일반', price: item.dPrice),
                                  ],
                                  headerColor: scheme.secondaryContainer.withValues(alpha: 0.5),
                                  headerTextStyle: StyleConfigs.bodyBold,
                                  rowTextStyle: StyleConfigs.captionNormal.copyWith(color: scheme.outline),
                                  boxDecoration: BoxDecoration(
                                    color: scheme.surface,
                                    border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.4)),
                                    borderRadius: BorderRadius.circular(6.0),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Color.fromRGBO(50, 50, 93, 0.25),
                                          offset: Offset(0, 6),
                                          blurRadius: 4.5,
                                          spreadRadius: -2.0),
                                      BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.3),
                                          offset: Offset(0, 6),
                                          blurRadius: 4.0,
                                          spreadRadius: -8.0),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StreamBuilder<List<ReservationRespDto>>(
                    stream: pmBloc.reserveStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        pmBloc.getReservation(widget.itemId);
                        return const AnimatedProgressIndicator();
                      }

                      List<CalendarEventModel> list = snapshot.data!.map((e) => CalendarEventModel.dtoToModel(e)).toList();

                      _map = calendarEventFormer(list);

                      DateTime selectDateKey = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);

                      List<CalendarEventModel> event = _map[selectDateKey] ?? [];

                      return SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: scheme.surface,
                                  border: Border.all(color: scheme.outline.withValues(alpha: 0.2)),
                                  borderRadius: BorderRadius.circular(6.0),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Color.fromRGBO(50, 50, 93, 0.25),
                                        offset: Offset(0, 6),
                                        blurRadius: 4.5,
                                        spreadRadius: -2.0),
                                    BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.3),
                                        offset: Offset(0, 6),
                                        blurRadius: 4.0,
                                        spreadRadius: -8.0),
                                  ],
                                ),
                                child: ItemCalendar(
                                  selectedDay: _selectedDay,
                                  focusedDay: _focusedDay,
                                  data: _map,
                                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                                  onDaySelected: (selectedDay, focusedDay) {
                                    if (!isSameDay(_selectedDay, selectedDay)) {
                                      setState(() {
                                        _selectedDay = selectedDay;
                                        _focusedDay = focusedDay;
                                      });
                                    }
                                  },
                                  onPageChanged: (focusedDay) {
                                    setState(() {
                                      _focusedDay = focusedDay;
                                    });
                                  },
                                ),
                              ),
                            ),
                            if (event.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: _getReservation(event.first),
                              )
                            else
                              NonGlowInkWell(
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => ReservationDialog(item: item, selectedDate: _selectedDay),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(FontAwesomeIcons.calendarPlus, size: 72.0, color: scheme.onSurface.withValues(alpha: 0.7)),
                                      const SizedBox(height: 12.0),
                                      Text('예약을 생성하려면\n이곳을 누르세요.',
                                          style: StyleConfigs.bodyNormal.copyWith(color: scheme.onSurface.withValues(alpha: 0.7)),
                                          textAlign: TextAlign.center)
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _getReservation(CalendarEventModel model) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: () {
          defaultBottomSheet(
            context: context,
            showDragHandle: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BottomSheetLinearButton(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('예약정보'),
                  ),
                  if (!model.outboundFlag)
                    BottomSheetLinearButton(
                      onTap: () {
                        Navigator.of(context).pop();
                        CustomDialog.showAlert(
                          context: context,
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.notification_important_outlined,
                                  size: 72.0, color: scheme.outlineVariant.withValues(alpha: 0.5)),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('알림',
                                    style: StyleConfigs.subtitleBold.copyWith(color: scheme.onSurface.withValues(alpha: 0.9))),
                              ),
                            ],
                          ),
                          content: const Text('출고 처리 하시겠습니까?'),
                          actions: [
                            CustomButtonUI(
                              onTap: () => Navigator.of(context).pop(),
                              color: scheme.outline.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              child: Text('취소', style: StyleConfigs.bodyNormal.copyWith(color: scheme.outline)),
                            ),
                            CustomButtonUI(
                              onTap: () => _outbound(widget.itemId, model.id),
                              color: scheme.primary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              child: Text('출고', style: StyleConfigs.bodyNormal.copyWith(color: scheme.primary)),
                            ),
                          ],
                        );
                      },
                      child: const Text('출고'),
                    ),
                  if (model.outboundFlag && model.inboundDate == null)
                    BottomSheetLinearButton(
                      onTap: () {
                        Navigator.of(context).pop();
                        CustomDialog.showAlert(
                          context: context,
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.notification_important_outlined,
                                  size: 72.0, color: scheme.outlineVariant.withValues(alpha: 0.5)),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('알림',
                                    style: StyleConfigs.subtitleBold.copyWith(color: scheme.onSurface.withValues(alpha: 0.9))),
                              ),
                            ],
                          ),
                          content: const Text('입고 처리 하시겠습니까?'),
                          actions: [
                            CustomButtonUI(
                              onTap: () => Navigator.of(context).pop(),
                              color: scheme.outline.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              child: Text('취소', style: StyleConfigs.bodyNormal.copyWith(color: scheme.outline)),
                            ),
                            CustomButtonUI(
                              onTap: () => _inbound(widget.itemId, model.id),
                              color: scheme.primary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              child: Text('입고', style: StyleConfigs.bodyNormal.copyWith(color: scheme.primary)),
                            ),
                          ],
                        );
                      },
                      child: const Text('입고'),
                    ),
                  if (!model.outboundFlag)
                    BottomSheetLinearButton(
                      onTap: () {
                        Navigator.of(context).pop();
                        CustomDialog.showAlert(
                          context: context,
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(Icons.notification_important_outlined,
                                  size: 72.0, color: scheme.outlineVariant.withValues(alpha: 0.5)),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text('알림',
                                    style: StyleConfigs.subtitleBold.copyWith(color: scheme.onSurface.withValues(alpha: 0.9))),
                              ),
                            ],
                          ),
                          content: const Text('예약을 삭제하시겠습니까?'),
                          actions: [
                            CustomButtonUI(
                              onTap: () => Navigator.of(context).pop(),
                              color: scheme.outline.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              child: Text('취소', style: StyleConfigs.bodyNormal.copyWith(color: scheme.outline)),
                            ),
                            CustomButtonUI(
                              onTap: () => _cancel(widget.itemId, model.id),
                              color: scheme.primary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(6.0),
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                              child: Text('삭제', style: StyleConfigs.bodyNormal.copyWith(color: scheme.primary)),
                            ),
                          ],
                        );
                      },
                      child: const Text('예약취소'),
                    ),
                ],
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(6.0),
        child: Ink(
          decoration: BoxDecoration(
            color: scheme.surface,
            border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(6.0),
            boxShadow: const [
              BoxShadow(color: Color.fromRGBO(50, 50, 93, 0.25), offset: Offset(0, 6), blurRadius: 4.5, spreadRadius: -2.0),
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.3), offset: Offset(0, 6), blurRadius: 4.0, spreadRadius: -8.0),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                SizedBox(width: 70.0,child: Center(child: Text(DateFormat(DateFormat.HOUR24_MINUTE, 'ko_KR').format(model.reservedDate)))),
                VerticalDivider(color: scheme.onSurface.withValues(alpha: 0.8), width: 0.0, thickness: 2.0),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person_outline_rounded, size: 14.0),
                            const SizedBox(width: 12.0),
                            Text(model.username, style: StyleConfigs.bodyMed),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.local_phone_rounded, size: 14.0, color: scheme.outline),
                            const SizedBox(width: 12.0),
                            Text(
                              model.contact,
                              style: StyleConfigs.captionNormal.copyWith(color: scheme.outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: !model.outboundFlag
                        ? Text('예약중', style: StyleConfigs.bodyMed.copyWith(color: Colors.deepOrange))
                        : model.inboundDate != null
                            ? Text('입고 완료', style: StyleConfigs.bodyMed.copyWith(color: Colors.green))
                            : Text('출고 완료', style: StyleConfigs.bodyMed.copyWith(color: Colors.blueGrey)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
