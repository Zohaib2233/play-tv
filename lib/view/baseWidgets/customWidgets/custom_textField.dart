import 'package:flutter/material.dart';
import 'package:play_tv/util/color_resources.dart';
import 'package:play_tv/util/custom_themes.dart';

class CustomFormField extends StatelessWidget {
   CustomFormField({
    super.key,
    required this.text,
    required this.hintText,
     this.controller,
     this.textInputAction,
     this.focusNode,
     this.autofocus=false,
  });
  final String text;
  final String hintText;
   final TextInputAction? textInputAction;
   final FocusNode? focusNode;
   final bool autofocus;
  TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,style: TextStyle(color: ColorResources.PRIMARY_COLOR,
        fontWeight: FontWeight.w700,fontSize: 16),),

        SizedBox(
          height: 5,
        ),
        TextFormField(
          focusNode: focusNode,
          controller: controller,
          textInputAction:textInputAction ,
           autofocus: true,
          decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              fillColor: ColorResources.GREY,
              filled: true,
              hintStyle: robotoRegular.copyWith(color: ColorResources.HINT_TEXT_COLOR),
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(
                color: ColorResources.PRIMARY_COLOR,
              ),borderRadius: BorderRadius.circular(10))
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}