import 'dart:async';
import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_women_safety_app/Constants/contactsm.dart';
import 'package:flutter_women_safety_app/DB/db_services.dart';
import '../../common/widgets.Login_Signup/custom_shapes/container/TCircleAvatar.dart';
import '../../common/widgets.Login_Signup/loaders/snackbar_loader.dart';
import '../../utils/halpers/helper_function.dart';
import 'package:flutter/services.dart';

class SafeHome extends StatefulWidget {
  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  Position? _currentPosition;
  String? _currentAddress;
  String messageBody = "";
  Timer? _timer;
  final int _timerDurationInSeconds = 10;
  bool _isSOSActive = false;
  List<TContact> contactList = [];

  Future<void> _getPermission() async {
    await Permission.sms.request();
    await Permission.contacts.request();
  }

  Future<bool> _isPermissionGranted() async {
    return await Permission.sms.status.isGranted &&
        await Permission.contacts.status.isGranted;
  }

  Future<void> _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    SmsStatus result = await BackgroundSms.sendMessage(
      phoneNumber: phoneNumber,
      message: message,
      simSlot: 1,
    );
  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location services are disabled. Please Enable Location'),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            TLoaders.errorSnackBar(title:"Location Permission  are Denied")
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
          TLoaders.errorSnackBar(title:'Location permissions are permanently Denied, we cannot request Permissions.',)
      );
      return false;
    }
    return true;
  }

  Future<void> _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        forceAndroidLocationManager: true,
      );
      _getAddressFromLatLon(position);
    } catch (e) {
      TLoaders.successSnackBar(title:"Getting Your Current Location");
    }
  }

  Future<void> _getAddressFromLatLon(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      Placemark place = placemarks[0];
      setState(() {
        _currentPosition = position;
        _currentAddress = "${place.country},${place.administrativeArea},${place.locality},"
            "${place.subLocality},${place.postalCode}, ${place.street}";
        messageBody = "I am in trouble! Please reach me at https://www.google.com/maps/search/?api=1&query="
            "${place.country},${place.administrativeArea},${place.locality}${place.subLocality},${place.postalCode},${place.street},"
            "${place.subLocality},${place.postalCode}, ${place.street}";
      });
    }
    catch (e) {

    }
  }

  @override
  void initState() {
    super.initState();
    _getPermission();
    _getCurrentLocation();
    _loadContacts();
  }

  void _loadContacts() async {
    contactList = await DatabaseHelper().getContactList();
  }

  Future<void> _handleSendAlert() async {
    if (contactList.isEmpty) {
      TLoaders.warningSnackBar(title:"No trusted contacts available? Please Add Trusted  Contact!");
      return;
    }

    if (await _isPermissionGranted()) {
      setState(() {
        _isSOSActive = !_isSOSActive;
      });

      if (_isSOSActive) {
        _timer = Timer.periodic(Duration(seconds: _timerDurationInSeconds), (timer) async {
          for (TContact contact in contactList) {
            _sendSms(contact.number, messageBody, simSlot: 1);
            _makeCall(contact.number);
            TLoaders.successSnackBar(title:"SOS Help Successfully Sent");
          }
        });
        TLoaders.successSnackBar(title:"SOS Help Activated");
      } else {
        _timer?.cancel();
        TLoaders.errorSnackBar(title:"SOS Help Deactivated");
      }
    } else {
      TLoaders.errorSnackBar(title:"SMS permission not granted");
    }
  }

  void _makeCall(String phoneNumber) async {
    try {
      const platform = MethodChannel('flutter.native/helper');
      await platform.invokeMethod('makeCall', {"phoneNumber": phoneNumber});
    } on PlatformException catch (e) {
      print("Failed to make call: '${e.message}'.");
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunction.isDarkMode(context);
    return InkWell(
      onTap: () {
        _handleSendAlert();
      },
      child: Container(
        height: 140,
        width: MediaQuery.of(context).size.width,
        child: Card(
          elevation:3,shadowColor:dark?Colors.white:Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              TCircularAvatar(imageUrl:"assets/images/sos.png",radius: 45)
            ],
          ),
        ),
      ),
    );
  }
}




