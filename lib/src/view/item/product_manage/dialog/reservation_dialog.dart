import 'dart:io';

import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/model/item/item_model.dart';
import 'package:bride_house/main.dart';
import 'package:bride_house/model/event_type_model.dart';
import 'package:bride_house/model/item_reservation_model.dart';
import 'package:bride_house/src/widget/button/custom_button_ui.dart';
import 'package:bride_house/src/widget/input_field/default_input_field.dart';
import 'package:bride_house/src/widget/input_field/phone_number_input_field.dart';
import 'package:bride_house/src/widget/snackbar/notification_snackbar.dart';
import 'package:bride_house/util/formatter.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReservationDialog extends StatefulWidget {
  const ReservationDialog({required this.item, required this.selectedDate, super.key});

  final ItemModel item;
  final DateTime selectedDate;

  @override
  State<ReservationDialog> createState() => _ReservationDialogState();
}

class _ReservationDialogState extends State<ReservationDialog> {
  late final TextEditingController _contactEditor;
  late final TextEditingController _nameEditor;
  late final TextEditingController _priceEditor;
  late final FocusNode _contactFocus;
  late final FocusNode _nameFocus;
  late final FocusNode _priceFocus;
  late DateTime _selectedDate;
  int? _selectedEvent;
  int? _price;
  String? _username;
  String? _contact;

  void _init() {
    _contactEditor = TextEditingController();
    _nameEditor = TextEditingController();
    _priceEditor = TextEditingController();
    _contactFocus = FocusNode();
    _nameFocus = FocusNode();
    _priceFocus = FocusNode();
    _selectedDate = widget.selectedDate;
  }

  String _formatting(String number) {
    if (number.length == 11) {
      return '${number.substring(0, 3)}-${number.substring(3, 7)}-${number.substring(7)}';
    }
    return number; // 기본값 또는 오류 처리
  }

  bool _validate() {
    NotificationSnackBar snackBar = NotificationSnackBar(context);
    if (_username == null) {
      snackBar.alert(text: '고객명을 입력하세요.');
      return false;
    }
    if (_contact == null) {
      snackBar.alert(text: '연락처를 입력하세요.');
      return false;
    }
    if (_selectedEvent == null) {
      snackBar.alert(text: '유형을 선택하세요.');
      return false;
    }

    return true;
  }

  Future<void> _submit() async {
    if (!_validate()) {
      return;
    }
    ItemReservationModel model = ItemReservationModel(
      id: widget.item.id,
      username: _username!,
      contact: _contact!,
      eventType: _selectedEvent!,
      price: _price ?? 0,
      reservedDate: _selectedDate,
    );

    await pmBloc.addReservation(model);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  Future<void> _selectDateAndTime() async {
    if (!mounted) return;

    TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 0, minute: 0),
    );

    if (time != null && mounted) {
      setState(() {
        _selectedDate = _selectedDate.copyWith(hour: time.hour, minute: time.minute);
      });
    }
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _contactEditor.dispose();
    _nameEditor.dispose();
    _priceEditor.dispose();
    _contactFocus.dispose();
    _nameFocus.dispose();
    _priceFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(Icons.add_box_outlined, size: 48.0, color: scheme.outlineVariant.withOpacity(0.5)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('예약관리', style: StyleConfigs.subtitleBold.copyWith(color: scheme.onSurface.withOpacity(0.9))),
                  ),
                ],
              ),
            ),
            Divider(height: 0.0, color: scheme.outline.withOpacity(0.2)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 35.0,
                      child: Row(
                        children: [
                          const Expanded(child: Text('고객명')),
                          SizedBox(
                            width: 180.0,
                            child: DefaultInputField(
                              controller: _nameEditor,
                              focusNode: _nameFocus,
                              hintText: '고객명 입력',
                              onSummit: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    _username = value.trim();
                                  });
                                }
                              },
                              onRemove: () {
                                _nameEditor.clear();
                                setState(() {
                                  _username = null;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 35.0,
                      child: Row(
                        children: [
                          const Expanded(child: Text('연락처')),
                          SizedBox(
                            width: 180.0,
                            child: DefaultInputField(
                              controller: _contactEditor,
                              focusNode: _contactFocus,
                              hintText: '000-0000-0000',
                              inputFormatter: [PhoneNumberFormatter()],
                              inputType: TextInputType.phone,
                              onSummit: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    _contact = value.trim();
                                  });
                                }
                              },
                              onRemove: () {
                                _contactEditor.clear();
                                setState(() {
                                  _contact = null;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Expanded(child: Text('유형')),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<int>(
                            value: _selectedEvent,
                            hint: Text(
                              '유형을 선택하세요.',
                              style: StyleConfigs.bodyNormal.copyWith(color: scheme.outline),
                            ),
                            alignment: Alignment.center,
                            items: eventTypeList
                                .map((e) => DropdownMenuItem(
                                      value: e.id,
                                      child: Text(
                                        e.eventType,
                                        style: StyleConfigs.bodyNormal.copyWith(color: scheme.outline),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (int? value) {
                              setState(() {
                                _selectedEvent = value;
                                if (_selectedEvent == 1) {
                                  _priceEditor.text = widget.item.wPrice.toString();
                                  _price = widget.item.wPrice;
                                } else {
                                  _priceEditor.text = widget.item.dPrice.toString();
                                  _price = widget.item.dPrice;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 35.0,
                      child: Row(
                        children: [
                          const Expanded(child: Text('가격')),
                          SizedBox(
                            width: 180.0,
                            child: DefaultInputField(
                              controller: _priceEditor,
                              focusNode: _priceFocus,
                              hintText: '가격 입력',
                              inputType: TextInputType.number,
                              onSummit: (value) {
                                if (value.isNotEmpty) {
                                  setState(() {
                                    _price = int.parse(value.trim());
                                  });
                                }
                              },
                              onRemove: () {
                                _priceEditor.clear();
                                setState(() {
                                  _price = null;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        const Expanded(child: Text('예약일')),
                        InkWell(
                          onTap: () async => _selectDateAndTime(),
                          borderRadius: BorderRadius.circular(6.0),
                          child: Ink(
                            height: 35.0,
                            width: 180.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.calendar_month_outlined, size: 14.0, color: scheme.primary),
                                const SizedBox(width: 12.0),
                                Text(
                                  DateFormat(DateFormat.HOUR_MINUTE, getLocaleName()).format(_selectedDate),
                                  style: StyleConfigs.bodyMed.copyWith(color: scheme.primary),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(height: 0.0, color: scheme.outline.withOpacity(0.2)),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButtonUI(
                      onTap: () => Navigator.of(context).pop(),
                      color: scheme.outline.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6.0),
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text('취소', style: StyleConfigs.bodyNormal.copyWith(color: scheme.outline)),
                    ),
                    const SizedBox(width: 12.0),
                    CustomButtonUI(
                      onTap: _submit,
                      color: scheme.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6.0),
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text('예약', style: StyleConfigs.bodyNormal.copyWith(color: scheme.primary)),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
