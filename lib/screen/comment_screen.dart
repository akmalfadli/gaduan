import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/comment.dart';
import 'package:gaduan/models/post.dart';
import 'package:gaduan/network_utils/auth_controller.dart';
import 'package:gaduan/network_utils/comment_controller.dart';
import 'package:gaduan/widget/circle_avatar.dart';
import 'package:gaduan/widget/relpy_comment_widget.dart';
import 'package:get/get.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({required this.post, super.key});
  final DataPost post;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  bool longPressComment = false;

  CommentController? commentController;
  AuthController auth = Get.put(AuthController());
  Map<String, int> convertTime(createdAt) {
    DateTime a = DateTime.parse(createdAt);
    DateTime b = DateTime.now();

    Duration difference = b.difference(a);

    print('days beetwen: ${daysBetween(b, a)}');

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    print('$days hari, $hours jam, $minutes menit, $seconds detik');
    Map<String, int> duration;

    if (days > 0) {
      duration = {'hari': days};
    } else if (days == 0) {
      duration = {'jam': hours};
    } else if (hours == 0) {
      duration = {'menit': minutes};
    } else if (minutes == 0) {
      duration = {'detik': seconds};
    } else {
      duration = {'detik': 0};
    }
    return duration;
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  TextEditingController textController = TextEditingController();

  showAlertDialog(BuildContext context, id) {
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
        setState(() {
          commentController!
              .deleteComment(commentId: id, postId: widget.post.id);
        });

        Get.back();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Ingin manghapus komentar?"),
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
  void initState() {
    super.initState();
    commentController = Get.put(CommentController());
    commentController!.getComment(postId: widget.post.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Komentar'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: ListTile(
                    leading:
                        circleAvatar(imageFromUrl: widget.post.imageProfile),
                    title: Text(
                      widget.post.name!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(widget.post.description!),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 18.0),
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.shade200,
                ),
                Obx(
                  () => commentController!.isDataLoading.value ||
                          commentController!.commentModel.value.data.isBlank!
                      ? Container()
                      : commentController!.commentModel.value.data != null
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: commentController!
                                    .commentModel.value.data!.length,
                                itemBuilder: ((context, index) {
                                  DataComment comment = commentController!
                                      .commentModel.value.data![index];
                                  print('commnt date: ${comment.createdAt}');
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      onLongPress: () {
                                        if (comment.userId ==
                                            auth.user.value.id) {
                                          showAlertDialog(context, comment.id);
                                        }
                                      },
                                      leading: circleAvatar(
                                          imageFromUrl: comment.imageProfile),
                                      title: Row(
                                        children: [
                                          Text(
                                            comment.name!,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            '${convertTime(widget.post.createdAt).values.first} ${convertTime(widget.post.createdAt).keys.first}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(comment.comment!),
                                          InkWell(
                                            onTap: () =>
                                                replyCommentBottomSheet(
                                                    context: context,
                                                    comment: comment,
                                                    controller:
                                                        commentController!,
                                                    user: auth.user.value),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                    'Balas',
                                                    style: TextStyle(
                                                        color:
                                                            Colors.blueAccent),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  comment.repliesCount != 0
                                                      ? Text(
                                                          ' lihat ${comment.repliesCount} balasan')
                                                      : Container()
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            )
                          : const Center(
                              child: Text('tidak terhubung ke server'),
                            ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey.shade200,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                ListTile(
                  leading: auth.user.value.imageProfile != null
                      ? Container(
                          width: 35,
                          height: 35,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:
                                '$imageUrl${auth.user.value.imageProfile}',
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
                                              fit: BoxFit.fill),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(80))),
                                    ))),
                          ),
                        )
                      : const CircleAvatar(
                          backgroundImage: ExactAssetImage(
                              'assets/images/male_profile_placeholder.jpg'),
                        ),
                  title: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(right: 25),
                      hintText: 'masukan komentar',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await commentController!.addComment(
                        postId: widget.post.id, comment: textController.text);
                    setState(() {
                      textController.clear();
                    });
                  },
                  child: const Text(
                    'Kirim   ',
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
