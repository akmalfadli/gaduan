import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gaduan/models/post.dart';
import 'package:gaduan/models/user.dart';
import 'package:gaduan/network_utils/post_feed_controller.dart';
import 'package:gaduan/screen/home_screen.dart';
import 'package:gaduan/screen/posting_screen.dart';
import 'package:gaduan/widget/single_feed.dart';
import 'package:get/get.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({required this.user});
  User user;
  PostFeedController feedController = Get.put(PostFeedController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.grey.shade50,
                iconTheme: IconThemeData(color: Colors.grey),
                title: const Text(
                  'Gaduan',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                floating: true,
                actions: [
                  IconButton(
                      onPressed: () => Get.to(PostScreen(user: user)),
                      icon: const Icon(
                        FontAwesomeIcons.squarePlus,
                        color: Colors.black,
                      )),
                  // IconButton(
                  //     onPressed: () {},
                  //     icon: const Icon(FontAwesomeIcons.heart,
                  //         color: Colors.black)),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.facebookMessenger,
                          color: Colors.black))
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: feedController.postData!.data!.length,
                  (context, index) {
                    return Obx(() {
                      DataPost post = feedController.postData!.data![index];
                      return feedController.isFeedLoading.value
                          ? Container()
                          : SingleFeed(post: post, user: user);
                    });
                  },
                  // Builds 1000 ListTiles
                ),
              ),
            ],
          ),
          onRefresh: () => feedController.getFeedPost(),
        ),
      ),
    );
  }
}
