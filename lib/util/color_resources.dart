import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:play_tv/provider/theme_provider.dart';

class ColorResources {


  static Color getDeepForestBrown(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF393636)
        : Color(0xFF393636);
  }

  static Color getRedRadish(BuildContext context) {
  return Provider.of<ThemeProvider>(context).darkTheme
  ? Color(0xFFEB3045)
      : Color(0xFFEB3045);
  }


    static Color getTobikoOrange(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFFE05F0B)
        : Color(0xFFE05F0B);
  }

  static Color getWhite(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFFFFFFFF)
        : Color(0xFFFFFFFF);
  }
  static Color getSoothingSapphire(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF2884DB)
        : Color(0xFF2884DB);
  }


  static const TextStyle tvScreenFontStyle = TextStyle(
    color: ColorResources.WHITE,
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );

  static Color PRIMARY_COLOR = Color(0xFFC90404).withOpacity(0.7);
  static const Color BLACK = Color(0xff000000);
  static const Color WHITE = Color(0xffFFFFFF);
  static const Color LIGHT_SKY_BLUE = Color(0xff8DBFF6);
  static const Color HARLEQUIN = Color(0xff3FCC01);
  static const Color CERISE = Color(0xffE2206B);
  static const Color GREY = Color(0xffF1F1F1);
  static const Color RED = Color(0xFFD32F2F);
  static const Color YELLOW = Color(0xFFFFAA47);
  static const Color HINT_TEXT_COLOR = Color(0xff9E9E9E);
  static const Color GAINS_BORO = Color(0xffE6E6E6);
  static const Color TEXT_BG = Color(0xffF3F9FF);
  static const Color ICON_BG = Color(0xffF9F9F9);
  static const Color HOME_BG = Color(0xffF0F0F0);
  static const Color IMAGE_BG = Color(0xffE2F0FF);
  static const Color SELLER_TXT = Color(0xff92C6FF);
  static const Color CHAT_ICON_COLOR = Color(0xffD4D4D4);
  static const Color LOW_GREEN = Color(0xffEFF6FE);
  static const Color GREEN = Color(0xff23CB60);
  static const Color COLOR_PRIMARY = Color(0xff4732A7);
  static const Color COLOR_ACCENT = Color(0xFFFF742E);
  static const Color SILVER_GREY = Color(0xFF969AA8);
  static const Color lightGolden = Color(0xffFEEAD1);
  static const Color lightGrey = Color.fromRGBO(239, 239, 239, 1);


}
