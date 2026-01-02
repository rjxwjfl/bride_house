import 'package:bride_house/configs/style_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberInputField extends StatefulWidget {
  const PhoneNumberInputField(
      {required this.controller,
      required this.focusNode,
      required this.hintText,
      required this.onSummit,
      required this.onRemove,
      this.type,
      super.key});

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final void Function(String) onSummit;
  final void Function() onRemove;
  final TextInputType? type;

  @override
  State<PhoneNumberInputField> createState() => _PhoneNumberInputFieldState();
}

class _PhoneNumberInputFieldState extends State<PhoneNumberInputField> {
  void _updateSuffixIcon() {
    setState(() {});
  }

  @override
  void initState() {
    widget.controller.addListener(_updateSuffixIcon);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateSuffixIcon);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      maxLines: 1,
      style: StyleConfigs.bodyNormal,
      onTapOutside: (event) => widget.focusNode.unfocus(),
      onFieldSubmitted: widget.onSummit,
      keyboardType: widget.type ?? TextInputType.text,
      inputFormatters: [PhoneNumberFormatter()],
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: scheme.outlineVariant.withOpacity(0.3),
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 12.0),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
        suffixIcon: widget.controller.value.text.isNotEmpty
            ? IconButton(
                onPressed: widget.onRemove,
                icon: const Icon(
                  CupertinoIcons.xmark,
                  size: 14.0,
                ),
              )
            : null,
      ),
    );
  }
}

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // 숫자가 없는 경우 빈 문자열 반환
    if (digitsOnly.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // 숫자를 형식에 맞게 재구성
    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      if (i == 3 || i == 7) buffer.write('-');
      buffer.write(digitsOnly[i]);
    }

    // 새로운 텍스트 및 커서 위치 설정
    final formatted = buffer.toString();
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
