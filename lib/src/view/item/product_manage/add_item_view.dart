import 'dart:io';

import 'package:bride_house/configs/image_picker_config.dart';
import 'package:bride_house/configs/style_config.dart';
import 'package:bride_house/dto/request/item/item_add_req_dto.dart';
import 'package:bride_house/main.dart';
import 'package:bride_house/model/event_type_model.dart';
import 'package:bride_house/model/item_type_model.dart';
import 'package:bride_house/src/widget/input_field/price_input_field.dart';
import 'package:bride_house/src/widget/menu_component.dart';
import 'package:bride_house/src/widget/snackbar/notification_snackbar.dart';
import 'package:bride_house/util/formatter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddItemView extends StatefulWidget {
  const AddItemView({super.key});

  @override
  State<AddItemView> createState() => _AddItemViewState();
}

class _AddItemViewState extends State<AddItemView> {
  late final TextEditingController _weddingPriceEditor;
  late final TextEditingController _defaultPriceEditor;
  late final FocusNode _weddingPriceFocus;
  late final FocusNode _defaultPriceFocus;
  late final ImagePicker _imagePicker;
  late final ImagePickerConfig _imagePickerConfig;
  late EventTypeModel _eventType;
  late ItemTypeModel _itemType;
  File? _image;
  int? _weddingPrice;
  int? _defaultPrice;

  Future<void> _addItem() async {
    ItemAddReqDto item = ItemAddReqDto(
        eventType: _eventType.id,
        itemType: _itemType.id,
        weddingPrice: _weddingPrice ?? 0,
        defaultPrice: _defaultPrice ?? 0,
        file: _image);

    await itemBloc.addItem(item: item);
    if (!mounted) return;
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _weddingPriceEditor = TextEditingController();
    _defaultPriceEditor = TextEditingController();
    _weddingPriceFocus = FocusNode();
    _defaultPriceFocus = FocusNode();
    _imagePicker = ImagePicker();
    _imagePickerConfig = ImagePickerConfig(_imagePicker);
    _eventType = eventTypeList.firstWhere((e) => e.id == 1);
    _itemType = itemTypeList.firstWhere((e) => e.id == 1);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('상품 추가'),
        actions: [
          IconButton(
            onPressed: () async => await _addItem(),
            icon: const Icon(Icons.check, color: Colors.green),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DottedBorder(
                color: scheme.outlineVariant,
                padding: const EdgeInsets.all(4.0),
                borderType: BorderType.RRect,
                strokeWidth: 2.0,
                radius: const Radius.circular(8.0),
                dashPattern: const [8, 4],
                child: InkWell(
                  onTap: () async {
                    File? file = await _imagePickerConfig.getImage(ImageSource.gallery);
                    if (file != null) {
                      setState(() {
                        _image = file;
                      });
                    }
                  },
                  onLongPress: () {
                    if (_image != null) {
                      setState(() {
                        _image = null;
                      });
                    }
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                  child: SizedBox(
                    width: 144.0,
                    height: 256.0,
                    child: _image != null
                        ? Ink(
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                                image: DecorationImage(image: FileImage(File(_image!.path)), fit: BoxFit.cover)),
                          )
                        : Center(
                            child: Icon(CupertinoIcons.plus_circle, color: scheme.outlineVariant, size: 64.0),
                          ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Text(
                  '분류',
                  style: StyleConfigs.subtitleBold.copyWith(color: scheme.onSurface.withOpacity(0.8)),
                ),
              ),
            ),
            GridView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4.0,
                childAspectRatio: 4,
                mainAxisSpacing: 4.0,
                mainAxisExtent: 35.0,
              ),
              children: eventTypeList.map((e) => _buttonUI(type: e)).toList(),
            ),
            if (_eventType.id == 9)
              Column(
                children: [
                  const SizedBox(height: 16.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Text(
                        '악세서리 분류',
                        style: StyleConfigs.subtitleBold.copyWith(color: scheme.onSurface.withOpacity(0.8)),
                      ),
                    ),
                  ),
                  GridView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 4,
                      mainAxisSpacing: 4.0,
                      mainAxisExtent: 35.0,
                    ),
                    children: itemTypeList.where((e) => !(e.id == 1 || e.id == 2)).map((e) => _subCategoryButtonUI(detail: e)).toList(),
                  ),
                ],
              ),
            Column(
              children: [
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      '가격 책정',
                      style: StyleConfigs.subtitleBold.copyWith(color: scheme.onSurface.withOpacity(0.8)),
                    ),
                  ),
                ),
                MenuComponent(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  prefixText: '본식',
                  title: PriceInputField(
                    controller: _weddingPriceEditor,
                    focusNode: _weddingPriceFocus,
                    onSummit: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _weddingPrice = stringToInt(value);
                        });
                      }
                    },
                    onRemove: () {
                      _weddingPriceEditor.clear();
                      setState(() {
                        _weddingPrice = null;
                      });
                    },
                    onEditingCompleted: () => FocusScope.of(context).requestFocus(_defaultPriceFocus),
                  ),
                ),
                MenuComponent(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  prefixText: '일반',
                  title: PriceInputField(
                    controller: _defaultPriceEditor,
                    focusNode: _defaultPriceFocus,
                    onSummit: (value) {
                      if (value.isNotEmpty) {
                        setState(() {
                          _defaultPrice = stringToInt(value);
                        });
                      }
                    },
                    onRemove: () {
                      _defaultPriceEditor.clear();
                      setState(() {
                        _defaultPrice = null;
                      });
                    },
                    onEditingCompleted: () => FocusScope.of(context).requestFocus(_defaultPriceFocus),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, right: 16.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('* 가격이 지정되지 않은 경우 0원으로 처리', style: StyleConfigs.captionNormal.copyWith(color: scheme.outline)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonUI({required EventTypeModel type}) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        setState(() {
          _eventType = type;
          // ItemType 논리 적용
          if ([1, 2, 3, 4, 5].contains(_eventType.id)) {
            // 드레스 (id: 1)만 허용
            _itemType = itemTypeList.firstWhere((item) => item.id == 1);
          } else if (_eventType.id == 6) {
            // 아동복 (id: 2)만 허용
            _itemType = itemTypeList.firstWhere((item) => item.id == 2);
          } else if (_eventType.id == 9) {
            // 악세서리 허용된 타입 중 첫 번째 (id: 3~7) 설정
            _itemType = itemTypeList.firstWhere((item) =>
                [3, 4, 5, 6, 7].contains(item.id));
          } else {
            // 기본값 설정 (필요한 경우 작성)
            _itemType = itemTypeList.first;
          }
        });
        print(_eventType.eventType);
        print(_itemType.itemType);
      },
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      child: Ink(
        width: 100.0,
        decoration: BoxDecoration(
          color: _eventType == type ? scheme.primary : scheme.surface,
          border: Border.all(color: scheme.outline),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Center(
          child: Text(
            type.eventType,
            style: StyleConfigs.captionNormal.copyWith(color: _eventType == type ? scheme.onPrimary : scheme.onSurface),
          ),
        ),
      ),
    );
  }

  Widget _subCategoryButtonUI({required ItemTypeModel detail}) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: () {
        setState(() {
          _itemType = detail;
        });
      },
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      child: Ink(
        width: 100.0,
        decoration: BoxDecoration(
          color: _itemType == detail ? scheme.primary : scheme.surface,
          border: Border.all(color: scheme.outline),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
        ),
        child: Center(
          child: Text(
            detail.itemType,
            style: StyleConfigs.captionNormal.copyWith(color: _itemType == detail ? scheme.onPrimary : scheme.onSurface),
          ),
        ),
      ),
    );
  }
}
