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
      super.key});

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final void Function(String) onSummit;
  final void Function() onRemove;

  @override
  State<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  void _updateSuffixIcon(){
    setState(() {

    });
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
    return SizedBox(
      height: 40.0,
      child: Center(
        child: TextFormField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          maxLines: 1,
          style: StyleConfigs.bodyNormal,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
              isDense: true,
              filled: false,
              hintText: widget.hintText,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                  : null),
        ),
      ),
    );
  }
}
