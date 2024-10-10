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

initiateSentPostToBottomSheet({required context}) {
  showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: Scaffold(
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
                  leading: circleAvatar(imageFromUrl: ''),
                  title: Text('Akmal fadli'),
                  trailing: SizedBox(
                      width: 100,
                      height: 30,
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Kirim'))),
                ),
              ],
            ),
          ),
        );
      });
}
