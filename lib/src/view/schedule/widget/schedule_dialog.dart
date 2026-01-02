import 'dart:io';

import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/util/formatter.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleDialog extends StatelessWidget {
  const ScheduleDialog({required this.date, this.events, super.key});

  final DateTime date;
  final List<CalendarEventData>? events;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '${date.day}', style: StyleConfigs.headLineBold.copyWith(color: scheme.onSurface)),
                    TextSpan(
                        text: '(${DateFormat(DateFormat.ABBR_WEEKDAY, getLocaleName()).format(date)})',
                        style: StyleConfigs.leadMed.copyWith(color: scheme.onSurface)),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
              )
            ],
          ),
        ),
        const Divider(height: 0.0),
        if (events != null || events!.isNotEmpty)
          ListView(
            shrinkWrap: true,
            children: events!.map((e) => Text(e.title)).toList(),
          )
      ],
    );
  }
}
