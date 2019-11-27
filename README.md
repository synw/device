# Device

[![pub package](https://img.shields.io/pub/v/device.svg)](https://pub.dartlang.org/packages/device) [![Build Status](https://travis-ci.org/synw/device.svg?branch=master)](https://travis-ci.org/synw/device)

Data structure for a device.

   ```dart
   // data properties
   int id,
   String uniqueId,
   int groupId,
   String name,
   GeoPoint position,
   double batteryLevel,
   GeoDataFrame df,
   Map<String, dynamic> properties,
   // state properties
   bool isVisible = true,
   bool isDisabled = false,
   Duration keepAlive = const Duration(minutes: 1),
   Duration sleepingTimeout = const Duration(minutes: 10),
   bool isFollowed = false,
   bool isTraced = false
   ```

## Position

The device position is a [GeoPoint](https://github.com/synw/geopoint)

   ```dart
   final GeoPoint lastPosition = device.position;
   final DateTime lastPositionDate = device.lastPositionDate;
   ```
  
## Speed
  
   ```dart
   final double speed = device.speed;
   /// The speed of the device
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
