// import 'package:geolocator/geolocator.dart';
// import 'package:permission_handler/permission_handler.dart';

// class LocationService {
//   static Future<Position?> getCurrentLocation() async {
//     // Check permission
//     var status = await Permission.location.request();
//     if (status.isGranted) {
//       // If permission granted
//       return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//     } else {
//       // If permission denied
//       return null;
//     }
//   }
// }
