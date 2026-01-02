class PriceEditReqDto {
  int itemId;
  int weddingPrice;
  int defaultPrice;

//<editor-fold desc="Data Methods">
  PriceEditReqDto({
    required this.itemId,
    required this.weddingPrice,
    required this.defaultPrice,
  });

  Map<String, dynamic> toMap() {
    return {
      'itemId': itemId,
      'wedding_price': weddingPrice,
      'default_price': defaultPrice,
    };
  }
//</editor-fold>
}