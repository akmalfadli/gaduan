import 'dart:convert';
import 'dart:developer';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/post.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MyPostController extends GetxController {
  var isDataLoading = false.obs;
  var postData = PostModel().obs;
  final user_id;
  MyPostController(this.user_id);

  @override
  Future<void> onInit() async {
    super.onInit();
    await getMyPost(user_id);
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

  getMyPost(user_id) async {
    isDataLoading(true);
    var result;
    var token = await AuthController().getToken();

    try {
      var response = await http.post(Uri.parse('$apiUrl/myposts'),
          body: jsonEncode({'user_id': user_id}), headers: setHeaders(token));

      if (response.statusCode == 200) {
        ///data successfully
        result = jsonDecode(response.body);
        print('myposts: $user_id | ${response.body}');
        postData(PostModel.fromJson(result));
      } else {
        print('mypost: ${response.body}');
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }

  remove({required post_id}) async {
    isDataLoading(true);

    var token = await AuthController().getToken();
    var data = {'id': post_id};
    try {
      var response = await http.post(Uri.parse('$apiUrl/remove-myposts'),
          body: jsonEncode(data), headers: setHeaders(token));

      if (response.statusCode == 200) {
        ///data successfully
        var result = jsonDecode(response.body);
        postData.value.data ??
            postData.value.data!
                .removeWhere((element) => element.id == post_id);

        print('remove myposts:  $result');
        // postData(PostModel.fromJson(result));
      } else {
        print('mypost: ${response.body}');
      }
    } on Exception catch (e) {
      log('Error while getting data is $e');
      print('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
