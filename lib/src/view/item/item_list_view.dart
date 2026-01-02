import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/model/custom_table/data_row_model.dart';
import 'package:bride_house/model/custom_table/header_model.dart';
import 'package:bride_house/model/item/item_model.dart';
import 'package:bride_house/generated/assets.dart';
import 'package:bride_house/main.dart';
import 'package:bride_house/model/event_type_model.dart';
import 'package:bride_house/model/item_type_model.dart';
import 'package:bride_house/src/view/item/item_view.dart';
import 'package:bride_house/src/view/item/product_manage/add_item_view.dart';
import 'package:bride_house/src/widget/animated_progress_indicator.dart';
import 'package:bride_house/src/widget/bottom_sheet/bottom_sheet.dart';
import 'package:bride_house/src/widget/bottom_sheet/bottom_sheet_linear_button.dart';
import 'package:bride_house/src/widget/custom_table/custom_table.dart';
import 'package:bride_house/src/widget/event_type_indicator.dart';
import 'package:bride_house/src/widget/input_field/search_input_field.dart';
import 'package:bride_house/src/widget/item_type_indicator.dart';
import 'package:bride_house/src/widget/none_glow_inkwell.dart';
import 'package:bride_house/util/formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemListView extends StatefulWidget {
  const ItemListView({super.key});

  @override
  State<ItemListView> createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;
  late final ScrollController _scrollController;
  List<int> _eventType = eventTypeList.map((e) => e.id).toList();
  List<int> _itemType = itemTypeList.map((e) => e.id).toList();
  String? _serialNo;

  Future<void> _onSummit(String? value) async {
    setState(() {
      if (value != null || value!.isEmpty) {
        _serialNo = value;
      } else {
        _serialNo = null;
      }
    });
  }

  void _onRemove() {
    _textEditingController.clear();
    setState(() {
      _serialNo = null;
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        scrolledUnderElevation: 3.0,
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: scheme.surface,
        shadowColor: scheme.shadow,
        title: const Text('전체 상품 조회'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const AddItemView())),
              icon: const Icon(Icons.add))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight * 0.7),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
              ),
              Expanded(
                child: SearchInputField(
                  controller: _textEditingController,
                  focusNode: _focusNode,
                  hintText: '시리얼번호(뒤 네자리) 입력',
                  type: TextInputType.number,
                  onSummit: _onSummit,
                  onChanged: (value) {
                  },
                  onRemove: _onRemove,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (_textEditingController.text.isNotEmpty) {
                    _onSummit(_textEditingController.value.text);
                  }
                },
                icon: const Icon(Icons.search_rounded),
              ),
              IconButton(onPressed: () {}, icon: const Icon(FontAwesomeIcons.barcode)),
            ],
          ),
        ),
      ),
      body: StreamBuilder<List<ItemModel>>(
        stream: itemBloc.listStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            itemBloc.getItemList();
            return const AnimatedProgressIndicator();
          }

          List<ItemModel> init = snapshot.data ?? [];

          if (init.isEmpty) {
            return Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(CupertinoIcons.add_circled, size: 72.0, color: scheme.outline.withValues(alpha: 0.8)),
                const SizedBox(height: 8.0),
                Text('상품을 추가하세요.', style: StyleConfigs.bodyNormal.copyWith(color: scheme.outline.withValues(alpha: 0.8)))
              ],
            ));
          }

          if (_serialNo == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.search, size: 72.0, color: scheme.outline.withValues(alpha: 0.8)),
                  const SizedBox(height: 8.0),
                  Text('상품을 검색하세요.', style: StyleConfigs.bodyNormal.copyWith(color: scheme.outline.withValues(alpha: 0.8))),
                ],
              ),
            );
          }

          List<ItemModel> list = init.where((item) {
            bool eventTypeMatch = _eventType.contains(item.eventType);
            bool itemTypeMatch = _itemType.contains(item.itemType);
            bool serialNoMatch = item.serialNo.toString().contains(_serialNo!);
            return eventTypeMatch && itemTypeMatch && serialNoMatch;
          }).toList();

          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(CupertinoIcons.search, size: 72.0, color: scheme.outline.withValues(alpha: 0.8)),
                  const SizedBox(height: 8.0),
                  Text('검색 결과가 없습니다.', style: StyleConfigs.bodyNormal.copyWith(color: scheme.outline.withValues(alpha: 0.8))),
                ],
              ),
            );
          }

          return Scrollbar(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: list.length,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              // TODO :: 적응형 필요
              itemBuilder: (context, index) {
                ItemModel item = list[index];
                return Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(50, 50, 93, 0.25),
                          offset: Offset(0, 6),
                          blurRadius: 4.5,
                          spreadRadius: -2.0),
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.3),
                          offset: Offset(0, 6),
                          blurRadius: 4.0,
                          spreadRadius: -8.0),
                    ],
                  ),
                  child: NonGlowInkWell(
                    onTap: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => ItemView(itemId: item.id))),
                    child: SizedBox(
                      height: size.height * 0.4,
                      child: Row(
                        children: [
                          Container(
                            width: size.width * 0.4,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: scheme.surface,
                              image: item.thumbnail != null
                                  ? DecorationImage(
                                image: NetworkImage(item.thumbnail!),
                                fit: BoxFit.fitHeight,
                              )
                                  : item.image != null ? DecorationImage(
                                image: NetworkImage(item.image!),
                                fit: BoxFit.fitHeight,
                              ): const DecorationImage(image: AssetImage(Assets.imagesNoImageIcon), fit: BoxFit.fitWidth),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Text(
                                          '${item.eventType}${item.itemType}${item.serialNo.toString().padLeft(4, '0')}',
                                          style: StyleConfigs.extraTitleBold,
                                        ),
                                        const SizedBox(height: 4.0),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            EventTypeIndicator(
                                              eventType: item.eventType,
                                              style: StyleConfigs.captionMed.copyWith(color: scheme.primary),
                                            ),
                                            const SizedBox(width: 4.0),
                                            ItemTypeIndicator(
                                              itemType: item.itemType,
                                              style: StyleConfigs.captionMed.copyWith(color: scheme.secondary),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: stateIndicator(state: item.state),
                                        ),
                                      ],
                                    ),
                                  ),
                                  CustomTable(
                                    headers: [
                                      HeaderModel(title: '유형'),
                                      HeaderModel(title: '가격', flex: 2),
                                    ],
                                    rows: [
                                      priceDataRow(title: '본식', price: item.wPrice),
                                      priceDataRow(title: '일반', price: item.dPrice),
                                    ],
                                    headerColor: scheme.secondaryContainer.withValues(alpha: 0.5),
                                    headerTextStyle: StyleConfigs.bodyBold,
                                    rowTextStyle: StyleConfigs.captionNormal.copyWith(color: scheme.outline),
                                    boxDecoration: BoxDecoration(
                                      color: scheme.surface,
                                      border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.4)),
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
