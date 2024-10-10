import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/user.dart';
import 'package:gaduan/screen/home_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  var isDataLoading = false.obs;
  var isAuth = false;
  UserModel? userModel;
  final user = User().obs;

  late SharedPreferences localStorage;

  getToken() async {
    localStorage = await SharedPreferences.getInstance();
    return jsonDecode(localStorage.getString('token')!)['token'];
  }

  setHeaders({token}) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  login(data) async {
    isDataLoading(true);
    var body;
    try {
      var response = await http.post(Uri.parse('$apiUrl/login'),
          body: jsonEncode(data), headers: setHeaders());
      body = json.decode(response.body);

      if (response.statusCode == 200) {
        //userModel = UserModel.fromJson(body);

        if (body['success']) {
          userModel = UserModel.fromJson(body);

          user(User.fromJson(userModel!.user!.toJson()));

          print('user login: ${user.toJson()}');

          localStorage = await SharedPreferences.getInstance();
          localStorage.setString('token', json.encode(body['token']));
          localStorage.setString('user', json.encode(body['user']));
        }
      } else {
        Get.snackbar(
          'Kesalahan',
          '${body['message']}',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
        );

        ///error
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      if (user.value.name != null) Get.to(() => HomeScreen());
      isDataLoading(false);
    }
  }

  register(data) async {
    isDataLoading(true);

    var registerHeader = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    try {
      var response = await http.post(Uri.parse('$apiUrl/register'),
          body: jsonEncode(data), headers: registerHeader);
      var body = json.decode(response.body);

      print('register response: $body');
      if (response.statusCode == 200) {
        if (body['success']) {
          userModel = UserModel.fromJson(body);

          user(User.fromJson(userModel!.user!.toJson()));

          print('user login: ${user.toJson()}');

          localStorage = await SharedPreferences.getInstance();
          localStorage.setString('token', json.encode(body['token']));
          localStorage.setString('user', json.encode(body['user']));
          //userModel = UserModel.fromJson(body);

        }
      } else {
        Get.snackbar(
          'Kesalahan',
          '${body['message']}',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
        );
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      if (user.value.name != null) Get.to(() => HomeScreen());
      isDataLoading(false);
    }
  }

  logout() async {
    var token = await AuthController().getToken();
    try {
      var response = await http.get(Uri.parse('$apiUrl/logout'),
          headers: setHeaders(token: token));
      var body = json.decode(response.body);
      print('logout: $body');
      if (response.statusCode == 200) {
        if (body['success']) {
          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          localStorage.remove('user');
          localStorage.remove('token');
          Get.back();
        }
      } else {
        ///error
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }

  checkIfLoggedIn() async {
    isDataLoading(true);
    localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');

    if (token != null) {
      user(User.fromJson(jsonDecode(localStorage.getString('user')!)));
      print('user: ${user.value.toJson()}');
      isAuth = true;
    }
    isDataLoading(false);
    return isAuth;
  }
}
