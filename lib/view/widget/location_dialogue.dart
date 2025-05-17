// 
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zesta_1/constant/color.dart';

class LocationDialogController extends GetxController {
  var locationText = ''.obs;

  @override
  void onReady() {
    super.onReady();
    _loadSavedLocation();
    _checkAndShowDialog();
  }

  
  Future<void> _loadSavedLocation() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocation = prefs.getString('userLocation');
    if (savedLocation != null && savedLocation.isNotEmpty) {
      locationText.value = savedLocation;
    }
  }


  Future<void> _checkAndShowDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final shown = prefs.getBool('locationDialogShown') ?? false;
    if (!shown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showLocationDialog(Get.context!, prefs);
      });
    }
  }

  // Show the permission dialog
  Future<void> showLocationDialog(BuildContext context, SharedPreferences prefs) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor:   AppColors.textlight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.location_on, size: 80, color: AppColors.primary), 
              const SizedBox(height: 25),
              const Text(
                'Allow Location',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'We need your permission to access your location.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(context, true); // User allowed
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Allow Location',
                    style: TextStyle(fontSize: 16, color:   AppColors.textlight,),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'Deny',
                  style: TextStyle(fontSize: 16, color:  AppColors.textdark,),
                ),
              ),
            ],
          ),
        ),
      ),
    );


    await prefs.setBool('locationDialogShown', true);

    if (result == true) {
      await _getLocation();
    }
  }

 
  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Location Services", "Please enable location services.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Permission Denied", "Location permission is denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Permission Denied", "Location permissions are permanently denied.");
      return;
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      final place = placemarks.first;
      locationText.value = "${place.locality}, ${place.administrativeArea}";
      // Save location
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userLocation', locationText.value);
    } catch (e) {
      locationText.value = "Location available";
    }
  }
}
