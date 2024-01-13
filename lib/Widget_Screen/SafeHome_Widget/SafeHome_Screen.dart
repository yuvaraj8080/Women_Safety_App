
import 'package:background_sms/background_sms.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_women_safety_app/Constants/contactsm.dart';
import 'package:flutter_women_safety_app/DB/db_services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../Constants/Utils.dart';

class SafeHome extends StatefulWidget {
  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  Position? _currentPosition;
  String? _currentAddress;
  LocationPermission? permission;

  Future<void> _getPermission() async {
    await Permission.sms.request();
  }

  Future<bool> _isPermissionGranted() async {
    return await Permission.sms.status.isGranted;
  }

  Future<void> _sendSms(String phoneNumber, String message, {int? simSlot}) async {
    SmsStatus result = await BackgroundSms.sendMessage(
        phoneNumber: phoneNumber, message: message, simSlot: 1);
    if (result == SmsStatus.sent) {
      print("Sent");
      Utils().showError( "successfully sent");
    } else {
      Utils().showError( "failed..");
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location services are disabled. Please enable the services'),
        ),
      );
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are denied')),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Location permissions are permanently denied, we cannot request permissions.',
          ),
        ),
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
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLon();
      });
    } catch (e) {
      print(e.toString());
      Utils().showError(e.toString());
    }
  }

  Future<void> _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _getPermission();
    _getCurrentLocation();
  }

   showModalSafeHome(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Card(
          child: Container(
            height: 400,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "SEND YOUR CURRENT LOCATION",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  if (_currentPosition != null)
                    Container(
                      height: 80,width:double.infinity,
                      color:Colors.white12,
                      child: Center(child: Text(_currentAddress!))),
                  const SizedBox(height: 70),
                  Container(
                    height:40,width:double.infinity,
                    child: ElevatedButton(
                      style:ButtonStyle(
                        elevation:MaterialStateProperty.all(2),
                        shadowColor:MaterialStateProperty.all(Colors.white),
                        backgroundColor:MaterialStateProperty.all(Colors.pinkAccent.shade700),
                        overlayColor: MaterialStateProperty.all(Colors.white24),

                      ),
                      child: Text("Get Location",style:GoogleFonts.roboto(fontSize:18,fontWeight:FontWeight.bold),),
                      onPressed: () {
                        _getCurrentLocation();
                        Utils().showError("Location getting...");
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height:40,width:double.infinity,
                    child: ElevatedButton(
                      style:ButtonStyle(
                        elevation:MaterialStateProperty.all(2),
                        shadowColor:MaterialStateProperty.all(Colors.white),
                        backgroundColor:MaterialStateProperty.all(Colors.pinkAccent.shade700),
                        overlayColor: MaterialStateProperty.all(Colors.white24),

                      ),
                      child: Text("Send Alert",style:GoogleFonts.roboto(fontSize:18,fontWeight:FontWeight.bold),),
                      onPressed: () async {
                        List<TContact> contactList =
                        await DatabaseHelper().getContactList();
                        String recipients = "";
                        int i = 1;
                        for (TContact contact in contactList) {
                          recipients += contact.number;
                          if (i != contactList.length) {
                            recipients += ";";
                            i++;
                          }
                        }
                        String messageBody =
                            "https://www.google.com/maps/search/?api=1&query=${_currentPosition!.latitude}%2C${_currentPosition!.longitude}. $_currentAddress";
                        if (await _isPermissionGranted()) {
                          contactList.forEach((element) {
                            _sendSms("${element.number}","I am in trouble please reach me out at $messageBody",
                              simSlot: 1,
                            );
                          });
                        } else {
                          print("Something wrong");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalSafeHome(context);
      },
      child: Card(
        elevation: 3,
        shadowColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              const Expanded(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Send Location",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("Share Location"),
                    ),
                  ],
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset("assets/images/route.jpg"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}