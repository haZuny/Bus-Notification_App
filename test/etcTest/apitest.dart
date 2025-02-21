import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './../../lib/model/aroundStationModel.dart';

void main() async {
  await dotenv.load();
  var aroundStationList = AroundStationListModel();
  
  test('gogog', (){
    aroundStationList.updateAroundStation(37.3380538, 127.1013632);
  });
}