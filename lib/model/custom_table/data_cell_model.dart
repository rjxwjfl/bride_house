import 'package:flutter/material.dart';

class DataCellModel {
  Widget child;
  int? flex;
  bool? placeholder = false;
  bool? showEditIcon = false;
  void Function()? onTap;
  void Function()? onLongPress;
  void Function(TapDownDetails)? onTapDown;
  void Function()? onDoubleTap;
  void Function()? onTapCancel;

  DataCellModel({
    required this.child,
    this.flex,
    this.placeholder,
    this.showEditIcon,
    this.onTap,
    this.onLongPress,
    this.onTapDown,
    this.onDoubleTap,
    this.onTapCancel,
  });
}
