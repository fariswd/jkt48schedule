import 'package:redux/redux.dart';

import '../model/device_model.dart';
import '../action/device_action.dart';

Reducer<Device> deviceReducer = combineReducers<Device>([
  TypedReducer<Device, SetDeviceAction>(setName),
  //TODO: Add reducer here
]);

Device setName(Device device, SetDeviceAction action) {
  return device.copyWith(deviceName: action.deviceName);
}