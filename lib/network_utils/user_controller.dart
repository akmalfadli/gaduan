import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/user.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  var isUserLoading = false.obs;

  UserController({required this.id});
  var id;
  User? user;

  @override
  Future<void> onInit() async {
    super.onInit();
    await show(id: id);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  setHeaders(token) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  show({required id}) async {
    isUserLoading(true);
    var data = {'id': id};
    var token = await AuthController().getToken();
    try {
      var response = await http.post(Uri.parse('$apiUrl/show-user'),
          body: jsonEncode(data), headers: setHeaders(token));
      print('login response: ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var body = json.decode(response.body);

        if (body['success']) {
          print('user profile : ${body['user']}');
          user = User.fromJson(body['user']);
        }
      } else {
        ///error
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isUserLoading(false);
    }
  }

  follow({required followingId, required name}) async {
    // isUserLoading(true);
    var data = {'following_id': followingId};
    var token = await AuthController().getToken();
    try {
      var response = await http.post(Uri.parse('$apiUrl/follow'),
          body: jsonEncode(data), headers: setHeaders(token));
      print('following response: ${json.decode(response.body)}');
      if (response.statusCode == 200) {
        var body = json.decode(response.body);

        if (body['success']) {
          print('user: $body');
          Get.snackbar(
            'Berhasil',
            'Berhasil mengikuti $name',
            backgroundColor: Colors.blueAccent,
            snackPosition: SnackPosition.TOP,
            forwardAnimationCurve: Curves.elasticInOut,
            reverseAnimationCurve: Curves.easeOut,
          ); // user = User.fromJson(body['user']);
        }
      } else {
        ///error
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      // isUserLoading(false);
    }
  }
}
