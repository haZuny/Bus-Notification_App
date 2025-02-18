import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bus_notification/app_config.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container( // 로딩 화면을 가득 채우기 위해 Container 위젯 사용
      child: Center(
        child: SizedBox(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(
            color: INDICATOR_COLOR,
            strokeWidth: 7,
          ),
        ),
      ),
      color: Colors.transparent,
    );
  }
}
