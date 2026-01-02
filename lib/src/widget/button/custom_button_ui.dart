import 'package:flutter/material.dart';

class CustomButtonUI extends StatelessWidget {
  const CustomButtonUI(
      {required this.onTap,
      required this.child,
      this.color,
      this.border,
      this.borderColor,
      this.borderRadius,
      this.padding,
      super.key});

  final void Function() onTap;
  final Widget child;
  final Color? color;
  final BoxBorder? border;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(4.0)),
      child: Ink(
        decoration: BoxDecoration(
          color: color ?? scheme.primaryContainer,
          border: border ?? Border.all(color: borderColor ?? Colors.transparent),
          borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          child: child,
        ),
      ),
    );
  }
}
