import 'dart:async';
import 'package:background_sms/background_sms.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_women_safety_app/Constants/contactsm.dart';
import 'package:flutter_women_safety_app/DB/db_services.dart';
import 'package:get/get.dart';

import '../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';


class SafeHomeController extends GetxController {
  final _isSOSActive = false.obs;
  final _currentPosition = Rxn<Position>();
  final _currentAddress = RxnString();
  final _contactList = <TContact>[].obs;
  final _timerValue = ''.obs;
  Timer? _timer;
  final int _timerDurationInSeconds = 20;

  @override
  void onInit() {
    super.onInit();
    _getPermission();
    _getCurrentLocation();
    _loadContacts();
  }

  Future<void> _getPermission() async {
    await Permission.sms.request();
    await Permission.contacts.request();
  }

  Future<void> _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
      );
      _getAddressFromLatLon(position);
    } catch (e) {
      TLoaders.errorSnackBar(title: "Something Went wrong? Please try again");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      TLoaders.warningSnackBar(title: 'Location services are disabled. Please Enable Location');
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

  Future<void> _getAddressFromLatLon(Position position) async {
    try {
      final List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final Placemark place = placemarks[0];
      _currentPosition.value = position;
      _currentAddress.value = "${position.latitude},${position.longitude},${place.country},${place.administrativeArea},${place.locality},"
          "${place.subLocality},${place.postalCode},${place.street}";
    } catch (e) {
      TLoaders.errorSnackBar(title: "Something went wrong! Please try again");
    }
  }

  void _loadContacts() async {
    _contactList.assignAll(await DatabaseHelper().getContactList());
  }

  Future<void> handleSendAlert() async {
    if (_contactList.isEmpty) {
      TLoaders.warningSnackBar(title: "No trusted contacts available? Please Add Trusted Contact!");
      return;
    }
    if (await _isPermissionGranted()) {
      _isSOSActive.toggle();

      if (_isSOSActive.value) {
        _timer = Timer.periodic(Duration(seconds: _timerDurationInSeconds), (timer) {
          _timerValue.value = '${timer.tick}';
          if (_currentAddress.value != null) {
            for (TContact contact in _contactList) {
              _sendSms(contact.number,"I am in trouble! Please reach me at my current live location: https://www.google.com/maps/search/?api=1&query=${_currentPosition.value}");
              TLoaders.customToast(message: "SOS Help Successfully Sent");
            }
          } else {
            // Handle null address
            TLoaders.errorSnackBar(title: "Current address not available");
          }
        });
        TLoaders.successSnackBar(title: "SOS Help Activated");
      } else {
        _timer?.cancel();
        _sendSafeMessage(); // Send a final message indicating the user is safe
        TLoaders.successSnackBar(title: "SOS Help Deactivated");
      }
    } else {
      TLoaders.warningSnackBar(title: "SMS permission not granted");
    }
  }

  void _sendSafeMessage() {
    for (TContact contact in _contactList) {
      _sendSms(contact.number,"I am Safe, my Current location: https://www.google.com/maps/search/?api=1&query=${_currentAddress.value}");
    }
  }

  Future<bool> _isPermissionGranted() async {
    return await Permission.sms.isGranted && await Permission.contacts.isGranted;
  }

  Future<void> _sendSms(String phoneNumber, String message) async {
    await BackgroundSms.sendMessage(
      phoneNumber: phoneNumber,
      message: message,
      simSlot: 1,
    );
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.onClose();
  }
  RxString get timerValue => _timerValue;
}
