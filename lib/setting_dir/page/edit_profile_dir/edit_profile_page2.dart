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
    return Consumer<EditProfileProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.bgColor,
                appBar: provider.buildAppBar(context, 2),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(AppFontSize.font12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        provider.buildText("Gender"),
                        SizedBox(height: AppFontSize.font12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            provider.genderContainer(
                                AppIconImages.mGenderImg, "Male"),
                            provider.genderContainer(
                                AppIconImages.fGenderImg, "Female"),
                            provider.genderContainer(
                                AppIconImages.oGenderImg, "Other"),
                          ],
                        ),
                        SizedBox(height: AppFontSize.font12),
                        provider.buildText("Date of Birth"),
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
                                onChanged: (value) {
                                  provider.isChanged = true;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Select",
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
                        provider.buildText("Height"),
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
                                    borderRadius: BorderRadius.circular(
                                        AppFontSize.font12)),
                                child: Center(
                                  child: TextFormField(
                                      controller: provider.feetHeightController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 1,
                                      onChanged: (value) {
                                        provider.isChanged = true;
                                      },
                                      decoration: InputDecoration(
                                        counterText: "",
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
                                    borderRadius: BorderRadius.circular(
                                        AppFontSize.font12)),
                                child: Center(
                                  child: TextFormField(
                                      controller: provider.inchFeetController,
                                      keyboardType: TextInputType.number,
                                      maxLength: 2,
                                      onChanged: (value) {
                                        provider.isChanged = true;
                                      },
                                      decoration: InputDecoration(
                                        counterText: "",
                                        border: InputBorder.none,
                                        hintText: "0'' ${AppStrings.strInches}",
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
                                          fontSize: AppFontSize.font14)),
                                      AppColors.primaryColorSkyBlue)),
                            ),
                            InkWell(
                              onTap: () {
                                provider.getHeightCm();
                                if (provider.isChanged == true) {
                                  Navigator.pushNamed(
                                      context, AppRoutes.editProfilePage3);
                                  provider.isChanged = false;
                                } else {
                                  Navigator.pushNamed(
                                      context, AppRoutes.editProfilePage3);
                                }
                              },
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  child: AppButtons.elevatedButton(
                                      AppStrings.strNext.toUpperCase(),
                                      AppFonts.mazzardFont(TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondaryColorWhite,
                                          fontSize: AppFontSize.font14)),
                                      AppColors.primaryColorBlue)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: provider.isLoading,
                  child: Scaffold(
                    backgroundColor: Colors.black26,
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
