import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';
import 'package:gaduan/models/comment.dart';
import 'package:gaduan/models/reply_coment.dart';
import 'package:gaduan/models/user.dart';
import 'package:gaduan/network_utils/comment_controller.dart';
import 'package:gaduan/widget/circle_avatar.dart';
import 'package:get/get.dart';

TextEditingController txtController = TextEditingController();

replyCommentBottomSheet(
    {required context,
    required DataComment comment,
    required CommentController controller,
    required User user}) {
  controller.getReplyComment(commentId: comment.id);
  showModalBottomSheet<dynamic>(
      // shape: const RoundedRectangleBorder(
      //   borderRadius: BorderRadius.only(
      //       topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
      // ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0), topRight: Radius.circular(10)),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade600,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(3.0)),
                    ),
                  ),
                ),
                ListTile(
                  leading: circleAvatar(imageFromUrl: comment.imageProfile),
                  title: Text(comment.name!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(comment.comment!),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.shade200,
                ),
                Obx(
                  () => controller.isReplyLoading.value
                      ? const Expanded(
                          child: Center(child: CircularProgressIndicator()))
                      : Expanded(
                          child: ListView.builder(
                            itemCount:
                                controller.replyCommentModel.value.data!.length,
                            itemBuilder: ((context, index) {
                              DataReplyComment reply = controller
                                  .replyCommentModel.value.data![index];
                              return Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 30,
                                    height: 30,
                                    child: circleAvatar(
                                      imageFromUrl: reply.imageProfile,
                                    ),
                                  ),
                                  title: Text(
                                    reply.name!,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  subtitle: Text(reply.content!),
                                ),
                              );
                            }),
                          ),
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
                        leading: user.imageProfile != null
                            ? Container(
                                width: 35,
                                height: 35,
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: '$imageUrl${user.imageProfile}',
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
                          controller: txtController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.only(right: 25),
                            hintText: 'masukan komentar',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (txtController.text != '') {
                            controller.replyComment(
                                commentId: comment.id,
                                userId: user.id,
                                content: txtController.text);
                            txtController.text = '';
                          } else {
                            Get.showSnackbar(const GetSnackBar(
                              message: 'Komentar tidak boleh kosong',
                            ));
                          }
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
          ),
        );
      });
}
