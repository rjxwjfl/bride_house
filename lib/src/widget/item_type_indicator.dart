import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/model/item_type_model.dart';
import 'package:flutter/material.dart';

class ItemTypeIndicator extends StatelessWidget {
  const ItemTypeIndicator({required this.itemType, this.style, super.key});

  final int itemType;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    ItemTypeModel model = itemTypeList.firstWhere((e) => e.id == itemType);
    return Container(
      decoration: BoxDecoration(
          color: itemTypeColors[itemType]!.withOpacity(0.2),
        border: Border.all(color: itemTypeColors[itemType]!.withOpacity(0.2),),
          borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(model.itemType, style: style ?? StyleConfigs.captionMed.copyWith(color: itemTypeColors[itemType]!)),
      ),
    );
  }
}
