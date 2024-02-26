import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/appBar/appbar.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/card/VerticaleCard.dart';
import 'package:flutter_women_safety_app/common/widgets.Login_Signup/custom_shapes/curved_edges.dart/primary_header_controller.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';
import '../../../Constants/Utils.dart';
import '../../../Constants/contactsm.dart';
import '../../../DB/db_services.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../HomeScreen_Widget/LIvesafe_Screen.dart';
import '../../SafeHome_Widget/SafeHome_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // const HomeScreen({super.key});
  int qIndex = 0;
  Position? _curentPosition;
  String? _curentAddress;
  LocationPermission? permission;
  _getPermission() async => await [Permission.sms].request();
  _isPermissionGranted() async => await Permission.sms.status.isGranted;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  _getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    final Telephony telephony = Telephony.instance;
    await telephony.requestPhoneAndSmsPermissions;
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _curentPosition = position;
        print(_curentPosition!.latitude);
        _getAddressFromLatLon();
      });
    }).catchError((e) {
      Utils().showError(e.toString());
    });
  }

  _getAddressFromLatLon() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _curentPosition!.latitude, _curentPosition!.longitude);

      Placemark place = placemarks[0];
      setState(() {
        _curentAddress =
            "${place.locality},${place.postalCode},${place.street},";
      });
    } catch (e) {
      Utils().showError(e.toString());
    }
  }

  getRandomSafeText() {
    Random random = Random();
    setState(() {
      qIndex = random.nextInt(6);
    });
  }

  getAndSendSms() async {
    List<TContact> contactList = await DatabaseHelper().getContactList();

    String messageBody =
        "https://maps.google.com/?daddr=${_curentPosition!.latitude},${_curentPosition!.longitude}";
    if (await _isPermissionGranted()) {
      contactList.forEach((element) {
        // _sendSms("${element.number}", "i am in trouble $messageBody");
      });
    } else {
      Utils().showError("something wrong");
    }
  }

  @override
  void initState() {
    getRandomSafeText();
    super.initState();
    _getPermission();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          // --------HEADER---------
          TPrimaryHeaderContainer(
              child: Column(
            children: [
              // ------ CUSTOM APPBAR ------
              TAppBar(actions:[Icon(Icons.help_center,size:25)],
                  title: Row(
                    children: [
                      Text("IM Safe",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .apply(color: TColors.white))
                    ],
                  )),
              Text("Hey Dear! Now Your Safety is My Responsibility",
                  style:Theme.of(context).textTheme.titleSmall!.apply(color:TColors.white)),

              ///------APP BAR HEIGHT-----------'
              SizedBox(height:TSizes.size32)
            ],
          )),
          // Row(
          //   children: [
          //     Text("Emergency helpline",
          //         style: GoogleFonts.lato(
          //             fontSize: 18,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white)),
          //   ],
          // ),
          // const Emergency(),

          Padding(
            padding: EdgeInsets.symmetric(horizontal:TSizes.size12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///-----EXPLORE LIVE SAFE OPEN MAP AND TEXT--------
                Text("Explore LiveSafe",style:Theme.of(context).textTheme.headlineSmall),
                const LiveSafe(),
                SizedBox(height:TSizes.size8),


                ///EMERGENCY HELPLINE
                EmergencyHelpline_Card(),


                ///----[SOS] BUTTON SAFE AND SOUL---------
                SafeHome(),


              ],
            ),
          ),

          // InkWell(
          //   onTap: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) {
          //       return LiveLocation();
          //     }));
          //   },
          //   child: Card(
          //     elevation: 3,
          //     shadowColor: Colors.white,
          //     child: Padding(
          //       padding: const EdgeInsets.all(5.0),
          //       child: Container(
          //           height: 250,
          //           width: double.infinity,
          //           child: Center(child: LiveLocation())),
          //     ),
          //   ),
          // ),

        ]),
      ),
    );
  }
}
