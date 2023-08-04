// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:player_connect/login_dir/provider/create_profile_provider.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';

class CreateProfilePage2 extends StatefulWidget {
  const CreateProfilePage2({Key? key}) : super(key: key);

  @override
  State<CreateProfilePage2> createState() => _CreateProfilePage2State();
}

class _CreateProfilePage2State extends State<CreateProfilePage2> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateProfileProvider>(
      create: (_) {
        return CreateProfileProvider();
      },
      child: Consumer<CreateProfileProvider>(
        builder: (context, provider, child) {
          return SafeArea(
              child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppFontSize.font24,
                    vertical: AppFontSize.font20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image(
                      image: AssetImage(AppImages.appLogo),
                      height: AppFontSize.font50,
                      width: AppFontSize.font60,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: AppFontSize.font24),
                    Text(AppStrings.strWhatsGenderHeight,
                        style: AppFonts.mazzardFont(TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColorBlue,
                            fontSize: AppFontSize.font16))),
                    SizedBox(height: AppFontSize.font20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            // value: provider.completeProgressBar,
                            value: progressTaskValue,
                            color: AppColors.primaryColorSkyBlue,
                            minHeight: AppFontSize.font8,
                            backgroundColor: AppColors.secondaryColorLightGrey,
                            // borderRadius:
                            // BorderRadius.circular(AppFontSize.font4),
                          ),
                        ),
                        SizedBox(width: AppFontSize.font14),
                        Text.rich(TextSpan(
                            // text: '${provider.completeTaskValue}',
                            text: '$progressTaskDone',
                            style: AppFonts.poppinsFont(TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColorBlue,
                                fontSize: AppFontSize.font16)),
                            children: <InlineSpan>[
                              TextSpan(
                                text: '/5',
                                style: AppFonts.poppinsFont(TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryColorBlue,
                                    fontSize: AppFontSize.font16)),
                              )
                            ])),
                      ],
                    ),
                    SizedBox(height: AppFontSize.font20),
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
                                  maxLength: 1,
                                  keyboardType: TextInputType.number,
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
                                borderRadius:
                                    BorderRadius.circular(AppFontSize.font12)),
                            child: Center(
                              child: TextFormField(
                                  controller: provider.inchFeetController,
                                  maxLength: 2,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    counterText: "",
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
                    SizedBox(height: AppFontSize.font90),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            // provider.setProgressTask(2);
                            // provider.setProgressBar(0.4);
                            Navigator.pop(context);
                          },
                          child: Container(
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
                          onTap: () async {
                            debugPrint(
                                "object:::::${provider.firstNameController.text}");

                            if (provider.selectedGender == null) {
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strSelectGender);
                            } else if (provider.dobController.text
                                .trim()
                                .isEmpty) {
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strSelectDob);
                            } else if (provider.feetHeightController.text
                                .trim()
                                .isEmpty) {
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strEnterHeightInFeet);
                            } else if (provider.inchFeetController.text
                                .trim()
                                .isEmpty) {
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strEnterHeightInFeet);
                            } else if (double.parse(provider
                                    .inchFeetController.text
                                    .toString()) >
                                11) {
                              AppSnackBarToast.buildShowSnackBar(context,
                                  AppStrings.strEnterValidHeightInInches);
                            } else {
                              double heightInCm = (double.parse(provider
                                          .feetHeightController.text
                                          .trim()) *
                                      30.48) +
                                  (double.parse(provider.inchFeetController.text
                                          .trim()) *
                                      2.54);

                              // provider.setProgressTask(3);
                              // provider.completeTaskValue=2;
                              LocalDataSaver.saveUserHeight(
                                  "${provider.feetHeightController.text.trim()}'${provider.inchFeetController.text.trim()}''");
                              LocalDataSaver.saveUserGender(
                                  provider.selectedGender);
                              LocalDataSaver.saveUserAge(
                                  provider.age.toString());
                              LocalDataSaver.saveUserDob(
                                  provider.dobController.text);
                              LocalDataSaver.saveUserHeightCm(
                                  heightInCm.toString());
                              await fetchDataSPreferences();
                              provider.setProgressBar(0.6);

                              progressTaskValue > 0.6
                                  ? null
                                  : progressTaskValue = 0.6;
                              progressTaskDone > 3
                                  ? null
                                  : progressTaskDone = 3;

                              Navigator.pushNamed(
                                  context, AppRoutes.createProfilePage3);
                            }
                          },
                          child: Container(
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
