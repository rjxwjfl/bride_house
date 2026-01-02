import 'package:bride_house/model/item/item_model.dart';
import 'package:bride_house/main.dart';
import 'package:bride_house/src/view/item/item_view.dart';
import 'package:bride_house/src/view/item/product_manage/add_item_view.dart';
import 'package:bride_house/src/widget/formed_widget_component.dart';
import 'package:bride_house/src/widget/input_field/search_input_field.dart';
import 'package:bride_house/src/widget/noti_indicate_widget/get_search.dart';
import 'package:bride_house/src/widget/noti_indicate_widget/search_result_not_exist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemSearchView extends StatefulWidget {
  const ItemSearchView({super.key});

  @override
  State<ItemSearchView> createState() => _ItemSearchViewState();
}

class _ItemSearchViewState extends State<ItemSearchView> with AutomaticKeepAliveClientMixin {
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;

  Future<void> _onSummit(String? value) async {
    if (value != null) {
      itemBloc.setItemId(int.parse(value));
    }
  }

  void _onRemove() {
    _textEditingController.clear();
  }

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: FormedWidgetComponent(
          title: SearchInputField(
            controller: _textEditingController,
            focusNode: _focusNode,
            hintText: '식별코드 입력',
            type: TextInputType.number,
            onSummit: _onSummit,
            onRemove: _onRemove,
          ),
          suffix: Row(
            children: [
              IconButton(
                  onPressed: () {
                    if (_textEditingController.text.isNotEmpty) {
                      _onSummit(_textEditingController.value.text);
                    }
                  },
                  icon: const Icon(Icons.search_rounded)),
              IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.barcode)),
            ],
          ),
        ),
      ),
      body: StreamBuilder<ItemModel?>(
        stream: itemBloc.itemStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const GetSearch();
          }

          if (snapshot.hasData && snapshot.data != null) {
            ItemModel item = snapshot.data!;
            return ItemView(itemId: item.id);
          }

          return SearchResultNotExist();
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
