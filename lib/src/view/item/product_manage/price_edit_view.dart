import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/model/item/item_model.dart';
import 'package:bride_house/main.dart';
import 'package:bride_house/model/price_model.dart';
import 'package:bride_house/src/widget/button/custom_button_ui.dart';
import 'package:bride_house/src/widget/menu_component.dart';
import 'package:bride_house/src/widget/input_field/price_input_field.dart';
import 'package:bride_house/util/formatter.dart';
import 'package:flutter/material.dart';

class PriceEditView extends StatefulWidget {
  const PriceEditView({required this.item, super.key});

  final ItemModel item;

  @override
  State<PriceEditView> createState() => _PriceEditViewState();
}

class _PriceEditViewState extends State<PriceEditView> {
  late final TextEditingController _weddingPriceEditor;
  late final TextEditingController _defaultPriceEditor;
  late final FocusNode _weddingPriceFocus;
  late final FocusNode _defaultPriceFocus;
  late PriceModel _priceModel;

  void _init() {
    _priceModel = PriceModel(
      itemId: widget.item.id,
      weddingPrice: widget.item.wPrice,
      defaultPrice: widget.item.dPrice,
    );
    _weddingPriceEditor = TextEditingController(text: _priceModel.weddingPrice.toString());
    _defaultPriceEditor = TextEditingController(text: _priceModel.defaultPrice.toString());
    _weddingPriceFocus = FocusNode();
    _defaultPriceFocus = FocusNode();
  }

  Future<void> _editPrice() async {
    await itemBloc.editPrice(_priceModel.toReq());
    if (mounted) Navigator.of(context).pop();
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _weddingPriceEditor.dispose();
    _defaultPriceEditor.dispose();
    _weddingPriceFocus.dispose();
    _defaultPriceFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButtonUI(onTap: () => _editPrice(), child: Text('수정', style: StyleConfigs.captionNormal)),
              const SizedBox(width: 8.0),
              CustomButtonUI(
                  onTap: () => Navigator.of(context).pop(),
                  color: scheme.outline.withOpacity(0.1),
                  child: Text('취소', style: StyleConfigs.captionNormal)),
            ],
          ),
        ),
        MenuComponent(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
          prefixText: '본식',
          title: PriceInputField(
            controller: _weddingPriceEditor,
            focusNode: _weddingPriceFocus,
            onSummit: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  _priceModel.weddingPrice = stringToInt(value);
                });
              }
            },
            onRemove: () {
              _weddingPriceEditor.clear();
              setState(() {
                _priceModel.weddingPrice = widget.item.wPrice;
              });
            },
          ),
        ),
        MenuComponent(
          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
          prefixText: '스튜디오',
          title: PriceInputField(
            controller: _defaultPriceEditor,
            focusNode: _defaultPriceFocus,
            onSummit: (value) {
              if (value.isNotEmpty) {
                setState(() {
                  _priceModel.defaultPrice = stringToInt(value);
                });
              }
            },
            onRemove: () {
              _defaultPriceEditor.clear();
              setState(() {
                _priceModel.defaultPrice = widget.item.dPrice;
              });
            },
          ),
        ),
        const SizedBox(height: kToolbarHeight)
      ],
    );
  }
}
