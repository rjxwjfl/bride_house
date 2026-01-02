import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/main.dart';
import 'package:bride_house/model/calendar/reservation_model.dart';
import 'package:bride_house/src/view/schedule/add_schedule_view.dart';
import 'package:bride_house/src/widget/bottom_sheet/bottom_sheet.dart';
import 'package:bride_house/src/widget/bottom_sheet/bottom_sheet_linear_button.dart';
import 'package:bride_house/src/widget/button/custom_button_ui.dart';
import 'package:bride_house/src/widget/dialog/show_alert_dialog.dart';
import 'package:bride_house/src/widget/table_calendar/schedule_calendar.dart';
import 'package:bride_house/util/formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  late Map<DateTime, List<ReservationModel>> _map;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  Future<void> _outbound(int itemId, int historyId) async {
    await pmBloc.setOutbound(itemId, historyId);
    await pmBloc.getResList();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _inbound(int itemId, int historyId) async {
    await pmBloc.setInbound(itemId, historyId);
    await pmBloc.getResList();
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _cancel(int itemId, int historyId) async {
    await pmBloc.cancelReservation(itemId, historyId);
    await pmBloc.getResList();
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
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '${_focusedDay.month}월', style: StyleConfigs.headLineBold.copyWith(color: scheme.onSurface)),
              TextSpan(text: ', ${_focusedDay.year}', style: StyleConfigs.titleBold.copyWith(color: scheme.onSurface))
            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const AddScheduleView())),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: StreamBuilder<List<ReservationModel>>(
        stream: pmBloc.resListStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            pmBloc.getResList();
            return ScheduleCalendar(
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
            );
          }

          _map = calendarScheduleFormer(snapshot.data!);

          DateTime selectDateKey = DateTime(_selectedDay.year, _selectedDay.month, _selectedDay.day);

          List<ReservationModel> event = _map[selectDateKey] ?? [];

          return Column(
            children: [
              ScheduleCalendar(
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
              if (event.isNotEmpty) ListView.separated(
                shrinkWrap: true,
                itemCount: event.length,
                separatorBuilder: (context, index) => Divider(),
                itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _getReservation(1, event[index]),
                    );
                },
              ) else Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('일정 없음', style: StyleConfigs.tableRow),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _getReservation(int itemId, ReservationModel model) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
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
                          // CustomButtonUI(
                          //   onTap: () => _outbound(widget.itemId, model.id),
                          //   color: scheme.primary.withValues(alpha: 0.2),
                          //   borderRadius: BorderRadius.circular(6.0),
                          //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          //   child: Text('출고', style: StyleConfigs.bodyNormal.copyWith(color: scheme.primary)),
                          // ),
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
                          // CustomButtonUI(
                          //   onTap: () => _inbound(widget.itemId, model.id),
                          //   color: scheme.primary.withValues(alpha: 0.2),
                          //   borderRadius: BorderRadius.circular(6.0),
                          //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          //   child: Text('입고', style: StyleConfigs.bodyNormal.copyWith(color: scheme.primary)),
                          // ),
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
                          // CustomButtonUI(
                          //   onTap: () => _cancel(widget.itemId, model.id),
                          //   color: scheme.primary.withValues(alpha: 0.2),
                          //   borderRadius: BorderRadius.circular(6.0),
                          //   padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                          //   child: Text('삭제', style: StyleConfigs.bodyNormal.copyWith(color: scheme.primary)),
                          // ),
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
              SizedBox(
                  width: 70.0,
                  child: Center(child: Text(DateFormat(DateFormat.HOUR24_MINUTE, 'ko_KR').format(model.reservedDate)))),
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
                          Text(model.customer.username, style: StyleConfigs.bodyMed),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.local_phone_rounded, size: 14.0, color: scheme.outline),
                          const SizedBox(width: 12.0),
                          Text(
                            model.customer.contact,
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
    );
  }
}
