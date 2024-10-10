import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/post.dart';
import 'package:gaduan/models/user.dart';
import 'package:gaduan/network_utils/post_feed_controller.dart';
import 'package:gaduan/screen/comment_screen.dart';
import 'package:gaduan/screen/profile_screen.dart';
import 'package:gaduan/widget/expandable_text.dart';
import 'package:gaduan/widget/initiate_sent_post_to.dart';
import 'package:gaduan/widget/like_button.dart';
import 'package:get/get.dart';

class SingleFeed extends StatelessWidget {
  SingleFeed({required this.post, required this.user});

  final DataPost post;
  final User user;
  @override
  Widget build(BuildContext context) {
    PostFeedController feedController = PostFeedController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Get.to(() => ProfileScreen(userId: post.userId)),
                child: Row(
                  children: [
                    post.imageProfile != null && post.imageProfile != ''
                        ? CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: '$imageUrl${post.imageProfile}',
                            imageBuilder: ((context, imageProvider) =>
                                CircleAvatar(
                                    minRadius: 20,
                                    maxRadius: 20,
                                    child: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fitWidth),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(80))),
                                    ))),
                          )
                        : const CircleAvatar(
                            backgroundImage: ExactAssetImage(
                                'assets/images/male_profile_placeholder.jpg'),
                          ),
                    const SizedBox(width: 8),
                    Text(
                      post.name!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    post.isGaduan == 1
                        ? const Icon(
                            FontAwesomeIcons.circleCheck,
                            color: Colors.blue,
                            size: 1,
                          )
                        : Container()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      FontAwesomeIcons.bookmark,
                      size: 22,
                    )),
              )
            ],
          ),
        ),
        AspectRatio(
          aspectRatio: 4 / 3,
          child: CachedNetworkImage(
            height: MediaQuery.of(context).size.height * 0.3,
            imageUrl: '$imageUrl${post.image!}',
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            // placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      CustomLikeButton(
                        onTap: (bool isLiked) => feedController.addLike(
                            userId: post.userId, postId: post.id),
                        likeCount: post.likeCount,
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Get.to(() => CommentScreen(
                              post: post,
                            )),
                        child: const Icon(FontAwesomeIcons.comment, size: 20),
                      ),
                      const SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          initiateSentPostToBottomSheet(context: context);
                        },
                        child:
                            const Icon(FontAwesomeIcons.paperPlane, size: 20),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                children: [
                  Text(post.name!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  ExpandableText(
                    post.description!,
                    trimLines: 1,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              post.commentCount! > 0
                  ? GestureDetector(
                      onTap: () => Get.to(() => CommentScreen(
                            post: post,
                          )),
                      child: Text(
                        'Lihat semua ${post.commentCount} komentar',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }
}
