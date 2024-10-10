import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/user.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PengaturanController extends GetxController {
  var isDataLoading = false.obs;
  late UserModel userModel;
  AuthController auth = Get.find<AuthController>();
  @override
  Future<void> onInit() async {
    super.onInit();
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

  updateUser({required data, required image}) async {
    isDataLoading(true);
    Map<String, String> convertDataToStringString = {};

    data.forEach((key, val) {
      convertDataToStringString[key] = val.toString();
    });
    var request;
    var token = await AuthController().getToken();
    setHeaders(token)['Content-Type'] = 'multipart/form-data';
    try {
      if (image != null) {
        request = http.MultipartRequest(
            'POST', Uri.parse('$apiUrl/update-user'))
          ..fields.addAll(convertDataToStringString)
          ..headers.addAll(setHeaders(token))
          ..files.add(await http.MultipartFile.fromPath('image', image.path));
      } else {
        convertDataToStringString['image'] = '';
        request =
            http.MultipartRequest('POST', Uri.parse('$apiUrl/update-user'))
              ..fields.addAll(convertDataToStringString)
              ..headers.addAll(setHeaders(token));
      }
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        if (result['success']) {
          print('update res: $result');
          userModel = UserModel.fromJson(result);

          SharedPreferences localStorage =
              await SharedPreferences.getInstance();
          auth.user(User.fromJson(result['user']));
          localStorage.setString('user', json.encode(result['user']));
          update();
          Get.snackbar(
            'Berhasil',
            'Terimakasih telah memperbarui profil anda',
            backgroundColor: Colors.blueAccent,
            snackPosition: SnackPosition.BOTTOM,
            forwardAnimationCurve: Curves.elasticInOut,
            reverseAnimationCurve: Curves.easeOut,
          );
          Get.back();
        }
      } else {
        Get.snackbar(
          'Gagal',
          'Terjadi kesalahan koneksi',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
        );
        print('update-user: ${response.body}');
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
