import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:play_tv/util/custom_themes.dart';

import '../../../util/color_resources.dart';

class SignInButton extends StatelessWidget {
  SignInButton({
    super.key, required this.logo, required this.title,
    this.isGoogleButton=false,
    required this.onTap
  });

  final String logo;
  final String title;
  final void Function()? onTap;
  bool isGoogleButton = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      tileColor: Colors.white,
      leading: isGoogleButton? Image.asset(logo):SvgPicture.asset(logo),
      title: Text(title,style: robotoRegular.copyWith(
        fontSize: 21,
        fontWeight: FontWeight.w400
      ),),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),
          side: BorderSide(width: 2,color: ColorResources.PRIMARY_COLOR)),

    );
  }
}