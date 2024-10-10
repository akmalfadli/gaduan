import 'package:animated_svg/animated_svg.dart';
import 'package:animated_svg/animated_svg_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:gaduan/screen/home_screen.dart';
import 'package:gaduan/screen/login_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final SvgController controller;
  late AuthController auth;
  bool loggedin = false;

  _checkLoggedIn() async {
    loggedin = await auth.checkIfLoggedIn();
  }

  @override
  void initState() {
    auth = Get.put(AuthController());
    _checkLoggedIn();
    // Initialize SvgController
    controller = AnimatedSvgController();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        controller.forward();
      });
    });

    Future.delayed(const Duration(milliseconds: 3000), () {
      if (loggedin) {
        Get.to(() => HomeScreen());
      } else {
        Get.to(() => LoginScreen());
      }
    });
  }

  @override
  void dispose() {
    // Dispose SvgController
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(homePadding),
                      child: Column(
                        children: [
                          Text(
                            'Gaduan',
                            style: GoogleFonts.sofia(
                                fontSize: 60, fontWeight: FontWeight.w900),
                          ),
                          SizedBox(height: 16),
                          const Text('hubungkan para peternak indonesia',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontStyle: FontStyle.italic))
                        ],
                      ),
                    ),
                    Container(
                        width: 400,
                        height: 400,
                        child: AnimatedSvg(
                          controller: controller,
                          duration: const Duration(milliseconds: 2000),
                          onTap: () {},
                          size: 100,
                          clockwise: false,
                          isActive: true,
                          children: [
                            SvgPicture.asset(
                              'assets/images/goat.svg',
                            ),
                            SvgPicture.asset(
                              'assets/images/goat.svg',
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
