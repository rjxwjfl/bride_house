import 'package:intl/intl.dart';

int stringToInt(String value){
  return int.parse(value);
}

NumberFormat priceFormat = NumberFormat('###,###,###,###');

const categoryMap = {0: '본식', 1: '피로연', 2: '스튜디오', 3: '돌잔치'};

// 목걸이 81, 티아라 82, 브로치 83, 핀 84, 슈즈 85

const typeMap = {

};