// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/edit_profile_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';

class EditProfilePage2 extends StatefulWidget {
  const EditProfilePage2({Key? key}) : super(key: key);

  @override
  State<EditProfilePage2> createState() => _EditProfilePage2State();
}

class _EditProfilePage2State extends State<EditProfilePage2> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileProvider>(
      create: (_) {
        return EditProfileProvider();
      },
      child: Consumer<EditProfileProvider>(
        builder: (context, provider, child) {
          return SafeArea(
              child: Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: AppColors.secondaryColorWhite,
              // leading: InkWell(
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   child: Image(
              //     image: AssetImage(AppIconImages.backIconImg),
              //     height: AppFontSize.font24,
              //     width: AppFontSize.font24,
              //   ),
              // ),
              iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
              centerTitle: true,
              title: Text(AppStrings.strEditProfile,
                  style: AppFonts.mazzardFont(TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColorBlue,
                      fontSize: AppFontSize.font18))),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppFontSize.font12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    provider.buildText(AppStrings.strGender),
                    SizedBox(height: AppFontSize.font12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        provider.genderContainer(
                            AppIconImages.mGenderImg, AppStrings.strMale),
                        provider.genderContainer(
                            AppIconImages.fGenderImg, AppStrings.strFemale),
                        provider.genderContainer(
                            AppIconImages.oGenderImg, AppStrings.strOther),
                      ],
                    ),
                    SizedBox(height: AppFontSize.font12),
                    provider.buildText(AppStrings.strDOB),
                    SizedBox(height: AppFontSize.font12),
                    Container(
                      // height: AppFontSize.font45,
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColorWhite,
                          border: Border.all(
                              color: AppColors.infoPageCount, width: 1),
                          borderRadius:
                              BorderRadius.circular(AppFontSize.font12)),
                      child: Center(
                        child: TextFormField(
                            onTap: () {
                              provider.selectDobDate(context);
                            },
                            controller: provider.dobController,
                            readOnly: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppStrings.strSelect,
                                contentPadding:
                                    EdgeInsets.fromLTRB(14, 14, 10, 10),
                                hintStyle: AppFonts.poppinsFont(TextStyle(
                                    fontSize: AppFontSize.font14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.infoPageCount)),
                                suffixIcon: Align(
                                    widthFactor: 1,
                                    heightFactor: 1,
                                    child: InkWell(
                                      onTap: () {
                                        provider.selectDobDate(context);
                                      },
                                      child: Image(
                                        image: AssetImage(
                                            AppIconImages.calendarIconImg),
                                        height: AppFontSize.font24,
                                        width: AppFontSize.font24,
                                      ),
                                    )))),
                      ),
                    ),
                    SizedBox(height: AppFontSize.font12),
                    provider.buildText(AppStrings.strHeight),
                    SizedBox(height: AppFontSize.font12),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: BoxDecoration(
                                color: AppColors.secondaryColorWhite,
                                border: Border.all(
                                    color: AppColors.infoPageCount, width: 1),
                                borderRadius:
                                    BorderRadius.circular(AppFontSize.font12)),
                            child: Center(
                              child: TextFormField(
                                  controller: provider.feetHeightController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0' Feet",
                                    contentPadding:
                                        EdgeInsets.fromLTRB(14, 14, 10, 10),
                                    hintStyle: AppFonts.poppinsFont(TextStyle(
                                        fontSize: AppFontSize.font14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.infoPageCount)),
                                  )),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            decoration: BoxDecoration(
                                color: AppColors.secondaryColorWhite,
                                border: Border.all(
                                    color: AppColors.infoPageCount, width: 1),
                                borderRadius:
                                    BorderRadius.circular(AppFontSize.font12)),
                            child: Center(
                              child: TextFormField(
                                  controller: provider.inchFeetController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "0'' Inches",
                                    contentPadding:
                                        EdgeInsets.fromLTRB(14, 14, 10, 10),
                                    hintStyle: AppFonts.poppinsFont(TextStyle(
                                        fontSize: AppFontSize.font14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.infoPageCount)),
                                  )),
                            ),
                          ),
                        ]),
                    SizedBox(height: AppFontSize.font150),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: AppButtons.elevatedButton(
                                  AppStrings.strBack.toUpperCase(),
                                  AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColorBlue,
                                      fontSize: AppFontSize.font16)),
                                  AppColors.primaryColorSkyBlue)),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.editProfilePage3);
                          },
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: AppButtons.elevatedButton(
                                  AppStrings.strNext.toUpperCase(),
                                  AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryColorWhite,
                                      fontSize: AppFontSize.font16)),
                                  AppColors.primaryColorBlue)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
