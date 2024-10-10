import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MessagingController extends GetxController {
  var isDataLoading = false.obs;

  setHeaders(token) => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  sendMessage({required message, required recipientId}) async {
    isDataLoading(true);

    var token = await AuthController().getToken();

    var data = {
      'message': message,
      'recipient_id': recipientId,
    };

    try {
      var response = await http.post(Uri.parse('$apiUrl/send-message'),
          body: jsonEncode(data), headers: setHeaders(token));
      var body = jsonDecode(response.body);
      // print('post reply comment res: $body');
      if (response.statusCode == 200) {
        if (body['success']) {
          print('post reply comment success: $body');
        }
      } else {
        ///error
      }
    } on Exception catch (e) {
      Get.snackbar(
        'Koneksi gagal',
        'Pastikan anda terhubung ke internet',
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      // ignore: control_flow_in_finally
      isDataLoading(false);
    }
  }

  getMessages() async {
    isDataLoading(true);
    var result;
    var token = await AuthController().getToken();

    try {
      var response = await http.get(Uri.parse('$apiUrl/get-message'),
          headers: setHeaders(token));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ///data successfully
        print('get replies comment: $body');
      } else {
        print('post error: $body');
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
