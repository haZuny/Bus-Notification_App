import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './../../lib/model/aroundStationList.dart';

void main() async {
  await dotenv.load();
  var aroundStationList = AroundStationList();
  
  test('gogog', (){
    aroundStationList.getAroundStation(37.3380538, 127.1013632);
  });
}