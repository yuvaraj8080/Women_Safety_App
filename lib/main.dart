import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_women_safety_app/Widget_Screen/Login_Screen.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:1029361731735:android:af351e29c796171b7f41d2',
      apiKey: 'AIzaSyBh8A-Pqdd6m2-h70dSBArjMANcAJnB5Co',
      messagingSenderId: '1029361731735',
      projectId: 'women-safety-app-67951',
    ),
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // textTheme:GoogleFonts.firaCodeTextTheme(Theme.of(context).textTheme),
        brightness:Brightness.dark,primaryColor: Colors.blueAccent.shade700,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:Login(),
    );
  }
}
