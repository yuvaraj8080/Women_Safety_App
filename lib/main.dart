import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Widget_Screen/ChildScreeen/Bottom_Page.dart';
import 'package:flutter_women_safety_app/Widget_Screen/ChildScreeen/Bottom_Screens/ChildHome_Screen.dart';
import 'package:flutter_women_safety_app/Widget_Screen/ChildScreeen/Child_Login_Screen.dart';
import 'package:flutter_women_safety_app/Widget_Screen/ParentScreen/ParentHome_Screen.dart';
import 'DB/shere_Prefrences..dart';
import 'DB/shere_Prefrences..dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:1029361731735:android:af351e29c796171b7f41d2',
      apiKey: 'AIzaSyBh8A-Pqdd6m2-h70dSBArjMANcAJnB5Co',
      messagingSenderId: '1029361731735',
      projectId: 'women-safety-app-67951',
    ),
  );
  await MySharedPrefference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent.shade700,
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: MySharedPrefference.getUserType(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data =="") {
            return Login();
          }
          if (snapshot.data == "child") {
            return BottomPage();
          }
          if (snapshot.data == "parent") {
            return BottomPage();
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
