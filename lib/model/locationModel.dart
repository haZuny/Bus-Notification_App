import 'package:location/location.dart';

class LocationModel{
  Location location = new Location();

  double? latitude;
  double? longitude;

  void setCuerrentLocation() async{

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
    this.latitude = _locationData.latitude;
    this.longitude = _locationData.longitude;
  }



}