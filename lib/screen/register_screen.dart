import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:gaduan/screen/login_screen.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var name;
  var username;
  AuthController auth = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: _formKey,
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
                                        fontSize: 50,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.user,
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
                                      hintText: "Nama",
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    validator: (nameValue) {
                                      if (nameValue!.isEmpty) {
                                        return 'Silahkan masukan nama anda';
                                      }
                                      name = nameValue;
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                const Icon(
                                  FontAwesomeIcons.userTie,
                                  color: Colors.grey,
                                ),
                                const SizedBox(width: 12),
                                Flexible(
                                  child: TextFormField(
                                    style: const TextStyle(
                                        color: Color(0xFF000000)),
                                    cursorColor: const Color(0xFF9b9b9b),
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      hintText: "Username",
                                      hintStyle: TextStyle(
                                          color: Color(0xFF9b9b9b),
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Username tidak boleh kosong';
                                      } else if (val
                                          .contains(RegExp("\\p{Punct}"))) {
                                        return 'Username tidak boleh mengandung tanda baca';
                                      } else {
                                        username = val;
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
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
                                Icon(
                                  FontAwesomeIcons.fingerprint,
                                  color: Colors.grey,
                                ),
                                SizedBox(width: 12),
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
                              padding: const EdgeInsets.all(homePadding * 2),
                              child: ElevatedButton(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 8, bottom: 8, left: 10, right: 10),
                                  child: Text(
                                    'Daftar',
                                    textDirection: TextDirection.ltr,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                      decoration: TextDecoration.none,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                style: buttonStyle,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _register();
                                  }
                                },
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
                          'Sudah punya akun ?',
                          style: TextStyle(
                            fontSize: 16.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Get.to(() => LoginScreen());
                          },
                          child: const Text(
                            'Masuk',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16.0,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Obx(() => auth.isDataLoading.value
                            ? const Center(child: CircularProgressIndicator())
                            : Container()),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _register() async {
    var data = {
      'email': email,
      'password': password,
      'name': name,
      'username': username
    };

    AuthController().register(data);
  }
}
