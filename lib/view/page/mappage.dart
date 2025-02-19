import 'package:bus_notification/model/aroundStationList.dart';
import 'package:bus_notification/view_model/loadingController.dart';
import 'package:bus_notification/view_model/locationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bus_notification/view/widgets/appbar.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import '../../model/locationModel.dart';
import 'package:get/get.dart';

class MapPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MapPage();
  }
}

class _MapPage extends State<MapPage> {
  LocationController _locationController = LocationController();
  final LoadingController _loadingController = Get.find();
  late KakaoMapController _mapController;

  Future<void> _initialize() async {
    _loadingController.setLoadingState(true); // 초기 지도 세팅을 진행하는 동안 loading
    _locationController.setDeafaultLevel();
    await _locationController.setCuerrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: FutureBuilder(
          future: _initialize(),
          builder: (context, snapshot) {
            // 초기화가 아직 안됨
            if(snapshot.connectionState == ConnectionState.waiting){
              return Container();
            }
            // 로딩 상태
            if (snapshot.connectionState == ConnectionState.done) {
              // 초기화 진행 후 FutureBuilder의 setState() 동작이 완료되고 나서, Rx변수 값을 변경
              WidgetsBinding.instance.addPostFrameCallback((timeStamp){
                _loadingController.setLoadingState(false);
              });
            }
            return KakaoMap(
              center: _locationController.getLatLng(),
              currentLevel: _locationController.getLevel(),
              onMapCreated: ((controller) async {
                // 맵 컨트롤러 할당
                _mapController = controller;
              }),
              onMapTap: (latLng) {
                print("터치: " + latLng.toString());
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _loadingController.setLoadingState(true);
          print("로딩시작");
          // 현재 사용자 위치로 이동
          await _locationController.setCuerrentLocation();
          _loadingController.setLoadingState(false);
          print("로딩끝");
          _mapController.setCenter(_locationController.getLatLng());
          _mapController.setLevel(_locationController.getLevel());
          
          
          var around = AroundStationList();
          around.getAroundStation(37.33605, 127.1013632);
          
        },
        backgroundColor: Colors.transparent,
        shape: CircleBorder(),
        elevation: 0,
        child: Icon(
          Icons.gps_fixed,
          size: 50,
          color: Colors.lightGreen,
        ),
      ),
    );
  }
}
