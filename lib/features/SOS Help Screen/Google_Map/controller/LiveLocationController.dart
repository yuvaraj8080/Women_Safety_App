import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sensors_plus/sensors_plus.dart';
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
  var polygons = <Polygon>[].obs;

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

  Future<void> fetchReports() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection("ReportIncidents").get();
      final List<ReportIncidentModel> fetchedReports = querySnapshot.docs.map((doc) => ReportIncidentModel.fromSnapshot(doc)).toList();
      reports.assignAll(fetchedReports);
      _loadPolygonsAndMarkers();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch reports: $e');
    }
  }

  void _loadPolygonsAndMarkers() {
    final List<List<LatLng>> clusters = _clusterReports(reports, 100);
    final List<Polygon> reportPolygons = clusters.map((cluster) {
      final String id = cluster.map((e) => e.toString()).join();
      return Polygon(
        polygonId: PolygonId(id),
        points: cluster,
        strokeColor: Colors.redAccent,
        strokeWidth: 2,
        fillColor: Colors.red.withOpacity(0.15),
      );
    }).toList();

    final List<Marker> reportMarkers = [];
    for (var report in reports) {
      LatLng point = LatLng(double.parse(report.latitude), double.parse(report.longitude));
      reportMarkers.add(
        Marker(
          markerId: MarkerId(report.id),
          position: point,
          infoWindow: InfoWindow(
            title: report.titleIncident,
            snippet: report.incidentDescription,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }

    polygons.assignAll(reportPolygons);
    markers.assignAll(reportMarkers);
  }

  List<List<LatLng>> _clusterReports(List<ReportIncidentModel> reports, double distanceInMeters) {
    List<List<LatLng>> clusters = [];
    for (ReportIncidentModel report in reports) {
      LatLng point = LatLng(double.parse(report.latitude), double.parse(report.longitude));
      bool addedToCluster = false;
      for (List<LatLng> cluster in clusters) {
        if (_isPointInCluster(point, cluster, distanceInMeters)) {
          cluster.add(point);
          addedToCluster = true;
          break;
        }
      }
      if (!addedToCluster) {
        clusters.add([point]);
      }
    }
    return clusters;
  }

  bool _isPointInCluster(LatLng point, List<LatLng> cluster, double distanceInMeters) {
    for (LatLng clusterPoint in cluster) {
      double distance = Geolocator.distanceBetween(
        point.latitude,
        point.longitude,
        clusterPoint.latitude,
        clusterPoint.longitude,
      );
      if (distance <= distanceInMeters) {
        return true;
      }
    }
    return false;
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
