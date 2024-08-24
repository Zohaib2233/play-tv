import 'package:flutter/material.dart';
import 'package:play_tv/provider/theme_provider.dart';
import 'package:play_tv/util/custom_themes.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String buttonText;
  Color buttonColor;
  Color textColor;

  CustomButton(
      {this.onTap,
      required this.buttonText,
      this.buttonColor = const Color(0xFF42BEA5),
      this.textColor = const Color(0xFF42BEA5)});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: buttonColor,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: Offset(0, 1)), // changes position of shadow
            ],
            gradient:
                (Provider.of<ThemeProvider>(context).darkTheme || onTap == null)
                    ? null
                    : LinearGradient(colors: [
                        buttonColor,
                        buttonColor,
                        buttonColor,
                      ]),
            borderRadius: BorderRadius.circular(6)),
        child: Text(buttonText,
            style: robotoRegular.copyWith(
              fontSize: 16,
              color: textColor,
            )),
      ),
    );
  }
}
