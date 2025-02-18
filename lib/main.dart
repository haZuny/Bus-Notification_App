import 'dart:io';

import 'package:bus_notification/view/widgets/loading.dart';
import 'package:bus_notification/view_model/loadingController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'view/page/mappage.dart';
import 'package:get/get.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  AuthRepository.initialize(appKey: dotenv.env['KAKAOMAP_KEY'] ?? '');

  // getX 로딩 컨트롤러 주입
  await Get.put(LoadingController(true));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // loading 컨트롤러
    final LoadingController _loadingController = Get.find();

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Stack(
          children: [
            MapPage(),
            // 로딩 상태에 따라 loading indicator 가 보여질지 결정
            Obx(() => Visibility(
                visible: _loadingController.state.value,
                child: Loading()))
          ],
        ));
  }
}
