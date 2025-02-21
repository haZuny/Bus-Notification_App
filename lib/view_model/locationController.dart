import 'package:bus_notification/model/locationModel.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  Rx<LocationModel> locationModel = LocationModel().obs;
  Location location = new Location(); // 현재 위치 정보를 얻기 위한 객체(native)

  // 현재 위치로 설정
  Future<void> setCuerrentLocation() async {
    // 위치 사용 가능 여부 체크 요청
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }

    // 권한 체크 및 요청
    if (await location.hasPermission() == PermissionStatus.denied) {
      if (await location.requestPermission() != PermissionStatus.granted) {
        return;
      }
    }

    var _locationData = await location.getLocation();

    if (_locationData.longitude != null && _locationData.latitude != null) {
      locationModel.value.latitude = _locationData.latitude!;
      locationModel.value.longitude = _locationData.longitude!;
    } else {
      print('[LOG] Could not load location data');
    }
  }

  // 특정 위치로 설정
  void setLocation(double lat, double lon){
    this.locationModel.value.latitude = lat;
    this.locationModel.value.longitude = lon;
  }

  void setDeafaultLevel() {
    locationModel.value.setDefaultLevel();
  }

  LatLng getLatLng() {
    return LatLng(locationModel.value.latitude, locationModel.value.longitude);
  }

  int getLevel() {
    return locationModel.value.level;
  }
}
