import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/post.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostController extends GetxController {
  var isDataLoading = false.obs;
  PostModel? postData;
  SharedPreferences? localStorage;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getRecentpost();
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

  getRecentpost() async {
    isDataLoading(true);
    var result;
    var token = await AuthController().getToken();
    try {
      var response = await http.get(Uri.parse('$apiUrl/posts'),
          headers: setHeaders(token));

      if (response.statusCode == 200) {
        ///data successfully
        result = jsonDecode(response.body);
        postData = PostModel.fromJson(result);

        localStorage = await SharedPreferences.getInstance();
        localStorage?.setString('posts', json.encode(result));
      } else {
        print('post error: ${response.body}');
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');

      localStorage = await SharedPreferences.getInstance();
      var data = localStorage?.getString('posts');
      postData = PostModel.fromJson(jsonDecode(data!));

      Get.snackbar(
        'Kesalahan',
        'Terjadi kesalahan koneksi!',
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    } finally {
      isDataLoading(false);
    }
  }

  upload(File image, String description) async {
    isDataLoading(true);

    var token = await AuthController().getToken();

    var data = {
      'description': description,
    };

    setHeaders(token)['Content-Type'] = 'multipart/form-data';
    //convert file image to Base64 encoding
    print('image path: ${image.path}');
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$apiUrl/posts'))
        ..fields.addAll(data)
        ..headers.addAll(setHeaders(token))
        ..files.add(http.MultipartFile.fromBytes(
            'image', await image.readAsBytes(),
            filename: 'image.png'));
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode == 200) {
        ///data successfully
        await getRecentpost();
        Get.back();
        Get.snackbar(
          'Uploaded',
          'Postingan anda berhasil dikirim!',
          backgroundColor: Colors.blue,
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
        );
        //   var result = jsonDecode(response.body);
        //   postData = Post.fromJson(result);
      } else {
        print('upload gagal: ${response.body}');
        Get.snackbar(
          'Gagal',
          'Postingan anda gagal dikirim!',
          snackPosition: SnackPosition.BOTTOM,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
        );
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
      isDataLoading(false);
    }
    //return await http.Response.fromStream(streamedResponse);
  }

  Future<bool> addLike({userId, postId}) async {
    // isDataLoading(true);
    var token = await AuthController().getToken();
    var data = {'post_id': postId, 'user_id': userId};
    var success = false;
    try {
      var response = await http.post(Uri.parse('$apiUrl/hit-like'),
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
