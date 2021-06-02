import 'package:flutter/material.dart';

///This class is used to use common awarebox colors
class RegistrationColors {
  static Color backgroundLight = HexColor('#FFFFFF');
  static Color backgroundDark = HexColor('#333333');
  static Color backgroundGray = HexColor('#F5F5F5');

  static Color appTitle = HexColor('#333333');
  static Color title = HexColor('#333333');
  static Color transparentBG = Colors.transparent;
  static Color blackColor = HexColor('#000000');
  static Color whiteBG = HexColor('#FFFFFF');
  static Color grayDropShadow = HexColor("#DCDCDC");

}

///This class is used to use convert 'hex color' in 'color'
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
