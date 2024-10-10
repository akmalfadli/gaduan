import 'package:flutter/material.dart';
import 'package:gaduan/models/user.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:gaduan/network_utils/trending_controller.dart';
import 'package:gaduan/widget/grid_view_post.dart';
import 'package:get/get.dart';

class TrendingScreen extends StatelessWidget {
  TrendingScreen({super.key});
  final TrendingController _trendingController = Get.put(TrendingController());
  AuthController auth = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder(
            init: auth,
            builder: (_) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 16, 12, 8),
                    child: Container(
                      height: 40,
                      child: TextField(
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              borderSide:
                                  BorderSide(width: 1, color: Colors.grey),
                            ),
                            contentPadding: EdgeInsets.only(top: 5),
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey),
                            hintText: "Cari",
                            fillColor: Colors.grey.shade200),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _trendingController.isTrendingLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: _trendingController.postData != null
                                ? GridViewPost(
                                    posts: _trendingController.postData!.data!,
                                    user: auth.user.value)
                                : Center(
                                    child: Text('tidak terhubung ke server'),
                                  ),
                          ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
