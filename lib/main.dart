import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_women_safety_app/utils/Storage/hive_storage.dart';
import 'package:get/get.dart';
import 'app.dart';
import 'data/notification_services/notification_service.dart';
import 'data/repositories/authentication/authentication-repository.dart';
import 'firebase_options.dart';

void main() async{
  ///---WIDGET BINDING
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();


  await THiveStorage.init('UserBox');


  ///---- AWAIT SPLASH UNTIL ITEM LOAD ----
  FlutterNativeSplash.preserve(widgetsBinding:widgetsBinding);


  /// ASWOME NOTIFICATION
  WidgetsFlutterBinding.ensureInitialized();
  // await initializeNotification();


  ///----INITIALIZATION FIREBASE AND AUTHENTICATION REPOSITORY----
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
      (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );

  await FirebaseAppCheck.instance.activate(
    webProvider:ReCaptchaV3Provider("recaptcha-v3-site-key"),
    androidProvider: AndroidProvider.debug,
    // playintegrity
  );
  runApp(const App());
}
