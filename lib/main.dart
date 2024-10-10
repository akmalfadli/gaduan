import 'package:flutter/material.dart';
import 'package:gaduan/screen/spash_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.nunitoSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      title: 'Gaduan',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
