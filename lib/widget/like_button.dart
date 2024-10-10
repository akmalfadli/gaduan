import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';

class CustomLikeButton extends StatelessWidget {
  final onTap;
  final likeCount;
  CustomLikeButton({this.onTap, this.likeCount});

  @override
  Widget build(BuildContext context) {
    double buttonSize = 22.0;
    return LikeButton(
      onTap: onTap,
      size: buttonSize,
      circleColor:
          const CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Color(0xff33b5e5),
        dotSecondaryColor: Color(0xff0099cc),
      ),
      likeBuilder: (bool isLiked) {
        return Icon(
          FontAwesomeIcons.heart,
          color: isLiked ? Colors.red : Colors.black,
          size: buttonSize,
        );
      },
      likeCount: likeCount,
      countBuilder: (int? count, bool isLiked, String text) {
        var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
        Widget result;
        if (count == 0) {
          result = Text(
            "",
            style: TextStyle(color: color),
          );
        } else
          result = Text(
            text,
            style: TextStyle(color: color),
          );
        return result;
      },
    );
  }
}
