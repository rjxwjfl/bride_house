import 'package:bride_house/configs/style_config.dart';
import 'package:flutter/material.dart';

class FormedWidgetComponent extends StatelessWidget {
  const FormedWidgetComponent(
      {required this.title,
      this.prefix,
      this.prefixText,
      this.suffix,
      this.style,
      this.padding,
      this.spacing,
      this.prefixPadding,
      super.key});

  final Widget title;
  final Widget? prefix;
  final String? prefixText;
  final Widget? suffix;
  final TextStyle? style;
  final EdgeInsets? padding;
  final double? spacing;
  final double? prefixPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(0.0),
      child: Row(
        children: [
          if (prefix != null) Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: SizedBox(width: 24.0, height: 48.0, child: prefix),
          ),
          if (prefixText != null)
            SizedBox(
              width: spacing,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: prefixPadding ?? 0.0),
                child: Text(prefixText!, style: StyleConfigs.leadMed),
              ),
            ),
          const SizedBox(width: 12.0),
          Expanded(child: title),
          SizedBox(child: suffix)
        ],
      ),
    );
  }
}
