import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Constants/contactsm.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:background_sms/background_sms.dart';
import '../../DB/db_services.dart';
import '../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';



class LiveLocationController extends GetxController {
  Rx<LatLng> initialLatLng = LatLng(28.6472799, 76.8130638).obs;
  Rx<GoogleMapController?> googleMapController =
  Rx<GoogleMapController?>(null);
  final _contactList = <TContact>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getPermission();
    getCurrentLocation();
    _loadContacts();
  }

  Future<void> _getPermission() async {
    await Permission.sms.request();
    await Permission.contacts.request();
  }

  Future<void> getCurrentLocation() async {
    bool locationPermissionGranted = await _handleLocationPermission();
    if (!locationPermissionGranted) {
      return; // Stop if location permission is not granted
    }

    Location location = Location();
    LocationData _locationData;

    _locationData = await location.getLocation();
    initialLatLng.value =
        LatLng(_locationData.latitude!, _locationData.longitude!);

    // Update the initial camera position to target the user's current location
    final GoogleMapController? controller = googleMapController.value;
    controller?.animateCamera(
      CameraUpdate.newLatLngZoom(initialLatLng.value, 14.0), // Zoom level 14
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

  void _loadContacts() async {
    _contactList.assignAll((await DatabaseHelper().getContactList()));
  }

  Future<void> sendSOS() async {
    if (_contactList.isEmpty) {
      TLoaders.warningSnackBar(
          title: "No trusted contacts available? Please Add Trusted Contact!");
      return;
    }

    // Request SMS and contact permissions
    bool permissionsGranted = await _arePermissionsGranted();
    if (permissionsGranted) {
      // Get the user's current location
      LocationData? locationData = await _getCurrentLocation();
      if (locationData != null) {
        // Compose SOS message with live location
        String message =
            "I am in trouble! Please reach me at my current live location: https://www.google.com/maps/search/?api=1&query=${locationData.latitude},${locationData.longitude}";

        // Send SOS message to all trusted contacts
        for (TContact contact in _contactList) {
          await sendMessage(contact.number, message);
        }

        TLoaders.customToast(message: "SOS Help Successfully Sent");
      } else {
        // Show error message if unable to retrieve current location
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Unable to retrieve current location')),
        );
      }
    } else {
      // Show error message if permissions are denied
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('SMS and Contacts permissions are required to send SOS messages')),
      );
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
  final LiveLocationController _controller =
  Get.put(LiveLocationController());

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
          _controller.sendSOS(); // Call sendSOS when SOS button is pressed
        },
        label: Text("SOS"),
        icon: Icon(Icons.warning),
      ),
    );
  }
}
