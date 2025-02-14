import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:location/location.dart';
import 'package:mockito/mockito.dart';

import 'locationTest.dart';

main(){
  WidgetsFlutterBinding.ensureInitialized();

  test('위치 테스트', () async {

    // Mock 객체 생성
    var mockLocation = MockLocation();

    // 네이티브 메서드를 mock 처리
    when(mockLocation.getLocation()).thenAnswer((_) async => LocationData.fromMap({
      'latitude': 37.7749,
      'longitude': -122.4194,
    }));

    // 테스트 코드
    var location = await mockLocation.getLocation();
    expect(location.latitude, 37.7749);
    expect(location.longitude, -122.4194);

  });
}