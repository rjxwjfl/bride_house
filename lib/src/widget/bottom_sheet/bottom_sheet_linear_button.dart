import 'package:flutter/material.dart';

class BottomSheetLinearButton extends StatelessWidget {
  const BottomSheetLinearButton({this.onTap, required this.child, super.key});

  final void Function()? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Center(child: child),
      ),
    );
  }
}
