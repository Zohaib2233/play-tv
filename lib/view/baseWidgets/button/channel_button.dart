import 'package:flutter/material.dart';

import '../../../util/color_resources.dart';
import '../../../util/custom_themes.dart';
import '../../../util/images.dart';

class ChannelButton extends StatelessWidget {
  String channelText;
  String channelImage;
  bool isFocus;

  ChannelButton(
      {super.key, required this.channelImage, required this.channelText,this.isFocus= false});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 160,
          height: 45,
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          margin: EdgeInsets.only(right: 10, top: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: isFocus?ColorResources.LIGHT_SKY_BLUE:ColorResources.PRIMARY_COLOR,

          ),
          child: Text(
            channelText,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: robotoRegular.copyWith(
                fontSize: 14,
                color: isFocus?ColorResources.PRIMARY_COLOR:ColorResources.WHITE,
                fontWeight: FontWeight.w700),
          ),
        ),
        Positioned(
          right: 0,
          child: CircleAvatar(
            radius: 25.0,
            backgroundColor: ColorResources.WHITE,
            backgroundImage: NetworkImage(channelImage),
          ),
        ),
      ],
    );
  }
}

Widget buildImage(String image, int index) =>
    Container(child: Image.asset(image, fit: BoxFit.cover));
