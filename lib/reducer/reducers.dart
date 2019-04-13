import '../model/models.dart';

import '../reducer/device_reducer.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    device: deviceReducer(state.device, action),
    //TODO: Add reducer here
  );
}