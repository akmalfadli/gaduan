import 'dart:convert';
import 'package:animated_svg/animated_svg.dart';
import 'package:animated_svg/animated_svg_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:gaduan/screen/register_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AuthController auth = Get.find<AuthController>();

  @override
  void initState() {
    // Initialize SvgController

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: <Widget>[
          Positioned(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      SvgPicture.asset(
                        'assets/images/goat.svg',
                        width: 50,
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(homePadding),
                        child: Text(
                          'Gaduan',
                          style: GoogleFonts.sofia(
                              fontSize: 50, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 400,
                    height: 400,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.at,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(width: 12),
                                    Flexible(
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Color(0xFF000000)),
                                        cursorColor: const Color(0xFF9b9b9b),
                                        keyboardType: TextInputType.text,
                                        decoration: const InputDecoration(
                                          hintText: "Email",
                                          hintStyle: TextStyle(
                                              color: Color(0xFF9b9b9b),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        validator: (emailValue) {
                                          if (emailValue!.isEmpty) {
                                            return 'Silahkan masukan email';
                                          }
                                          email = emailValue;
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    const Icon(
                                      FontAwesomeIcons.fingerprint,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      child: TextFormField(
                                        style: const TextStyle(
                                            color: Color(0xFF000000)),
                                        cursorColor: const Color(0xFF9b9b9b),
                                        keyboardType: TextInputType.text,
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Color(0xFF9b9b9b),
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        validator: (passwordValue) {
                                          if (passwordValue!.isEmpty) {
                                            return 'Silahkan masukan password';
                                          }
                                          password = passwordValue;
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.all(homePadding * 2),
                                  child: ElevatedButton(
                                    style: buttonStyle,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        var data = {
                                          'email': email,
                                          'password': password
                                        };
                                        auth.login(data);
                                      }
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          top: 8,
                                          bottom: 8,
                                          left: 10,
                                          right: 10),
                                      child: Text(
                                        'Login',
                                        textDirection: TextDirection.ltr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Masih belum punya akun ?',
                              style: TextStyle(
                                fontSize: 16.0,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8),
                            InkWell(
                              onTap: () {
                                Get.to(() => Register());
                              },
                              child: const Text(
                                'Daftar',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16.0,
                                  decoration: TextDecoration.none,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Obx(() => auth.isDataLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : Container()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _login() async {}
}
