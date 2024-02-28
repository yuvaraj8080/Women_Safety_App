import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:background_sms/background_sms.dart';
import '../../Constants/contactsm.dart';
import '../../DB/db_services.dart';
import '../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';

class LiveLocationController extends GetxController {
  Rx<LatLng> initialLatLng = LatLng(28.6472799, 76.8130638).obs;
  Rx<GoogleMapController?> googleMapController = Rx<GoogleMapController?>(null);
  final _contactList = <TContact>[].obs;
  bool isSOSActive = false;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _getPermission();
    getCurrentLocation();
    _loadContacts();
  }

  /// GETTING PERMISSION FOR BACKGROUND SMS AND CONTACTS
  Future<void> _getPermission() async {
    await Permission.sms.request();
    await Permission.contacts.request();
  }

  /// FETCHING THE USER CURRENT LIVE LOCATION
  Future<void> getCurrentLocation() async {
    bool locationPermissionGranted = await _handleLocationPermission();
    if (!locationPermissionGranted) {
      return; // Stop if location permission is not granted
    }

    Location location = Location();
    LocationData _locationData;

    _locationData = await location.getLocation();
    initialLatLng.value = LatLng(_locationData.latitude!, _locationData.longitude!);

    final GoogleMapController? controller = googleMapController.value;
    controller?.animateCamera(
      CameraUpdate.newLatLngZoom(initialLatLng.value, 14.0),
    );
  }

  /// HANDLE LOCATION PERMISSION
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
          title: 'Location permissions are permanently Denied, we cannot request Permissions.');
      return false;
    }
    return true;
  }

  /// GETTING TRUSTED CONTACTS FROM DATABASE
  void _loadContacts() async {
    _contactList.assignAll((await DatabaseHelper().getContactList()));
  }

  Future<void> sendSOS() async {
    if (!isSOSActive) {
      if (_contactList.isEmpty) {
        TLoaders.warningSnackBar(
            title: "No trusted contacts available? Please Add Trusted Contact!");
        return;
      }

      bool permissionsGranted = await _arePermissionsGranted();
      if (permissionsGranted) {
        _timer = Timer.periodic(Duration(seconds: 20), (timer) async {
          LocationData? locationData = await _getCurrentLocation();
          if (locationData != null) {
            String message =
                "I am in trouble! Please reach me at my current live location: https://www.google.com/maps/search/?api=1&query=${locationData.latitude},${locationData.longitude}";

            for (TContact contact in _contactList) {
              await sendMessage(contact.number, message);
            }
          }
        });

        TLoaders.customToast(message: "SOS Help Activated");
        isSOSActive = true;
      }
    } else {
      _timer?.cancel();
      LocationData? locationData = await _getCurrentLocation();
      if (locationData != null) {
        String message =
            "I am safe now! My current location: https://www.google.com/maps/search/?api=1&query=${locationData.latitude},${locationData.longitude}";

        for (TContact contact in _contactList) {
          await sendMessage(contact.number, message);
        }
      }
      TLoaders.customToast(message: "SOS Help Deactivated");
      isSOSActive = false;
    }
  }

  Future<bool> _arePermissionsGranted() async {
    return await Permission.sms.isGranted && await Permission.contacts.isGranted;
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

  Future<void> sendMessage(String phoneNumber, String message) async {
    await BackgroundSms.sendMessage(
      phoneNumber: phoneNumber,
      message: message,
      simSlot: 1,
    );
  }
}

class LiveLocation extends StatelessWidget {
  final LiveLocationController _controller = Get.put(LiveLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => GoogleMap(
          buildingsEnabled: true,
          trafficEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: _controller.initialLatLng.value,
            zoom: 14.0,
          ),
          markers: <Marker>{
            Marker(
              markerId: MarkerId("marker_1"),
              icon: BitmapDescriptor.defaultMarker,
              position: _controller.initialLatLng.value,
            ),
          },
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.googleMapController.value = controller;
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _controller.sendSOS();
        },
        label: Text(_controller.isSOSActive ? "I'm Safe" : "SOS"),
        icon: Icon(_controller.isSOSActive ? Icons.thumb_up : Icons.warning),
      ),
    );
  }
}
