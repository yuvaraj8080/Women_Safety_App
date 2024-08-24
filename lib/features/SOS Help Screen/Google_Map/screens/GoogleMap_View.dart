import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/features/SOS%20Help%20Screen/Google_Map/controller/SOS_Help_Controller.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';
import '../controller/LiveLocationController.dart';

class GoogleMap_View_Screen extends StatelessWidget {
  // Use dependency injection for controller via Get
  final LiveLocationController locationController = Get.put(LiveLocationController());
  final SOSController sosController = Get.put(SOSController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => GoogleMap(
          buildingsEnabled: true,
          trafficEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: locationController.initialLatLng.value,
            zoom: 14.0,
          ),
          markers: <Marker>{
            Marker(
              markerId: MarkerId("marker_1"),
              icon: BitmapDescriptor.defaultMarker,
              position: locationController.initialLatLng.value,
            ),
          },
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            locationController.googleMapController.value = controller;
          },
        ),
      ),
      // Update the FAB based on SOS status
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:FloatingActionButton.extended(
        onPressed: () async {
          LocationData? locationData = await locationController.getCurrentLocation();
          if (locationData != null) {
            sosController.sendSOS(locationData); // Trigger SOS send/stop
          } else {
            TLoaders.warningSnackBar(title: 'Failed to get current location');
          }
        },
        // Show different labels depending on the SOS state
        label: Text(sosController.isSOSActive ? "Stop SOS" : "Start SOS"),
        icon: sosController.isSOSActive
            ? Icon(Icons.stop, color: Colors.red)
            : Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/sos.png"),
              radius: 25, // Adjusted for better UI
            ),
          ],
        ),
        backgroundColor: sosController.isSOSActive ? Colors.red : Colors.blue,
      ));
  }
}
