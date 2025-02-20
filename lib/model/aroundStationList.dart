import 'dart:convert';
import 'dart:core';
import 'package:bus_notification/app_config.dart';
import 'package:bus_notification/util/httpUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AroundStationList {
  AroundStationList({this.aroundStationList = const []});

  List<AroundStation> aroundStationList;

  // 주변 정류장으로 데이터 갱신
  void getAroundStation(double lat, double lon) async {
    // 파라미터 세팅
    Map<String, String> params = {
      'serviceKey': dotenv.env[VARNAME_PUBLICAPIKEY] ?? '',
      'format': 'json',
      'x': lon.toString(),
      'y': lat.toString(),
    };

    // full url 세팅
    String url = buildUrlWithParams(URL_GET_AROUND_STATION, params);

    // http 요청 및 결과 저장
    var res = await http.get(Uri.parse(url));
    aroundStationList = [];
    List<dynamic> jsonList = json.decode(res.body)['response']['msgBody']['busStationAroundList'];
    jsonList.forEach((station){
      aroundStationList.add(AroundStation.fromJson(station as Map<String, dynamic>));
    });

    print(this.aroundStationList);

  }

  ///
  /// FACTORY
  ///
  // Json으로 들어온 데이터를 치환
  factory AroundStationList.fromJson(List<dynamic> jsonList) {
    List<AroundStation> resultList = [];

    jsonList.forEach((station) {
      resultList.add(AroundStation.fromJson(station));
    });

    return AroundStationList(aroundStationList: resultList);
  }
}


// 단일 정류장 타입 클래스
class AroundStation {
  // Constructor
  AroundStation(
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


  ///
  /// FACTORY
  ///
  // Json으로 들어온 데이터를 치환
  factory AroundStation.fromJson(Map<String, dynamic> jsonMap) {
    print('jsonMap: '+ jsonMap['centerYn']);
    return AroundStation(
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
