class Device {
  final String deviceName;

  Device({this.deviceName = ':)'});

  Device copyWith({String deviceName}) {
    return Device(
      deviceName: deviceName ?? this.deviceName,
    );
  }

  Map toJson() => {
    'deviceName': deviceName,
  };

  @override
  String toString() {
    return toJson().toString();
  }
  
}