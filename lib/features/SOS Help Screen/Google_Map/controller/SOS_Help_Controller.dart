import 'dart:async';
import 'package:flutter_women_safety_app/data/notification_services/notification_service.dart';
import 'package:location/location.dart';
import 'package:get/get.dart';
import 'package:background_sms/background_sms.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../Constants/contactsm.dart';
import '../../../../DB/db_services.dart';
import '../../../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';

class SOSController extends GetxController {
  final _contactList = <TContact>[].obs;
  bool isSOSActive = false;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _loadContacts();
  }




  /// Reloads contact list whenever contacts are added or changed
  Future<void> refreshContacts() async {
    _contactList.assignAll(await DatabaseHelper().getContactList());
  }

  void _loadContacts() async {
    await refreshContacts();
  }

  /// Send SOS help SMS to all trusted contacts
  Future<void> sendSOS(LocationData locationData) async {
    await refreshContacts();  // Ensure we have the latest contacts
    if (!isSOSActive) {
      if (_contactList.isEmpty) {
        TLoaders.warningSnackBar(title: "No trusted contacts available? Please Add Trusted Contact!");
        return;
      }

      bool permissionsGranted = await _arePermissionsGranted();
      if (permissionsGranted) {
        _timer = Timer.periodic(Duration(seconds: 10), (timer) async {
          String message = "I am in trouble! Please reach me at my current live location: https://www.google.com/maps/search/?api=1&query=${locationData.latitude},${locationData.longitude}";

          for (TContact contact in _contactList) {
            await sendMessage(contact.number, message);
            TLoaders.customToast(message: "Sent SOS message successfully");
          }
        });

        TLoaders.successSnackBar(title: "SOS Help Activated");
        isSOSActive = true;
      }
    }
    else {
      _timer?.cancel();
      String message = "I am safe now! My current location: https://www.google.com/maps/search/?api=1&query=${locationData.latitude},${locationData.longitude}";

      for (TContact contact in _contactList) {
        await sendMessage(contact.number, message);
      }
      TLoaders.successSnackBar(title: "SOS Help Deactivated");
      isSOSActive = false;
    }
  }

  Future<void> sendShakeSOS(LocationData locationData) async {
    await refreshContacts();  // Ensure we have the latest contacts
    if (_contactList.isEmpty) {
      TLoaders.warningSnackBar(title: "No trusted contacts available? Please Add Trusted Contact!");
      return;
    }

    bool permissionsGranted = await _arePermissionsGranted();
    if (permissionsGranted) {
      String message ="I am in trouble! Please reach me at my current live location: https://www.google.com/maps/search/?api=1&query=${locationData.latitude},${locationData.longitude}";

      for (TContact contact in _contactList) {
        await sendMessage(contact.number, message);
        // showNotification(title:"She Shield", body:"Emergency help sent successfully to trusted contacts And Police");
      }
    }
  }

  Future<bool> _arePermissionsGranted() async {
    return await Permission.sms.isGranted && await Permission.contacts.isGranted;
  }

  Future<void> sendMessage(String phoneNumber, String message) async {
    await BackgroundSms.sendMessage(phoneNumber: phoneNumber, message: message, simSlot: 1);
  }
}
