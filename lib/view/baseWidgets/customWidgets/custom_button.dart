import 'package:flutter/material.dart';
import 'package:play_tv/util/custom_themes.dart';

class CustomFormButton extends StatelessWidget {
  CustomFormButton(
      {super.key,
      required this.bgColor,
      required this.textColor,
      required this.btnText,
      this.onTap,
      this.focusNode});

  final Color bgColor;
  final Color textColor;
  final String btnText;
  final FocusNode? focusNode;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 50,
      child: ElevatedButton(
          focusNode: focusNode,
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
          ),
          child: Text(
            btnText,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          )),
    );
  }
}
