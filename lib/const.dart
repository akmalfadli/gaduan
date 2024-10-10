import 'package:flutter/material.dart';
import 'package:gaduan/screen/home_screen.dart';
import 'package:get/get.dart';

ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.teal,
    elevation: 5,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    minimumSize: Size(double.infinity, 50));

TextStyle textButtonStyle = TextStyle(
  color: Colors.white,
);

const bgcolor = Color(0xF9F9FB);

const String imageUrl = 'http://103.181.183.164:80/storage/';
const String apiUrl = 'http://103.181.183.164:80/api';
const double homePadding = 16;

List<GetPage> getPages = [
  GetPage(
    name: '/home',
    page: () => HomeScreen(),
  ),
];
