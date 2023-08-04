import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';

class ChatProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  List utrList = [
    7.6,
    13,
    13,
    13,
    13,
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
    "Doris Edwards",
    "Steve Jones",
    "Lori Anderson",
    "Mark Torres",
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
  List btnList = [
    "Connect",
    "Connect",
    "Connect",
    "Connect",
    "Connect",
    "Connect",
    "Connect",
    "Connect",
    "Connect",
    "Connect",
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
