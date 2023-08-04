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
import 'package:player_connect/shared/widget/alert_box.dart';
import 'package:provider/provider.dart';

class CreateProfilePage4 extends StatefulWidget {
  const CreateProfilePage4({Key? key}) : super(key: key);

  @override
  State<CreateProfilePage4> createState() => _CreateProfilePage4State();
}

class _CreateProfilePage4State extends State<CreateProfilePage4> {
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
                      horizontal: AppFontSize.font12,
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
                      Text(AppStrings.strTellAboutGame,
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
                              backgroundColor:
                                  AppColors.secondaryColorLightGrey,
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
                      SizedBox(height: AppFontSize.font10),
                      provider.buildText(AppStrings.strHaveUtr),
                      Row(
                        children: [
                          Container(
                            width: 150,
                            child: RadioListTile(
                              contentPadding: EdgeInsets.all(0),
                              visualDensity: VisualDensity.compact,
                              activeColor: AppColors.primaryColorSkyBlue,
                              title: Text(AppStrings.strYes),
                              value: true,
                              groupValue: provider.isUtrRating,
                              onChanged: (value) {
                                provider.getBoolUtrRating(value as bool);
                              },
                            ),
                          ),
                          Container(
                            width: 150,
                            child: RadioListTile(
                              contentPadding: EdgeInsets.all(0),
                              activeColor: AppColors.primaryColorSkyBlue,
                              title: Text(AppStrings.strNo),
                              value: false,
                              groupValue: provider.isUtrRating,
                              onChanged: (value) {
                                provider.getBoolUtrRating(value as bool);
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppFontSize.font14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          provider.buildText(provider.isUtrRating
                              ? AppStrings.strUtrRating
                              : AppStrings.strNtrpRating),
                          SizedBox(width: AppFontSize.font4),
                          provider.isUtrRating
                              ? SizedBox()
                              : Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialogWidget(
                                                provider: provider,
                                              );
                                            });
                                      },
                                      child: Image(
                                        image: AssetImage(
                                            AppIconImages.helpIconImg),
                                        height: AppFontSize.font20,
                                        width: AppFontSize.font20,
                                      ),
                                    ),
                                    SizedBox(width: AppFontSize.font4),
                                    Text(AppStrings.strNotSureRatingIs,
                                        style: AppFonts.mazzardFont(TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.infoPageCount,
                                            fontSize: AppFontSize.font14))),
                                  ],
                                ),
                          Spacer(),
                          provider.isUtrRating
                              ? Text(provider.userUtrRating.toString(),
                                  style: AppFonts.poppinsFont(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryColorBlack,
                                      fontSize: AppFontSize.font14)))
                              : Text(provider.userNtrpRating.toString(),
                                  style: AppFonts.poppinsFont(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryColorBlack,
                                      fontSize: AppFontSize.font14)))
                        ],
                      ),
                      SizedBox(height: AppFontSize.font12),
                      Container(
                        width: MediaQuery.of(context).size.width -
                            (AppFontSize.font24 + AppFontSize.font24),
                        child: Slider(
                          min: 0.0,
                          max: 16.5,
                          // allowedInteraction: SliderInteraction.tapAndSlide,
                          thumbColor: AppColors.secondaryColorBlack,
                          activeColor: AppColors.primaryColorBlue,
                          inactiveColor: AppColors.infoPageCount,
                          value: provider.isUtrRating
                              ? provider.userUtrRating
                              : provider.userNtrpRating,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onChangeEnd: (value) {
                            debugPrint(value.toStringAsFixed(1));
                            provider.isUtrRating
                                ? provider.userUtrRating =
                                    double.parse(value.toStringAsFixed(1))
                                : provider.userNtrpRating =
                                    double.parse(value.toStringAsFixed(1));
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(height: AppFontSize.font16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          provider.buildText(AppStrings.strMaxDriveDistance),
                          Text(
                              "${provider.userMaxDrivDis} '${AppStrings.strMiles}",
                              style: AppFonts.poppinsFont(TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryColorBlack,
                                  fontSize: AppFontSize.font14)))
                        ],
                      ),
                      SizedBox(height: AppFontSize.font12),
                      Container(
                        width: MediaQuery.of(context).size.width -
                            (AppFontSize.font24 + AppFontSize.font24),
                        child: Slider(
                          min: 0.0,
                          max: 50,
                          // allowedInteraction: SliderInteraction.tapAndSlide,
                          thumbColor: AppColors.secondaryColorBlack,

                          activeColor: AppColors.primaryColorBlue,
                          inactiveColor: AppColors.infoPageCount,
                          value: provider.userMaxDrivDis,
                          onChanged: (value) {
                            setState(() {});
                          },
                          onChangeEnd: (value) {
                            debugPrint(value.toStringAsFixed(1));
                            provider.userMaxDrivDis =
                                double.parse(value.toStringAsFixed(1));
                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(height: AppFontSize.font14),
                      provider.buildText(AppStrings.strDesiredpartner),
                      SizedBox(height: AppFontSize.font12),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.secondaryColorWhite,
                            border: Border.all(
                                color: AppColors.infoPageCount, width: 1),
                            borderRadius:
                                BorderRadius.circular(AppFontSize.font12)),
                        child: Center(
                          child: TextFormField(
                              controller: provider.desiredPartnerController,
                              maxLines: 7,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppStrings.strWhatLookingFor,
                                contentPadding:
                                    EdgeInsets.fromLTRB(14, 14, 10, 10),
                                hintStyle: AppFonts.poppinsFont(TextStyle(
                                    fontSize: AppFontSize.font14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.infoPageCount)),
                              )),
                        ),
                      ),
                      SizedBox(height: AppFontSize.font50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
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
                              if (provider.desiredPartnerController.text
                                  .trim()
                                  .isEmpty) {
                                AppSnackBarToast.buildShowSnackBar(
                                    context, AppStrings.strDesiredpartner);
                              } else {
                                LocalDataSaver.saveUserIsUtr(
                                    provider.isUtrRating);
                                LocalDataSaver.saveUserUtr(
                                    provider.userUtrRating.toString());
                                LocalDataSaver.saveUserNtrp(
                                    provider.userNtrpRating.toString());
                                LocalDataSaver.saveUserDriDis(
                                    provider.userMaxDrivDis.toString());
                                LocalDataSaver.saveUserDesPart(
                                    provider.desiredPartnerController.text);
                                await fetchDataSPreferences();

                                provider.setProgressTask(4);
                                provider.setProgressBar(0.8);

                                progressTaskValue > 1.0
                                    ? null
                                    : progressTaskValue = 1.0;
                                progressTaskDone > 5
                                    ? null
                                    : progressTaskDone = 5;
                                Navigator.pushNamed(
                                    context, AppRoutes.createProfilePage5);
                              }
                            },
                            child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                child: AppButtons.elevatedButton(
                                    "NEXT",
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
            ),
          );
        },
      ),
    );
  }
}
