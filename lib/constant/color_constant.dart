import 'package:flutter/material.dart';

class ColorConstant {

  

  static Color primaryColor = fromHex('#1e5584').withOpacity(0.9);
  static Color primaryColor2 = fromHex('#EBE6E0');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static const Color kWhite = Color(0xffFFFFFF);
  static const Color kRedColor = Color(0xffFF2526);
  static const Color kYellowColor = Color(0xffFFC03C);
  static const Color kBorderColor = Color(0xffDDDDDD);
}
