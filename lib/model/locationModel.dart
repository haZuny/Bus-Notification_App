class LocationModel {
  LocationModel({this.latitude = 0, this.longitude = 0, this.level = _DEFAULT_LEVEL});

  static const int _DEFAULT_LEVEL = 0;

  double latitude;
  double longitude;
  int level;

  void setDefaultLevel(){
    this.level = _DEFAULT_LEVEL;
  }
}
