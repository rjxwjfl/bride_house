import 'package:bride_house/configs/style_config.dart';
import 'package:flutter/material.dart';

class MenuComponent extends StatelessWidget {
  const MenuComponent({required this.title, this.prefixText, this.suffix, this.style, this.padding, this.spacing, super.key});

  final Widget title;
  final String? prefixText;
  final Widget? suffix;
  final TextStyle? style;
  final EdgeInsets? padding;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Row(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minWidth: spacing ?? 80.0, maxWidth: spacing ?? 80.0),
            child: Text(prefixText!, style: StyleConfigs.bodyNormal),
          ),
          Expanded(child: title),
          SizedBox(child: suffix)
        ],
      ),
    );
  }
}
