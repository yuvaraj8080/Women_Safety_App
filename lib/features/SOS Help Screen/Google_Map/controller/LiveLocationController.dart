import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors/sensors.dart';
import 'package:vibration/vibration.dart';
import '../../../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';
import '../../../Advanced_Safety_Tool/models/ReportIncidentModel.dart';
import 'SOS_Help_Controller.dart';

class LiveLocationController extends GetxController {
  static LiveLocationController get instance => Get.find();

  /// SHAKE MODE IS DISABLE
  RxBool isShakeModeEnabled = false.obs;

  //// STORE ALL THE INCIDENTS REPORTS DATA ////
  var reports = <ReportIncidentModel>[].obs;
  //// STORE ALL THE MARKES DATA IN THE VARIABLE ////
  var markers = <Marker>[].obs;

  Rx<LatLng> initialLatLng = LatLng(28.6472799, 76.8130638).obs;
  Rx<GoogleMapController?> googleMapController = Rx<GoogleMapController?>(null);
  final SOSController _sosController = Get.put(SOSController());
  // Timer? _timer;
  int shakeCount = 0;

  @override
  void onInit() {
    super.onInit();
    _getPermission();
    getCurrentLocation();
    fetchReports();
    _startListeningShakeDetector();
  }

  /// FUNCTION TO FETCH THE REPORTS INCIDENTS DATA FROM THE FIREBASE ////
  Future<void> fetchReports() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("ReportIncidents").get();
      final List<ReportIncidentModel> fetchedReports = querySnapshot.docs.map((doc) => ReportIncidentModel.fromSnapshot(doc)).toList();
      reports.assignAll(fetchedReports);
      _loadMarkers();
    } catch (e) {
      // Handle errors
      Get.snackbar('Error', 'Failed to fetch reports: $e');
    }
  }

  /// FUNCTION TO LOAD MARKERS BASED ON REPORTS DATA
  void _loadMarkers() {
    final List<Marker> reportMarkers = reports.map((report) {
      return Marker(
        markerId: MarkerId(report.id),
        position: LatLng(double.parse(report.latitude), double.parse(report.longitude)),
        infoWindow: InfoWindow(title: report.title,
            snippet: report.description
        ),
      );
    }).toList();
    markers.assignAll(reportMarkers);
  }


  Future<void> _getPermission() async {
    await Permission.location.request();
    await Permission.sms.request();
    await Permission.contacts.request();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    while (!serviceEnabled) {
      TLoaders.warningSnackBar(title: 'Location services are disabled. Please Enable Location');
      await Geolocator.openLocationSettings();
      await Future.delayed(Duration(seconds: 2)); // wait for 2 seconds
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
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
          title:'Location permissions are permanently Denied, we cannot request Permissions.');
      return false;
    }
    return true;
  }


  Future<LocationData?> getCurrentLocation() async {
    bool locationPermissionGranted = await _handleLocationPermission();
    if (!locationPermissionGranted) {
      return null;
    }

    Location location = Location();
    LocationData? _locationData;

    _locationData = await location.getLocation();
    initialLatLng.value = LatLng(_locationData.latitude!, _locationData.longitude!);
    final GoogleMapController? controller = googleMapController.value;
    controller?.animateCamera(
      CameraUpdate.newLatLngZoom(initialLatLng.value, 14.0),
    );
    return _locationData;
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


  /// SHAKE FEATURE IS HARE [SEND SOS HELP]
  void _startListeningShakeDetector() {
    int shakeCount = 0;
    accelerometerEvents.listen((event) async {
      if (isShakeModeEnabled.value && _isShaking(event)) {
        shakeCount++;
        if (shakeCount == 3) {
          LocationData? locationData = await _getCurrentLocation();
          if (locationData != null) {
            await _sosController.sendShakeSOS(locationData);
            if (await Vibration.hasVibrator() ?? false) {
              Vibration.vibrate(duration: 100);
            }
          }
          shakeCount = 0; // reset shake count
        }
      }
    });
  }

  bool _isShaking(AccelerometerEvent event) {
    final double threshold = 70.0;
    return event.x.abs() > threshold ||
        event.y.abs() > threshold ||
        event.z.abs() > threshold;
  }
}
