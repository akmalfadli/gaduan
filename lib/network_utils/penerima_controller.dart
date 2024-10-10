import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/penerima.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PenerimaController extends GetxController {
  var isDataLoading = false.obs;
  PenerimaModel? penerima;
  SharedPreferences? localStorage;
  @override
  Future<void> onInit() async {
    super.onInit();
    await getDataPenerima();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {}

  getDataPenerima() async {
    var response;
    isDataLoading(true);
    try {
      response = await http.get(Uri.parse(apiUrl + '/penerimas'),
          headers: AuthController().setHeaders());

      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        penerima = PenerimaModel.fromJson(result);

        localStorage = await SharedPreferences.getInstance();
        localStorage?.setString('penerima', json.encode(result));

        // print('penerima: $result');
        isDataLoading(false);
      } else {
        localStorage = await SharedPreferences.getInstance();
        var data = localStorage?.getString('penerima');

        penerima = PenerimaModel.fromJson(jsonDecode(data!));
        Get.snackbar(
          'Koneksi gagal',
          'Pastikan anda terhubung ke internet',
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
        );
      }
    } on Exception catch (e) {
      localStorage = await SharedPreferences.getInstance();
      var data = localStorage?.getString('penerima');

      penerima = PenerimaModel.fromJson(jsonDecode(data!));

      Get.snackbar(
        'Terjadi kesalahan',
        'Pastikan anda terhubung ke internet',
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
      isDataLoading(true);
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    }
  }
}
