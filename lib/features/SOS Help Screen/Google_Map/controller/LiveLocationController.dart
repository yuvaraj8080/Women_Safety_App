import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors/sensors.dart';
import 'package:vibration/vibration.dart';
import '../../../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';
import 'SOS_Help_Controller.dart';

class LiveLocationController extends GetxController {
  Rx<LatLng> initialLatLng = LatLng(28.6472799, 76.8130638).obs;
  Rx<GoogleMapController?> googleMapController = Rx<GoogleMapController?>(null);
  final SOSController _sosController = Get.put(SOSController());
  Timer? _timer;
  int shakeCount = 0;

  @override
  void onInit() {
    super.onInit();
    _getPermission();
    getCurrentLocation();
    _startListeningShakeDetector();
  }

  Future<void> _getPermission() async {
    await Permission.sms.request();
    await Permission.contacts.request();
    await Permission.location.request();
  }

  Future<void> getCurrentLocation() async {
    bool locationPermissionGranted = await _handleLocationPermission();
    if (!locationPermissionGranted) {
      return;
    }

    Location location = Location();
    LocationData _locationData;

    _locationData = await location.getLocation();
    initialLatLng.value =
        LatLng(_locationData.latitude!, _locationData.longitude!);

    final GoogleMapController? controller = googleMapController.value;
    controller?.animateCamera(
      CameraUpdate.newLatLngZoom(initialLatLng.value, 14.0),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      TLoaders.warningSnackBar(
          title: 'Location services are disabled. Please Enable Location');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        TLoaders.warningSnackBar(title: 'Location Permissions are Denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      TLoaders.warningSnackBar(
          title:
          'Location permissions are permanently Denied, we cannot request Permissions.');
      return false;
    }
    return true;
  }

  void _startListeningShakeDetector() {
    bool isShaking = false;
    int shakeCount = 0;

    accelerometerEvents.listen((event) async {
      if (_isShaking(event) && !isShaking) {
        isShaking = true;
        shakeCount++;
        LocationData? locationData = await _getCurrentLocation();
        if (shakeCount <= 5 && locationData != null) {
          await _sosController.sendShakeSOS(locationData);
          if (await Vibration.hasVibrator() ?? false) {
            Vibration.vibrate(duration: 100);
          }
        }

        if (shakeCount == 5) {
          shakeCount = 0;
        }
        isShaking = false;
      }
    });
  }

  Future<LocationData?> _getCurrentLocation() async {
    Location location = Location();
    LocationData? locationData;

    bool _serviceEnabled = await location.serviceEnabled();
    if (_serviceEnabled) {
      locationData = await location.getLocation();
    }

    return locationData;
  }

  bool _isShaking(AccelerometerEvent event) {
    final double threshold = 70.0;
    return event.x.abs() > threshold ||
        event.y.abs() > threshold ||
        event.z.abs() > threshold;
  }
}
