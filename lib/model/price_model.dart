import 'package:bride_house/dto/request/item/price_edit_req_dto.dart';

class PriceModel {
  int itemId;
  int weddingPrice;
  int defaultPrice;

  PriceModel({
    required this.itemId,
    required this.weddingPrice,
    required this.defaultPrice,
  });

  PriceEditReqDto toReq() {
    return PriceEditReqDto(
      itemId: itemId,
      weddingPrice: weddingPrice,
      defaultPrice: defaultPrice,
    );
  }

  factory PriceModel.fromReq(PriceEditReqDto req) {
    return PriceModel(
      itemId: req.itemId,
      weddingPrice: req.weddingPrice,
      defaultPrice: req.defaultPrice,
    );
  }
}
