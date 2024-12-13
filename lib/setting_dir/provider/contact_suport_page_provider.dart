import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';

class ContactSupportPageProvider extends ChangeNotifier {
  TextEditingController dropDownController = TextEditingController();
  TextEditingController queryController = TextEditingController();
  String? selectedValue;

  Widget buildText(title) {
    return Text(title,
        style: AppFonts.mazzardFont(TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryColorBlack,
            fontSize: AppFontSize.font14)));
  }
}
