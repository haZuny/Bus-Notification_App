import 'dart:convert';

import 'package:bus_notification/model/aroundStationList.dart';
import 'package:http/http.dart' as http;

String buildUrlWithParams(String baseUrl, Map<String, String> params) {
  // 기본 URL이 ?로 끝나는지 확인
  String url = baseUrl;

  if (params.isNotEmpty) {
    // 첫 번째 파라미터 추가 시 '?' 붙이고, 그 이후에는 '&'를 붙임
    url += (url.contains('?') ? '&' : '?') + params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }

  return url;
}


// // response 타입을 각 모델 객체로 확장
// extension ExtensionHttpResponse on http.Response{
//   AroundStationList extentionToAroundStationList(){
//     Map<String, dynamic> resData =  json.decode(this.body);
//
//     (resData['response']['msgBody']['busStationAroundList'] as List<dynamic>).forEach((hepp) {
//       print(hepp);
//     });
//
//
//     return AroundStationList();
//   }
// }