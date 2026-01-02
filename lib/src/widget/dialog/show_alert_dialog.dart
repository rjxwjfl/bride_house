import 'package:flutter/material.dart';

class CustomDialog {
  CustomDialog._();

  static void showDefault({required BuildContext context, required Widget child}) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: child,
      ),
    );
  }

  static void showAlert({required BuildContext context, required Widget title, required Widget content, List<Widget>? actions}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
        ),
        elevation: 10.0,
        title: title,
        titlePadding: EdgeInsets.all(16.0),
        content: content,
        actions: actions,
        actionsPadding: EdgeInsets.all(16.0),
        actionsAlignment: MainAxisAlignment.end,
      ),
    );
  }
}
