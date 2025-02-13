import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bus_notification/view/widgets/appbar.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MapPage extends StatelessWidget {
  var mapController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: CustomAppBar(),
        body: Container(
          child: KakaoMap(
            onMapCreated: ((controller){
              mapController = controller;
            }),

          ),
          color: Colors.red,
        ));
  }
}
