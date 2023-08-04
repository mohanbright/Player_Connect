// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/auth/routes.dart';

class VerifiedPage extends StatefulWidget {
  const VerifiedPage({Key? key}) : super(key: key);

  @override
  State<VerifiedPage> createState() => _VerifiedPageState();
}

class _VerifiedPageState extends State<VerifiedPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: AppFontSize.font24, vertical: AppFontSize.font20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppFontSize.font24),
              Image(
                image: AssetImage(AppImages.appLogo),
                height: AppFontSize.font60,
                width: AppFontSize.font70,
                fit: BoxFit.contain,
              ),
              SizedBox(height: AppFontSize.font24),
              buildTextSpan(AppStrings.strThank, AppStrings.strYou),
              SizedBox(height: AppFontSize.font35),
              Text(AppStrings.strAccountVerified,
                  style: AppFonts.poppinsFont(TextStyle(
                      fontSize: AppFontSize.font16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryColorBlack))),
              SizedBox(height: AppFontSize.font20),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.createProfilePage1);
                },
                child: Text(AppStrings.strProceedToAccount,
                    style: AppFonts.poppinsFont(TextStyle(
                        fontSize: AppFontSize.font16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColorBlue))),
              ),
              SizedBox(height: AppFontSize.font20),
            ],
          ),
        ),
      ),
    ));
  }
}
