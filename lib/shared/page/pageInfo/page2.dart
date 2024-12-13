// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(AppFontSize.font10),
          child: Column(
            children: [
              Text(AppStrings.strConnectNearbyPlayers,
                  style: AppFonts.mazzardFont(TextStyle(
                      fontSize: AppFontSize.font18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.secondaryColorBlack))),
              SizedBox(height: AppFontSize.font10),
              Text(
                  "Find tennis players of similar skill as you and invite them to play!",
                  textAlign: TextAlign.center,
                  style: AppFonts.poppinsFont(TextStyle(
                      fontSize: AppFontSize.font16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.infoPageText))),
              SizedBox(height: AppFontSize.font20),
              Image(
                image: AssetImage(AppImages.playInfoImg2),
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
