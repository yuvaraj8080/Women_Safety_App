import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Widget_Screen/Home_Screen.dart';

void main() {
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
        textTheme:GoogleFonts.firaCodeTextTheme(Theme.of(context).textTheme),
        brightness:Brightness.dark,primaryColor: Colors.purple,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:HomeScreen(),
    );
  }
}
