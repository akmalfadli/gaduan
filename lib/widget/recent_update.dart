import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/post.dart';
import 'package:gaduan/models/user.dart';
import 'package:gaduan/network_utils/post_controller.dart';
import 'package:gaduan/screen/comment_screen.dart';
import 'package:gaduan/widget/expandable_text.dart';
import 'package:gaduan/widget/image_dialog.dart';
import 'package:gaduan/widget/like_button.dart';
import 'package:get/get.dart';

class RecentUpdate extends StatelessWidget {
  PostController postController = Get.put(PostController());
  RecentUpdate({required this.user});

  bool toggleLike = false;
  final User user;
  @override
  Widget build(BuildContext context) {
    return Obx(() => postController.isDataLoading.value
        ? Container()
        : ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: postController.postData!.data!.length,
            itemBuilder: ((context, index) {
              DataPost post = postController.postData!.data![index];

              var image = post.image;
              var like = post.likeCount;
              print('image url......$image');
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height: MediaQuery.of(context).size.width * 0.4,
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (_) =>
                                              ImageDialog('$imageUrl$image'));
                                    },
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: CachedNetworkImage(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        imageUrl: '$imageUrl${image!}',
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: imageProvider,
                                                  fit: BoxFit.fitWidth),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10))),
                                        ),
                                        // placeholder: (context, url) => CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          children: [
                                            CustomLikeButton(
                                              onTap: (bool isLiked) =>
                                                  postController.addLike(
                                                      userId: post.userId,
                                                      postId: post.id),
                                              likeCount: post.likeCount,
                                            ),
                                            const SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: () =>
                                                  Get.to(() => CommentScreen(
                                                        post: post,
                                                      )),
                                              child: const Icon(
                                                  FontAwesomeIcons.comment,
                                                  size: 20),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(post.name!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        dateTimeFormat(post.createdAt!),
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              ExpandableText(
                                post.description!,
                                trimLines: 1,
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ));
  }

  dateTimeFormat(String datetime) {
    var splitDateTime = datetime.split(' ');
    var date = splitDateTime[0].split('-').reversed.join('-');
    var time = splitDateTime[1];
    return '$time $date';
  }
}
