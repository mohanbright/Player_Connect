import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';

class ConnectProvider extends ChangeNotifier {
  bool isLoading = true;
  List utrList = [
    7.6,
    7.9,
    8.4,
    8.0,
    7.7,
    8.2,
  ];

  List imgList = [
    AppImages.playerRecc,
  ];
  List nameList = [
    "Doris Edwards",
    "Steve Jones",
    "Lori Anderson",
    "Mark Torres",
    "Earl Taylor",
    "Earl Taylor",
  ];

  List addressList = [
    "New Lamont, DE",
  ];
  List pointList = [
    8.0,
  ];
  List shortNameList = [
    "UTR",
  ];
  Widget buildText(text) {
    return Text(text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppFonts.mazzardFont(TextStyle(
            fontSize: AppFontSize.font10,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryColorBlack)));
  }
}
