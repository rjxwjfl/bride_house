import 'package:bride_house/configs/style_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PriceInputField extends StatefulWidget {
  const PriceInputField(
      {required this.controller, required this.focusNode, required this.onSummit, required this.onRemove, this.onEditingCompleted, super.key});

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String) onSummit;
  final void Function() onRemove;
  final void Function()? onEditingCompleted;

  @override
  State<PriceInputField> createState() => _PriceInputFieldState();
}

class _PriceInputFieldState extends State<PriceInputField> {
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
    ColorScheme scheme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      maxLines: 1,
      onChanged: widget.onSummit,
      onEditingComplete: widget.onEditingCompleted,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.end,
      style: StyleConfigs.bodyNormal,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onTapOutside: (event) => widget.focusNode.unfocus(),
      decoration: InputDecoration(
          isDense: true,
          filled: false,
          hintText: '가격 입력',
          contentPadding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 12.0),
          enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: scheme.outlineVariant)),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: scheme.tertiary)),
          prefix: const Icon(FontAwesomeIcons.wonSign, size: 10.0),
          suffix: widget.controller.value.text.isNotEmpty
              ? InkWell(
                  onTap: widget.onRemove,
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      CupertinoIcons.xmark,
                      size: 12.0,
                    ),
                  ),
                )
              : null),
    );
  }
}
