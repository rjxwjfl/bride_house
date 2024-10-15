class DetailModel {
  String detailType;
  int detailNo;

  DetailModel({
    required this.detailType,
    required this.detailNo,
  });
}

DetailModel dress = DetailModel(detailType: '드레스', detailNo: 71);
DetailModel necklace = DetailModel(detailType: '목걸이', detailNo: 81);
DetailModel tiara = DetailModel(detailType: '티아라', detailNo: 82);
DetailModel brooch = DetailModel(detailType: '브로치', detailNo: 83);
DetailModel pin = DetailModel(detailType: '핀', detailNo: 84);
DetailModel shoes = DetailModel(detailType: '슈즈', detailNo: 85);