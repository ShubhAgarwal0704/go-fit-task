import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  //check if permission granted or not
  static Future<bool> checkPermissions() async {
    PermissionStatus permission = await Permission.location.status;
    if (!permission.isGranted) {
      await Permission.location.request();
    }

    return await Permission.location.isGranted;
  }

  //get current location
  static Stream<Position> getCurrentLocation() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }

  //get address from latLong
  static Future<Placemark> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      return placemarks[0];
    } catch (e) {
      throw Exception("Error retrieving address");
    }
  }
}
