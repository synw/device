# Device

Data structure for a device.

   ```dart
   int id;
   String uniqueId;
   int groupId;
   String name;
   GeoPoint position;
   double batteryLevel;
   bool isDisabled;
   bool isActive;
   Duration keepAlive = const Duration(minutes: 1);
   Duration sleepingTimeout = const Duration(minutes: 10);
   Map<String, dynamic> properties = const <String, dynamic>{};
   ```

## Position

The device position is a [GeoPoint](https://github.com/synw/geopoint)

   ```dart
   final GeoPoint lastPosition = device.position;
   final DateTime lastPositionDate = device.lastPosition;
   ```
  
## Speed
  
   ```dart
   final double speed = device.speed;
   /// The speed of the device in meters per second

   final speedKmh = device.speedKmh;
   /// The speed of the device in kilometers per hour
   ```

## Network status

   ```dart
   final DeviceNetworkStatus networkStatus = device.networkStatus;
   /// One of [DeviceNetworkStatus.online], [DeviceNetworkStatus.sleeping],
   /// [DeviceNetworkStatus.offline] or [DeviceNetworkStatus.unknown]

   final bool isConnected = device.isAlive;
   /// Has the device been seen on the network before [keepAlive] timeout

   final bool hasJustDisconnected = device.isSleeping;
   /// Has the device been seen on the network before [sleepingTimeout] timeout
  
  final bool isDisconnected = device.isOffline;
  /// Last time the device was seen on the network is before [sleepingTimeout] timeout
  
  final bool hasNeverBeenSeen = device.isUnknown;
  /// The device has never been seen on the network
  ```

## Info

   ```dart
   final device.describe();
   /// Print device info
  ```
