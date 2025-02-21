import 'dart:io';

import 'package:bus_notification/app_config.dart';
import 'package:bus_notification/model/busInfoModel.dart';
import 'package:bus_notification/view/page/stationInfoPage.dart';
import 'package:bus_notification/view/widgets/loading.dart';
import 'package:bus_notification/view_model/aroundStationController.dart';
import 'package:bus_notification/view_model/busInfoController.dart';
import 'package:bus_notification/view_model/loadingController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'view/page/mappage.dart';
import 'package:get/get.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  AuthRepository.initialize(
      appKey: dotenv.env[VARNAME_KAKAOMAPKEY] ?? ''); // kakaomap 연동

  // getX 로딩 컨트롤러 주입
  await Get.put(LoadingController(true));
  await Get.put(AroundStationListController());
  await Get.put(BusInfoController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // loading 컨트롤러
    final LoadingController _loadingController = Get.find();

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/map',
      getPages: [
        GetPage(name: '/map', page: () => MapPage(), transition: Transition.fadeIn),
        GetPage(name: '/stationInfoPage', page: () => StationInfoPage(), transition: Transition.fadeIn),
      ],
      builder: (context, child) => Stack(
        children: [
          child!,
          // 로딩 상태에 따라 loading indicator 가 보여질지 결정
          Obx(() => Visibility(
              visible: _loadingController.state.value, child: Loading())),
        ],
      ),

      // home:
    );
  }
}
