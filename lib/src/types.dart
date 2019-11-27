/// The current network status
enum DeviceNetworkStatus {
  /// The device is on the network
  online,

  /// The device is off the network
  offline,

  /// The device has just quit the network
  disconnected,

  /// The device has never been seen on the network
  unknown
}
