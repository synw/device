import 'package:geopoint/geopoint.dart';
import 'types.dart';

/// A class representing a device
class Device {
  /// Main constructor
  Device(
      {this.id,
      this.uniqueId,
      this.groupId,
      this.name,
      this.position,
      this.batteryLevel,
      this.isActive,
      this.isDisabled,
      this.keepAlive = const Duration(minutes: 1),
      this.sleepingTimeout = const Duration(minutes: 10),
      this.properties = const <String, dynamic>{}});

  /// The device id
  int id;

  /// The on device unique id
  String uniqueId;

  /// The group of the device
  int groupId;

  /// The device name
  String name;

  /// The device position
  GeoPoint position;

  /// The device battery level
  double batteryLevel;

  /// The device can be disabled
  bool isDisabled;

  /// false if the device has never updated one position
  bool isActive;

  /// Duration a device is considered alive
  Duration keepAlive;

  /// Duration a device is considered disconnected
  Duration sleepingTimeout;

  /// Extra properties for the device
  Map<String, dynamic> properties;

  /// The network status of the device
  DeviceNetworkStatus get networkStatus => _networkStatus();

  /// Is the device online
  bool get isAlive => _networkStatus() == DeviceNetworkStatus.online;

  /// Is the device sleeping
  bool get isSleeping => _networkStatus() == DeviceNetworkStatus.sleeping;

  /// Is the device offline
  bool get isOffline => _networkStatus() == DeviceNetworkStatus.offline;

  /// Has the device been seen on the network
  bool get isUnknown => _networkStatus() == DeviceNetworkStatus.unknown;

  /// The speed of the device in meters per second
  double get speed => position?.speed ?? 0;

  /// The speed of the device in kilometers per hour
  double get speedKmh => (3.6 * position?.speed) ?? 0;

  /// The last known position date
  DateTime get lastPosition =>
      DateTime.fromMillisecondsSinceEpoch(position.timestamp);

  DeviceNetworkStatus _networkStatus() {
    if (position == null) {
      return DeviceNetworkStatus.unknown;
    }
    DeviceNetworkStatus s;
    final now = DateTime.now();
    final dateAlive = now.subtract(keepAlive);
    final dateSleeping = now.subtract(sleepingTimeout);
    if (lastPosition.isAfter(dateAlive)) {
      s = DeviceNetworkStatus.online;
    } else {
      if (lastPosition.isAfter(dateSleeping)) {
        s = DeviceNetworkStatus.sleeping;
      }
    }
    return s;
  }

  /// Print a description of the device
  void describe() {
    print("Device:");
    print(" - id : $id");
    print(" - uniqueId : $uniqueId");
    print(" - name : $name");
    print(" - batteryLevel: $batteryLevel");
    print(" - position : $position");
  }

  @override
  String toString() {
    String _name;
    if (name != null) {
      _name = name;
    }
    if (name == null && uniqueId != null) {
      _name = "$uniqueId";
    }
    String res;
    if (position != null) {
      res = "$_name: $position";
    } else {
      res = "$_name";
    }
    return "$id: $res";
  }
}
