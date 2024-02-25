import 'dart:async';
import 'package:background_sms/background_sms.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_women_safety_app/Constants/contactsm.dart';
import 'package:flutter_women_safety_app/DB/db_services.dart';
import 'package:get/get.dart';

class SafeHomeController extends GetxController {
  final _isSOSActive = false.obs;
  final _currentPosition = Rxn<Position>();
  final _currentAddress = RxnString();
  final _contactList = <TContact>[].obs;
  final _timerValue = ''.obs;
  Timer? _timer;
  final int _timerDurationInSeconds = 15;

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
      // Handle error
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        'Error',
        'Location services are disabled. Please Enable Location',
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location Permissions are Denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        'Error',
        'Location permissions are permanently Denied, we cannot request Permissions.',
      );
      return false;
    }
    return true;
  }

  Future<void> _getAddressFromLatLon(Position position) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      final place = placemarks[0];
      _currentPosition.value = position;
      _currentAddress.value = "${place.country},${place.administrativeArea},${place.locality},"
          "${place.subLocality},${place.postalCode}, ${place.street}";
    } catch (e) {
      // Handle error
    }
  }

  void _loadContacts() async {
    _contactList.assignAll(await DatabaseHelper().getContactList());
  }

  Future<void> handleSendAlert() async {
    if (_contactList.isEmpty) {
      Get.snackbar(
        "No trusted contacts available? Please Add Trusted Contact!",
        '',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (await _isPermissionGranted()) {
      _isSOSActive.toggle();

      if (_isSOSActive.value) {
        _timer = Timer.periodic(Duration(seconds: _timerDurationInSeconds), (timer) {
          _timerValue.value = '${timer.tick}';
          for (TContact contact in _contactList) {
            _sendSms(contact.number, _currentAddress.value ?? '');
          }
        });
        Get.snackbar(
          "SOS Help Activated",
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        _timer?.cancel();
        Get.snackbar(
          "SOS Help Deactivated",
          '',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        "SMS permission not granted",
        '',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<bool> _isPermissionGranted() async {
    return await Permission.sms.status.isGranted &&
        await Permission.contacts.status.isGranted;
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
