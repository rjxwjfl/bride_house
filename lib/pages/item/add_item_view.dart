import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/model/detail_model.dart';
import 'package:bride_house/model/type_model.dart';
import 'package:bride_house/util/formatter.dart';
import 'package:bride_house/widget/formed_widget_component.dart';
import 'package:bride_house/widget/input_field/price_input_filed.dart';
import 'package:bride_house/widget/menu_component.dart';
import 'package:flutter/material.dart';

class AddItemView extends StatefulWidget {
  const AddItemView({super.key});

  @override
  State<AddItemView> createState() => _AddItemViewState();
}

class _AddItemViewState extends State<AddItemView> {
  late final TextEditingController _wEditor;
  late final TextEditingController _rEditor;
  late final TextEditingController _sEditor;
  late final TextEditingController _bEditor;
  late final FocusNode _wNode;
  late final FocusNode _rNode;
  late final FocusNode _sNode;
  late final FocusNode _bNode;
  TypeModel? _type;
  DetailModel? _detail;
  int? _wPrice;
  int? _rPrice;
  int? _sPrice;
  int? _bPrice;

  @override
  void initState() {
    _wEditor = TextEditingController();
    _rEditor = TextEditingController();
    _sEditor = TextEditingController();
    _bEditor = TextEditingController();
    _wNode = FocusNode();
    _rNode = FocusNode();
    _sNode = FocusNode();
    _bNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('상품 추가'),
        actions: [
          IconButton(
            onPressed: () {
              print(_wPrice);
              print(_rPrice);
              print(_sPrice);
              print(_bPrice);
            },
            icon: const Icon(Icons.check, color: Colors.green),
          ),
        ],
      ),
      body: Column(
        children: [
          FormedWidgetComponent(
            spacing: 85.0,
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            prefixText: '분류',
            title: GridView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 4,
                  mainAxisSpacing: 4.0,
                  mainAxisExtent: 25.0),
              children: [
                _buttonUI(type: wedding),
                _buttonUI(type: reception),
                _buttonUI(type: studio),
                _buttonUI(type: birth),
                _buttonUI(type: concert),
                _buttonUI(type: kids),
                _buttonUI(type: acc),
              ],
            ),
          ),
          if (_type != null && _type!.typeNo == 19)
            FormedWidgetComponent(
              spacing: 85.0,
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              prefixText: '악세서리',
              title: GridView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    childAspectRatio: 4,
                    mainAxisSpacing: 4.0,
                    mainAxisExtent: 25.0),
                children: [
                  _detailButtonUI(detail: necklace),
                  _detailButtonUI(detail: tiara),
                  _detailButtonUI(detail: brooch),
                  _detailButtonUI(detail: pin),
                  _detailButtonUI(detail: shoes),
                ],
              ),
            ),
          FormedWidgetComponent(
            prefixPadding: 12.0,
            spacing: 70.0,
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            prefixText: '가격책정',
            title: Column(
              children: [
                MenuComponent(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  prefixText: '본식',
                  title: PriceInputFiled(
                    controller: _wEditor,
                    focusNode: _wNode,
                    onSummit: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _wPrice = stringToInt(value);
                        });
                      }
                    },
                    onRemove: () {
                      _wEditor.clear();
                      setState(() {
                        _wPrice = null;
                      });
                    },
                  ),
                ),
                MenuComponent(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  prefixText: '피로연',
                  title: PriceInputFiled(
                    controller: _rEditor,
                    focusNode: _rNode,
                    onSummit: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _rPrice = stringToInt(value);
                        });
                      }
                    },
                    onRemove: () {
                      _rEditor.clear();
                      setState(() {
                        _rPrice = null;
                      });
                    },
                  ),
                ),
                MenuComponent(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  prefixText: '스튜디오',
                  title: PriceInputFiled(
                    controller: _sEditor,
                    focusNode: _sNode,
                    onSummit: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _sPrice = stringToInt(value);
                        });
                      }
                    },
                    onRemove: () {
                      _sEditor.clear();
                      setState(() {
                        _sPrice = null;
                      });
                    },
                  ),
                ),
                MenuComponent(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  prefixText: '돌잔치',
                  title: PriceInputFiled(
                    controller: _bEditor,
                    focusNode: _bNode,
                    onSummit: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _bPrice = stringToInt(value);
                        });
                      }
                    },
                    onRemove: () {
                      _bEditor.clear();
                      setState(() {
                        _bPrice = null;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttonUI({required TypeModel type}) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        setState(() {
          _type = type;
          if (_type!.typeNo != 19){
            _detail = null;
          }
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      child: Ink(
        width: 100.0,
        decoration: BoxDecoration(
          color: _type == type ? scheme.primary : scheme.surface,
          border: Border.all(color: scheme.outline),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Center(
            child: Text(type.typeName,
                style:
                    StyleConfigs.captionNormal.copyWith(color: _type == type ? scheme.onPrimary : scheme.onSurface))),
      ),
    );
  }

  Widget _detailButtonUI({required DetailModel detail}) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        setState(() {
          _detail = detail;
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      child: Ink(
        width: 100.0,
        decoration: BoxDecoration(
          color: _detail == detail ? scheme.primary : scheme.surface,
          border: Border.all(color: scheme.outline),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Center(
            child: Text(detail.detailType,
                style:
                    StyleConfigs.captionNormal.copyWith(color: _detail == detail ? scheme.onPrimary : scheme.onSurface))),
      ),
    );
  }
}
