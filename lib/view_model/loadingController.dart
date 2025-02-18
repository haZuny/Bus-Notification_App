import 'package:get/get.dart';

class LoadingController  extends GetXState{
  LoadingController(bool isLoading){
    this.state = isLoading.obs;
  }

  RxBool state = false.obs;

  // 로딩 상태 설정
  setLoadingState(bool isLoading){
    this.state.value = isLoading;
  }

}