import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/post.dart';
import 'package:gaduan/models/user.dart';
import 'package:gaduan/network_utils/myposts_controller.dart';
import 'package:gaduan/widget/single_feed.dart';
import 'package:get/get.dart';

class GridViewPost extends StatelessWidget {
  GridViewPost({required this.posts, required this.user});

  final List<DataPost> posts;
  final user;
  late MyPostController _myPostController;

  showAlertDialog(BuildContext context, post_id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Batalkan"),
      onPressed: () {
        Get.back();
      },
    );
    Widget continueButton = TextButton(
      child: Text("Lanjutkan"),
      onPressed: () {
        _myPostController.remove(post_id: post_id);

        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Ingin manghapus postingan?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _myPostController = MyPostController(user.id);
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 150,
          childAspectRatio: 4 / 3,
          crossAxisSpacing: 3,
          mainAxisSpacing: 3),
      itemCount: posts.length,
      itemBuilder: ((context, index) {
        DataPost post = posts[index];
        return InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) {
                return Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SingleFeed(
                        post: post,
                        user: user,
                      ),
                    ));
              },
            );
          },
          onLongPress: () {
            showAlertDialog(context, post.id);
          },
          child: Container(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: CachedNetworkImage(
                imageUrl: '$imageUrl${post.image!}',
                imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                )),
                // placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        );
      }),
    );
  }
}
