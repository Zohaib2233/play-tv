import 'package:flutter/material.dart';
import 'package:play_tv/util/color_resources.dart';
import 'package:play_tv/util/custom_themes.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintTxt;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final Color? fillColor;
  final String title;

  CustomPasswordTextField({this.controller, this.hintTxt, this.focusNode, this.nextNode, this.textInputAction , this.fillColor, required this.title});

  @override
  _CustomPasswordTextFieldState createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,style: TextStyle(color: ColorResources.PRIMARY_COLOR,
            fontWeight: FontWeight.w700,fontSize: 16),),

        SizedBox(
          height: 5,
        ),
        TextFormField(

          cursorColor: Theme.of(context).primaryColor,
          controller: widget.controller,
          obscureText: _obscureText,
          focusNode: widget.focusNode,
      //    textInputAction: widget.textInputAction ?? TextInputAction.none,

          onFieldSubmitted: (v) {
      FocusScope.of(context).requestFocus(widget.nextNode);
          },
          validator: (value) {
            return null;
          },
          decoration: InputDecoration(
              suffixIcon: IconButton(icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility,
              color: ColorResources.PRIMARY_COLOR,), onPressed: _toggle),

              isDense: true,
              hintText: widget.hintTxt,
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
