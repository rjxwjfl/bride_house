class TypeModel {
  String typeName;
  int typeNo;

  TypeModel({
    required this.typeName,
    required this.typeNo,
  });
}

TypeModel wedding = TypeModel(typeName: '본식', typeNo: 11);
TypeModel reception = TypeModel(typeName: '피로연', typeNo: 12);
TypeModel studio = TypeModel(typeName: '스튜디오', typeNo: 13);
TypeModel birth = TypeModel(typeName: '돌잔치', typeNo: 14);
TypeModel concert = TypeModel(typeName: '연주회', typeNo: 15);
TypeModel kids = TypeModel(typeName: '아동', typeNo: 16);
TypeModel acc = TypeModel(typeName: '악세서리', typeNo: 19);
