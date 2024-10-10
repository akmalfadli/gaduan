import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/comment.dart';
import 'package:gaduan/models/reply_coment.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CommentController extends GetxController {
  var isDataLoading = false.obs;
  var isReplyLoading = false.obs;
  var commentModel = CommentModel().obs;
  var replyCommentModel = ReplyCommentModel().obs;

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

  getComment({postId}) async {
    isDataLoading(true);
    var result;
    var token = await AuthController().getToken();

    try {
      var response = await http.get(Uri.parse('$apiUrl/comments/$postId'),
          headers: setHeaders(token));

      if (response.statusCode == 200) {
        ///data successfully
        result = jsonDecode(response.body);
        commentModel(CommentModel.fromJson(result));
      } else {
        print('post error: ${response.body}');
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }

  addComment({postId, comment}) async {
    var token = await AuthController().getToken();
    var data = {'post_id': postId, 'comment': comment};
    var success = false;
    try {
      var response = await http.post(Uri.parse('$apiUrl/comments'),
          body: jsonEncode(data), headers: setHeaders(token));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (body['success']) {
          success = true;
          print('add comment res: $body');
          DataComment data = DataComment.fromJson(body['data']);
          commentModel.value.data!.add(data);
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
      return success;
    }
  }

  deleteComment({commentId, postId}) async {
    isDataLoading(true);
    var token = await AuthController().getToken();
    var data = {'id': commentId, 'post_id': postId};

    try {
      var response = await http.post(Uri.parse('$apiUrl/remove-comments'),
          body: jsonEncode(data), headers: setHeaders(token));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        //commentModel = CommentModel.fromJson(result);
        print('return delete comment: $result');
        commentModel.value.data!
            .removeWhere((element) => element.id == commentId);
        print('post comment: ${response.body}');
      } else {
        print('post error: ${response.body}');
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }

  replyComment({commentId, userId, content}) async {
    isReplyLoading(true);
    var token = await AuthController().getToken();

    var data = {
      'comment_id': commentId,
      'user_id': userId,
      'content': content,
    };

    try {
      var response = await http.post(Uri.parse('$apiUrl/reply-comment'),
          body: jsonEncode(data), headers: setHeaders(token));
      var body = jsonDecode(response.body);
      // print('post reply comment res: $body');
      if (response.statusCode == 200) {
        if (body['success']) {
          print('post reply comment success: $body');
          replyCommentModel(ReplyCommentModel.fromJson(body));
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
      isReplyLoading(false);
    }
  }

  getReplyComment({commentId}) async {
    isReplyLoading(true);
    var result;
    var token = await AuthController().getToken();

    try {
      var response = await http.get(Uri.parse('$apiUrl/get-replies/$commentId'),
          headers: setHeaders(token));
      var body = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ///data successfully
        print('get replies comment: $body');
        replyCommentModel(ReplyCommentModel.fromJson(body));
      } else {
        print('post error: $body');
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isReplyLoading(false);
    }
  }
}
