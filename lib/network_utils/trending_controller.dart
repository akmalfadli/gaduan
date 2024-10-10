import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/post.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TrendingController extends GetxController {
  var isTrendingLoading = false.obs;
  PostModel? postData;

  @override
  Future<void> onInit() async {
    super.onInit();
    getTrendingPost();
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

  getTrendingPost() async {
    isTrendingLoading(true);
    var result;
    var token = await AuthController().getToken();
    try {
      var response = await http.get(Uri.parse('$apiUrl/trendings'),
          headers: setHeaders(token));

      if (response.statusCode == 200) {
        ///data successfully
        result = jsonDecode(response.body);

        postData = PostModel.fromJson(result);
      } else {
        print('post error: ${response.body}');
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isTrendingLoading(false);
    }
  }

  Future<bool> addLike({userId, postId}) async {
    // isDataLoading(true);
    var token = await AuthController().getToken();
    var data = {'post_id': postId, 'user_id': userId};
    var success = false;
    try {
      var response = await http.post(Uri.parse(apiUrl + '/hit-like'),
          body: jsonEncode(data), headers: setHeaders(token));
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
        if (body['success']) {
          success = true;
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
      // isDataLoading(false);
      // ignore: control_flow_in_finally
      return success;
    }
  }

  removeLike({userId, postId}) async {
    // isDataLoading(true);
    var token = await AuthController().getToken();
    var data = {'post_id': postId, 'user_id': userId};
    try {
      var response = await http.post(Uri.parse(apiUrl + '/remove-like'),
          body: jsonEncode(data), headers: setHeaders(token));
      var body = json.decode(response.body);
      if (response.statusCode == 200) {
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
      // isDataLoading(false);
    }
  }
}
