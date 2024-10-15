import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/pages/item/add_item_view.dart';
import 'package:bride_house/pages/item/history_view.dart';
import 'package:bride_house/pages/item/widget/item_ui.dart';
import 'package:bride_house/widget/formed_widget_component.dart';
import 'package:bride_house/widget/search_input_field/search_input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemView extends StatefulWidget {
  const ItemView({super.key});

  @override
  State<ItemView> createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;

  Future<void> _onSummit(String value) async {}

  void _onRemove() {}

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('상품'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => AddItemView())),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormedWidgetComponent(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            prefixText: '식별코드',
            title: SearchInputField(
              controller: _textEditingController,
              focusNode: _focusNode,
              hintText: '이 곳에 식별코드 입력',
              onSummit: _onSummit,
              onRemove: _onRemove,
            ),
            suffix: Row(
              children: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.search_rounded)),
                IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.barcode)),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return const Column(
                    children: [
                      ItemUI(),
                      SizedBox(height: 8.0),
                      Expanded(child: HistoryView()),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  Widget _popupButton({required String text}) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {},
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        child: Ink(
          width: 75.0,
          decoration: BoxDecoration(
            color: scheme.outline.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Expanded(child: Text(text, style: StyleConfigs.captionNormal, textAlign: TextAlign.center)),
                const Icon(Icons.arrow_drop_down, size: 14.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
