import 'package:bus_notification/model/aroundStationModel.dart';
import 'package:bus_notification/model/busInfoModel.dart';
import 'package:bus_notification/view/page/stationInfoPage.dart';
import 'package:bus_notification/view_model/aroundStationController.dart';
import 'package:bus_notification/view_model/busInfoController.dart';
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
  // getX Controller
  LocationController _locationController = LocationController();
  final LoadingController _loadingController = Get.find();
  final AroundStationListController _aroundStationListController = Get.find();
  final BusInfoController _busInfoController = Get.find();

  // about Kakaomap
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
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            // 로딩 상태
            if (snapshot.connectionState == ConnectionState.done) {
              // 초기화 진행 후 FutureBuilder의 setState() 동작이 완료되고 나서, Rx변수 값을 변경
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                _loadingController.setLoadingState(false);
              });
            }
            return Obx(
              () => KakaoMap(
                center: _locationController.getLatLng(),
                currentLevel: _locationController.getLevel(),
                markers: _aroundStationListController.getMarkerList(),

                /// 마커 클릭 이벤트
                onMarkerTap: (markerId, latLng, zoomLevel) async {
                  Get.toNamed('/stationInfoPage',
                      arguments: {'stationId': markerId});
                },
                onMapCreated: ((controller) async {
                  // 맵 컨트롤러 할당
                  _mapController = controller;
                  // 주변 정류장 마커 초기화
                  double lat = _locationController.locationModel.value.latitude;
                  double lng =
                      _locationController.locationModel.value.longitude;
                  _aroundStationListController.setAroundStationList(lat, lng);
                }),

                /// 지도 드래그 이벤트
                onDragChangeCallback: (latLng, zoomLevel, dragType) {
                  // center 위치 추적
                  _locationController.setLocation(
                      latLng.latitude, latLng.longitude);
                },
              ),
            );
          }),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ///
          /// 현재 위치로 이동 버튼
          ///
          FloatingActionButton(
            onPressed: () async {
              _loadingController.setLoadingState(true);
              // 현재 사용자 위치로 이동
              await _locationController.setCuerrentLocation();
              _loadingController.setLoadingState(false);
              _mapController.setCenter(_locationController.getLatLng());
              // 줌 초기화
              _mapController.setLevel(_locationController.getLevel());
              // 주변 정류장 마커 초기화
              double lat = _locationController.locationModel.value.latitude;
              double lng = _locationController.locationModel.value.longitude;
              _aroundStationListController.setAroundStationList(lat, lng);
            },
            backgroundColor: Colors.transparent,
            shape: CircleBorder(),
            elevation: 0,
            child: Icon(
              Icons.gps_fixed,
              size: 50,
              color: Colors.lightGreen,
            ),
            heroTag: 'go_current_location',
          ),

          ///
          /// 주변 정류장 갱신 버튼
          ///
          FloatingActionButton(
            onPressed: () {
              // 주변 정류장 목록 업데이트
              double lat = _locationController.locationModel.value.latitude;
              double lng = _locationController.locationModel.value.longitude;
              _aroundStationListController.setAroundStationList(lat, lng);
            },
            backgroundColor: Colors.transparent,
            shape: CircleBorder(),
            elevation: 0,
            child: Icon(
              Icons.update,
              size: 50,
              color: Colors.lightGreen,
            ),
            heroTag: 'update_around_station_list',
          )
        ],
      ),
    );
  }
}
