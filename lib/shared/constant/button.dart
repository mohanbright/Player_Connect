// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';

class AppButtons {
  static Container elevatedButton(text, textStyle, btnColor, {border}) {
    return Container(
      height: AppFontSize.font40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppFontSize.font10),
          border: Border.all(color: border ?? btnColor),
          color: btnColor),
      child: Center(child: Text(text, style: textStyle)),
    );
  }

  static Widget appBarButton() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.primaryColorBlue),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
          child: Text(
            "SAVE",
            style: AppFonts.mazzardFont(TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryColorWhite,
                fontSize: AppFontSize.font14)),
          ),
        ),
      ),
    );
  }
}
