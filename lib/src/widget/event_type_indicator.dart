import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/model/event_type_model.dart';
import 'package:flutter/material.dart';

class EventTypeIndicator extends StatelessWidget {
  const EventTypeIndicator({required this.eventType, this.style, super.key});

  final int eventType;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    EventTypeModel model = eventTypeList.firstWhere((e) => e.id == eventType);
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
          color: eventTypeColors[eventType]!.withOpacity(0.2),
          border: Border.all(color: eventTypeColors[eventType]!.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(model.eventType, style: style ?? StyleConfigs.captionMed.copyWith(color: eventTypeColors[eventType]!)),
      ),
    );
  }
}
