import 'dart:convert';
import 'dart:core';
import 'package:bus_notification/app_config.dart';
import 'package:bus_notification/util/httpUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';


// 단일 정류장 타입 클래스
class AroundStationModel {
  // Constructor
  AroundStationModel(
      {this.centerYn = "",
      this.mobileNo = "",
      this.regionName = "",
      this.stationId = "",
      this.stationName = "",
      this.x = 0,
      this.y = 0,
      this.distance = 0});

  // field
  String centerYn;
  String mobileNo;
  String regionName;
  String stationId;
  String stationName;
  double x;
  double y;
  int distance;


  LatLng getLatLgn(){
    return LatLng(this.y, this.x);
  }


  ///
  /// FACTORY
  ///
  // Json으로 들어온 데이터를 치환
  factory AroundStationModel.fromJson(Map<String, dynamic> jsonMap) {
    return AroundStationModel(
        centerYn: jsonMap['centerYn'],
        mobileNo: jsonMap['mobileNo'],
        regionName: jsonMap['regionName'],
        stationId: jsonMap['stationId'].toString(),
        stationName: jsonMap['stationName'],
        x: jsonMap['x'],
        y: jsonMap['y'],
        distance: jsonMap['distance']);
  }
}
