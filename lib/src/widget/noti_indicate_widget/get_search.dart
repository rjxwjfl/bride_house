import 'package:bride_house/configs/style_config.dart';
import 'package:flutter/material.dart';

class GetSearch extends StatelessWidget {
  const GetSearch({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.screen_search_desktop_outlined, size: 72.0, color: scheme.outline.withOpacity(0.8)),
          const SizedBox(height: 10.0),
          Text('상품을 검색하세요.', style: StyleConfigs.bodyNormal.copyWith(color: scheme.outline.withOpacity(0.8))),
        ],
      ),
    );
  }
}
