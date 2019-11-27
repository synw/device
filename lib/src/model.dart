import 'package:geopoint/geopoint.dart';
import 'package:geodf/geodf.dart';
import 'types.dart';

/// A class representing a device
class Device {
  /// Main constructor
  Device(
      {
      // data properties
      this.id,
      this.uniqueId,
      this.groupId,
      this.name,
      this.position,
      this.batteryLevel,
      this.df,
      this.properties,
      // state properties
      this.isVisible = true,
      this.isDisabled = false,
      this.keepAlive = const Duration(minutes: 1),
      this.sleepingTimeout = const Duration(minutes: 10),
      this.isFollowed = false,
      this.isTraced = false}) {
    properties ??= <String, dynamic>{};
  }

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

  /// Visibility of the device
  bool isVisible;

  /// Duration a device is considered alive
  Duration keepAlive;

  /// Duration a device is considered disconnected
  Duration sleepingTimeout;

  /// A geodataframe attached to the device object
  GeoDataFrame df;

  /// Extra properties for the device
  Map<String, dynamic> properties;

  /// Is the device followed
  bool isFollowed;

  /// Is the device traced
  bool isTraced;

  /// The network status of the device
  DeviceNetworkStatus get networkStatus => _networkStatus();

  /// Is the device online
  bool get isOnline => _networkStatus() == DeviceNetworkStatus.online;

  /// Is the device sleeping
  bool get isDisconnected =>
      _networkStatus() == DeviceNetworkStatus.disconnected;

  /// Is the device offline
  bool get isOffline => _networkStatus() == DeviceNetworkStatus.offline;

  /// Has the device been seen on the network
  bool get isUnknown => _networkStatus() == DeviceNetworkStatus.unknown;

  /// The speed of the device in meters per second
  double get speed {
    if (position != null) {
      return position?.speed ?? 0;
    }
    return 0;
  }

  /// The speed of the device in kilometers per hour
  double get speedKmh {
    if (position != null) {
      return (3.6 * position?.speed) ?? 0;
    }
    return 0;
  }

  /// The last known position date
  DateTime get lastPositionDate {
    if (position == null) {
      return null;
    }
    if (position.timestamp == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(position.timestamp);
  }

  DeviceNetworkStatus _networkStatus() {
    if (position == null) {
      return DeviceNetworkStatus.unknown;
    }
    DeviceNetworkStatus s;
    final now = DateTime.now();
    final dateAlive = now.subtract(keepAlive);
    final dateSleeping = now.subtract(sleepingTimeout);
    final lastPosition = lastPositionDate;
    if (lastPosition == null) {
      // no known position date
      return s;
    }
    if (lastPosition.isAfter(dateAlive)) {
      s = DeviceNetworkStatus.online;
    } else {
      if (lastPosition.isAfter(dateSleeping)) {
        s = DeviceNetworkStatus.disconnected;
      } else {
        s = DeviceNetworkStatus.offline;
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
    print(" - network status: $networkStatus");
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
