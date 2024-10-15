import 'package:bride_house/configs/style_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PriceInputFiled extends StatefulWidget {
  const PriceInputFiled(
      {required this.controller, required this.focusNode, required this.onSummit, required this.onRemove, super.key});

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String) onSummit;
  final void Function() onRemove;

  @override
  State<PriceInputFiled> createState() => _PriceInputFiledState();
}

class _PriceInputFiledState extends State<PriceInputFiled> {
  void _updateSuffixIcon() {
    if (mounted) {
      setState(() {});
    }
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
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onSummit,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.end,
      style: StyleConfigs.bodyNormal,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
          isDense: true,
          filled: false,
          hintText: '가격 입력',
          contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          prefixIcon: const Icon(FontAwesomeIcons.wonSign, size: 10.0),
          suffixIcon: widget.controller.value.text.isNotEmpty
              ? IconButton(
                  onPressed: widget.onRemove,
                  icon: const Icon(
                    CupertinoIcons.xmark,
                    size: 14.0,
                  ),
                )
              : null),
    );
  }
}
