// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';

class AppFonts {
  static TextStyle poppinsFont(textStyle) {
    return GoogleFonts.poppins(textStyle: textStyle);
  }

  static TextStyle mazzardFont(textStyle) {
    return GoogleFonts.poppins(textStyle: textStyle);
  }
}

Widget buildTextSpan(firstText, secondText) {
  return Text.rich(TextSpan(
      text: '$firstText ',
      style: AppFonts.poppinsFont(TextStyle(
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColorBlue,
          fontSize: AppFontSize.font24)),
      children: <InlineSpan>[
        TextSpan(
          text: '$secondText',
          style: AppFonts.poppinsFont(TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.primaryColorBlue,
              fontSize: AppFontSize.font24)),
        )
      ]));
}
