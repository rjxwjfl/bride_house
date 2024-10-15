import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/util/formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemUI extends StatelessWidget {
  const ItemUI({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> list = [110000, 120000, 230000, 86700];
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 16.0),
      child: Row(
        children: [
          const Placeholder(fallbackWidth: 120.0, fallbackHeight: 180.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: SizedBox(
              height: 180.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _priceIndicator(type: 0, price: list[0], isMatching: true),
                  _priceIndicator(type: 1, price: list[1], isMatching: false),
                  _priceIndicator(type: 2, price: list[2], isMatching: false),
                  _priceIndicator(type: 3, price: list[3], isMatching: false),
                  const Expanded(child: SizedBox()),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){},
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              Icon(Icons.edit_note, color: scheme.outline),
                              Text('메모', style: StyleConfigs.captionNormal)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){},
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Column(
                            children: [
                              const Icon(CupertinoIcons.xmark_circle_fill, color: Colors.redAccent,),
                              Text('예약중', style: StyleConfigs.captionNormal,)
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceIndicator({required int type, required int price, required bool isMatching}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(categoryMap[type]!, style: isMatching ? StyleConfigs.bodyMed : StyleConfigs.bodyNormal),
        Text(
          priceFormat.format(price),
          style: StyleConfigs.captionNormal,
        ),
      ],
    );
  }
}
