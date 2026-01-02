import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/model/item/item_model.dart';
import 'package:bride_house/dto/response/product_manage/reserve_resp_dto.dart';
import 'package:bride_house/main.dart';
import 'package:bride_house/src/widget/button/custom_button_ui.dart';
import 'package:bride_house/src/widget/dialog/show_alert_dialog.dart';
import 'package:bride_house/src/widget/input_field/default_input_field.dart';
import 'package:bride_house/src/widget/input_field/phone_number_input_field.dart';
import 'package:bride_house/src/widget/none_glow_inkwell.dart';
import 'package:flutter/material.dart';

class OutboundDialog extends StatefulWidget {
  const OutboundDialog({required this.item, super.key});

  final ItemModel item;

  @override
  State<OutboundDialog> createState() => _OutboundDialogState();
}

class _OutboundDialogState extends State<OutboundDialog> {
  late final TextEditingController _contactEditor;
  late final TextEditingController _nameEditor;
  late final FocusNode _contactFocus;
  late final FocusNode _nameFocus;
  int? _selectedType;

  void _init() {
    _contactEditor = TextEditingController();
    _nameEditor = TextEditingController();
    _contactFocus = FocusNode();
    _nameFocus = FocusNode();
  }

  String _formatting(String number) {
    if (number.length == 11) {
      return '${number.substring(0, 3)}-${number.substring(3, 7)}-${number.substring(7)}';
    }
    return number; // 기본값 또는 오류 처리
  }

  Future<void> _getReservation() async {}

  Future<void> _setOutbound() async {}

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _contactEditor.dispose();
    _nameEditor.dispose();
    _contactFocus.dispose();
    _nameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text('출고관리', style: StyleConfigs.titleBold.copyWith(color: scheme.onSurface.withOpacity(0.9))),
            ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: NonGlowInkWell(
            //     onTap: () async {
            //       ReserveRespDto? reserve = await itemBloc.getReserve(widget.item.id);
            //       if (reserve != null) {
            //         setState(() {
            //           _nameEditor.text = reserve.username;
            //           _contactEditor.text = _formatting(reserve.contact.toString());
            //         });
            //       } else {
            //         if (context.mounted) {
            //           CustomDialog.showAlert(
            //             context: context,
            //             title: Text('알림', style: StyleConfigs.titleBold),
            //             content: const Text('예약 데이터가 없습니다.'),
            //             actions: [
            //               CustomButtonUI(
            //                 onTap: () => Navigator.of(context).pop(),
            //                 color: scheme.secondary,
            //                 child: Text(
            //                   '닫기',
            //                   style: StyleConfigs.bodyNormal.copyWith(color: scheme.onSecondary),
            //                 ),
            //               ),
            //             ],
            //           );
            //         }
            //       }
            //     },
            //     child: Padding(
            //       padding: const EdgeInsets.symmetric(vertical: 4.0),
            //       child: Row(
            //         mainAxisSize: MainAxisSize.min,
            //         children: [
            //           Text('예약 데이터 불러오기', style: StyleConfigs.captionNormal.copyWith(color: scheme.outline)),
            //           Icon(Icons.arrow_right, size: 14.0, color: scheme.outline)
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            const SizedBox(height: 12.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SizedBox(
                height: 35.0,
                child: Row(
                  children: [
                    const Expanded(child: Text('고객명')),
                    SizedBox(
                      width: 150.0,
                      child: DefaultInputField(
                        controller: _nameEditor,
                        focusNode: _nameFocus,
                        hintText: '고객명 입력',
                        onSummit: (value) {},
                        onRemove: () {},
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
                      width: 150.0,
                      child: DefaultInputField(
                        controller: _contactEditor,
                        focusNode: _contactFocus,
                        hintText: '000-0000-0000',
                        inputFormatter: [PhoneNumberFormatter()],
                        inputType: TextInputType.phone,
                        onSummit: (value) {},
                        onRemove: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: kToolbarHeight * 0.5),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButtonUI(
                    onTap: () => Navigator.of(context).pop(),
                    color: scheme.outlineVariant,
                    child: const Text('취소'),
                  ),
                  const SizedBox(width: 4.0),
                  CustomButtonUI(
                    onTap: () {},
                    color: scheme.secondary,
                    child: Text(
                      '출고',
                      style: StyleConfigs.bodyNormal.copyWith(color: scheme.onSecondary),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
