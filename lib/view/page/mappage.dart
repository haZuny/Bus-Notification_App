import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bus_notification/view/widgets/appbar.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import '../../model/locationModel.dart';

class MapPage extends StatelessWidget {
  LocationModel locationModel = LocationModel();
  late KakaoMapController _mapController;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        child: KakaoMap(
          onMapCreated: ((controller) {
            _mapController = controller;
            // 현재 사용자 위치로 이동
            locationModel.setCuerrentLocation();
            _mapController.setCenter(LatLng(locationModel.latitude!, locationModel.longitude!));
          }),
          onMapTap: (latLng) {
            print('터치: ' + latLng.toString());

            LocationModel lm = new LocationModel();
            lm.setCuerrentLocation();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("클클릭릭");
        },
        backgroundColor: Colors.transparent,
        shape: CircleBorder(),
        elevation: 0,
        child: Icon(Icons.gps_fixed, size: 50, color: Colors.lightGreen,),

      ),
    );
  }
}
