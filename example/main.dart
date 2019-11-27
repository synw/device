import 'package:device/device.dart';
import 'package:geopoint/geopoint.dart';

void main() {
  final device = Device(
      id: 1,
      name: "device1",
      position: GeoPoint(latitude: 0.0, longitude: 0.0, speed: 30));
  print(device.speed);
}
