import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/font_size.dart';

class AppButtons {
  static Container elevatedButton(text, textStyle, btnColor, {border}) {
    return Container(
      height: AppFontSize.font45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppFontSize.font10),
          border: Border.all(color: border ?? btnColor),
          color: btnColor),
      child: Center(child: Text(text, style: textStyle)),
    );
  }
}
