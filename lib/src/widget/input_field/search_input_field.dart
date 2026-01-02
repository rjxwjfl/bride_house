import 'package:bride_house/configs/style_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchInputField extends StatefulWidget {
  const SearchInputField(
      {required this.controller,
      required this.focusNode,
      required this.hintText,
      required this.onSummit,
      required this.onRemove,
        this.onChanged,
        this.type,
      super.key});

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final void Function(String) onSummit;
  final void Function() onRemove;
  final TextInputType? type;
  final void Function(String)? onChanged;

  @override
  State<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
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
    return SizedBox(
      height: 36.0,
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        maxLines: 1,
        style: StyleConfigs.bodyNormal,
        onTapOutside: (event) => widget.focusNode.unfocus(),
        onFieldSubmitted: widget.onSummit,
        onChanged: widget.onChanged,
        keyboardType: widget.type ?? TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: scheme.outlineVariant.withOpacity(0.2),
          hintText: widget.hintText,
          hintStyle: StyleConfigs.bodyNormal.copyWith(color: scheme.outline),
          contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
          suffixIcon: widget.controller.value.text.isNotEmpty
              ? InkWell(
                  onTap: widget.onRemove,
                  child: const Icon(
                    CupertinoIcons.xmark,
                    size: 14.0,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
