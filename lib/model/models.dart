import '../model/device_model.dart';

class AppState {
  final Device device;

  AppState({this.device});

  AppState.initialState()
    : device = Device();
    //TODO: Add models here before ;

}