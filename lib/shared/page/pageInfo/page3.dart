// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';

class Page3 extends StatefulWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppFontSize.font10),
          child: Column(
            children: [
              Text(AppStrings.strChatWithPlayers,
                  style: AppFonts.mazzardFont(TextStyle(
                      fontSize: AppFontSize.font18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondaryColorBlack))),
              SizedBox(height: AppFontSize.font10),
              Text(
                  "Once you match with a local player, PlayerConnect makes it easy to chat with them and coordinate.",
                  textAlign: TextAlign.center,
                  style: AppFonts.poppinsFont(TextStyle(
                      fontSize: AppFontSize.font16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.infoPageText))),
              SizedBox(height: AppFontSize.font20),
              Image(
                image: AssetImage(AppImages.playInfoImg3),
                height: AppFontSize.font300 + AppFontSize.font20,
                width: AppFontSize.font300 + AppFontSize.font20,
              ),
              SizedBox(height: AppFontSize.font10),
            ],
          ),
        ),
      ),
    );
  }
}
