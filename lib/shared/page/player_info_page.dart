// ignore_for_file: prefer_const_constructors, avoid_print, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/page/pageInfo/page1.dart';
import 'package:player_connect/shared/page/pageInfo/page2.dart';
import 'package:player_connect/shared/page/pageInfo/page3.dart';

class PlayerInfoPage extends StatefulWidget {
  const PlayerInfoPage({Key? key}) : super(key: key);

  @override
  State<PlayerInfoPage> createState() => _PlayerInfoPageState();
}

class _PlayerInfoPageState extends State<PlayerInfoPage> {
  PageController pageController = PageController(initialPage: 0);
  int index = 0;
  late Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (index < 2) {
        index++;
      } else {
        index = 0;
      }
      pageController.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight(MediaQuery.of(context).size.height);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: AppFontSize.font20, horizontal: AppFontSize.font10),
              child: Column(
                children: [
                  Image(
                      image: AssetImage(AppImages.splashPageLogo),
                      height: AppFontSize.font40),
                  SizedBox(height: AppFontSize.font20),
                  Container(
                    height: AppFontSize.font300 +
                        AppFontSize.font180 +
                        AppFontSize.font10,
                    child: PageView(
                      controller: pageController,
                      onPageChanged: (value) {
                        index = value;
                        setState(() {});
                      },
                      children: [
                        Page1(),
                        Page2(),
                        Page3(),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: AppFontSize.font8,
                        width:
                            index == 0 ? AppFontSize.font32 : AppFontSize.font8,
                        decoration: BoxDecoration(
                            color: index == 0
                                ? AppColors.primaryColorSkyBlue
                                : AppColors.infoPageCount,
                            borderRadius:
                                BorderRadius.circular(AppFontSize.font6)),
                      ),
                      SizedBox(width: AppFontSize.font8),
                      Container(
                        height: AppFontSize.font8,
                        width:
                            index == 1 ? AppFontSize.font32 : AppFontSize.font8,
                        decoration: BoxDecoration(
                            color: index == 1
                                ? AppColors.primaryColorSkyBlue
                                : AppColors.infoPageCount,
                            borderRadius:
                                BorderRadius.circular(AppFontSize.font6)),
                      ),
                      SizedBox(width: AppFontSize.font8),
                      Container(
                        height: AppFontSize.font8,
                        width:
                            index == 2 ? AppFontSize.font32 : AppFontSize.font8,
                        decoration: BoxDecoration(
                            color: index == 2
                                ? AppColors.primaryColorSkyBlue
                                : AppColors.infoPageCount,
                            borderRadius:
                                BorderRadius.circular(AppFontSize.font6)),
                      ),
                    ],
                  ),
                  SizedBox(height: AppFontSize.font20),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.loginPage, (route) => false);
                    },
                    child: AppButtons.elevatedButton(
                        AppStrings.strGetStarted,
                        AppFonts.poppinsFont(TextStyle(
                            fontSize: AppFontSize.font16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.secondaryColorWhite)),
                        AppColors.primaryColorBlue),
                  ),
                  SizedBox(height: AppFontSize.font4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
