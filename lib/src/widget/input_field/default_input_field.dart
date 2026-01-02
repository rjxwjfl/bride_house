import 'package:bride_house/configs/style_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultInputField extends StatefulWidget {
  const DefaultInputField(
      {this.enabled,required this.controller,
      required this.focusNode,
      this.inputType,
      this.hintText,
      this.maxLength,
      this.inputFormatter,
      required this.onSummit,
      required this.onRemove,
      super.key});

  final bool? enabled;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType? inputType;
  final String? hintText;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatter;
  final void Function(String) onSummit;
  final void Function() onRemove;

  @override
  State<DefaultInputField> createState() => _DefaultInputFieldState();
}

class _DefaultInputFieldState extends State<DefaultInputField> {
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
      enabled: widget.enabled ?? true,
      controller: widget.controller,
      focusNode: widget.focusNode,
      maxLines: 1,
      maxLength: widget.maxLength,
      onChanged: widget.onSummit,
      keyboardType: widget.inputType ?? TextInputType.text,
      textAlign: TextAlign.center,
      style: StyleConfigs.bodyNormal,
      onTapOutside: (event) => widget.focusNode.unfocus(),
      inputFormatters: widget.inputFormatter,
      buildCounter: (context, {int? currentLength, maxLength, bool? isFocused}) => null,
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        hintText: widget.hintText,
        hintStyle: StyleConfigs.captionNormal.copyWith(color: scheme.outline),
        fillColor: scheme.outlineVariant.withOpacity(0.2),
        contentPadding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 4.0),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(6.0)),
        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(6.0)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(6.0)),
        suffix: widget.controller.value.text.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: InkWell(
                  onTap: widget.onRemove,
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(CupertinoIcons.xmark, size: 12.0),
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
