import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gaduan/const.dart';

Widget circleAvatar({required imageFromUrl}) {
  return imageFromUrl.isNotEmpty
      ? Container(
          width: 45,
          height: 45,
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: '$imageUrl${imageFromUrl}',
            imageBuilder: ((context, imageProvider) => CircleAvatar(
                minRadius: 45,
                maxRadius: 45,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                ))),
          ),
        )
      : Container(
          width: 45,
          height: 45,
          child: const CircleAvatar(
            minRadius: 45,
            maxRadius: 45,
            backgroundImage:
                ExactAssetImage('assets/images/male_profile_placeholder.jpg'),
          ),
        );
}
