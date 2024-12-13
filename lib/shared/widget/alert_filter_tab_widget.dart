// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:provider/provider.dart';

import '../../setting_dir/page/edit_profile_dir/edit_profile_page4.dart';

class AlertFilterTabWidget extends StatefulWidget {
  const AlertFilterTabWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AlertFilterTabWidget> createState() => _AlertFilterTabWidgetState();
}

class _AlertFilterTabWidgetState extends State<AlertFilterTabWidget> {
  int tabWidget = 1;
  double? utrRating = 0;
  double? ntrpRating = 0;
  double? userDistance = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppStrings.strFilter.toUpperCase(),
          textAlign: TextAlign.center,
          style: AppFonts.mazzardFont(TextStyle(
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColorBlue,
              fontSize: AppFontSize.font18))),
      content: SingleChildScrollView(
        child: Container(
            height: AppFontSize.font200 + AppFontSize.font50,
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        tabWidget = 1;
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          Text(AppStrings.strUtr.toUpperCase(),
                              style: AppFonts.mazzardFont(TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: tabWidget == 1
                                      ? AppColors.primaryColorBlue
                                      : AppColors.primaryColorSkyBlue,
                                  fontSize: tabWidget == 1
                                      ? AppFontSize.font16
                                      : AppFontSize.font14))),
                          SizedBox(
                              height: tabWidget == 1
                                  ? AppFontSize.font6
                                  : AppFontSize.font10),
                          Container(
                            height: 2,
                            color: tabWidget == 1
                                ? AppColors.primaryColorBlue
                                : AppColors.infoPageCount,
                            width: MediaQuery.of(context).size.width / 3.2,
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        tabWidget = 2;
                        setState(() {});
                      },
                      child: Column(
                        children: [
                          InkWell(
                              child: Text(AppStrings.strNtrp.toUpperCase(),
                                  style: AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: tabWidget == 2
                                          ? AppColors.primaryColorBlue
                                          : AppColors.primaryColorSkyBlue,
                                      fontSize: tabWidget == 2
                                          ? AppFontSize.font16
                                          : AppFontSize.font14)))),
                          SizedBox(
                              height: tabWidget == 2
                                  ? AppFontSize.font6
                                  : AppFontSize.font10),
                          Container(
                            height: 2,
                            color: tabWidget == 2
                                ? AppColors.primaryColorBlue
                                : AppColors.infoPageCount,
                            width: MediaQuery.of(context).size.width / 3.2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                tabWidget == 1
                    ? Column(
                        children: [
                          SizedBox(height: AppFontSize.font12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppStrings.strUtrRating,
                                  style: AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryColorBlack,
                                      fontSize: AppFontSize.font14))),
                              Spacer(),
                              SizedBox(
                                width: 100,
                                height: 25,
                                child: Text(utrRating!.toStringAsFixed(1),
                                    textAlign: TextAlign.right,
                                    style: AppFonts.poppinsFont(TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryColorBlack,
                                        fontSize: AppFontSize.font14))),
                              )
                            ],
                          ),
                          SizedBox(height: AppFontSize.font12),


                          Container(
                            width: MediaQuery.of(context).size.width - (AppFontSize.font24 + AppFontSize.font24),
                            child: CustomSlider(
                              min: 0.0,
                              max: 16.5,
                              value: utrRating!,
                              onChanged: (value) {
                                utrRating = value;
                                setState(() {});
                              },
                              onChangeEnd: (value) {
                                utrRating = double.parse(value.toStringAsFixed(1));
                                setState(() {});
                              },
                            ),
                          ),


                          SizedBox(height: AppFontSize.font12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppStrings.strDistanceFromMe,
                                  style: AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryColorBlack,
                                      fontSize: AppFontSize.font14))),
                              Spacer(),
                              SizedBox(
                                width: 100,
                                height: 25,
                                child: Text(
                                  "${userDistance?.toInt()} ${AppStrings.strMiles}",
                                  textAlign: TextAlign.right,
                                  style: AppFonts.poppinsFont(
                                    TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryColorBlack,
                                      fontSize: AppFontSize.font14,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: AppFontSize.font12),

                          Container(
                            width: MediaQuery.of(context).size.width - (AppFontSize.font24 + AppFontSize.font24),
                            child: CustomSlider(
                              min: 0.0,
                              max: 50,
                              value: userDistance!,
                              onChanged: (value) {
                                userDistance = value;
                                setState(() {});
                              },
                              onChangeEnd: (value) {
                                userDistance = double.parse(value.toStringAsFixed(1));
                                setState(() {});
                              },
                              // stringAsFixed : 0,
                            ),
                          ),

                          SizedBox(height: AppFontSize.font12),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(height: AppFontSize.font12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppStrings.strNtrpRating,
                                  style: AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryColorBlack,
                                      fontSize: AppFontSize.font14))),
                              Spacer(),
                              SizedBox(
                                width: 100,
                                height: 25,
                                child: Text(ntrpRating!.toStringAsFixed(1),
                                    textAlign: TextAlign.right,
                                    style: AppFonts.poppinsFont(TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryColorBlack,
                                        fontSize: AppFontSize.font14))),
                              )
                            ],
                          ),

                          SizedBox(height: AppFontSize.font12),

                          Container(
                            width: MediaQuery.of(context).size.width - (AppFontSize.font24 + AppFontSize.font24),
                            child: CustomSlider(
                              min: 0.0,
                              max: 7,
                              value: ntrpRating!,
                              onChanged: (value) {
                                ntrpRating = value;
                                setState(() {});
                              },
                              onChangeEnd: (value) {
                                ntrpRating = double.parse(value.toStringAsFixed(1));
                                setState(() {});
                              },
                            ),
                          ),

                          SizedBox(height: AppFontSize.font12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppStrings.strDistanceFromMe,
                                  style: AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryColorBlack,
                                      fontSize: AppFontSize.font14))),
                              Spacer(),
                              SizedBox(
                                width: 100,
                                height: 25,
                                child: Text("${userDistance?.toInt()} ${AppStrings.strMiles}",
                                    textAlign: TextAlign.right,
                                    style: AppFonts.poppinsFont(TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryColorBlack,
                                        fontSize: AppFontSize.font14),
                                    ),
                                ),
                              )
                            ],
                          ),

                          SizedBox(height: AppFontSize.font12),

                          Container(
                            width: MediaQuery.of(context).size.width - (AppFontSize.font24 + AppFontSize.font24),
                            child: CustomSlider(
                              min: 0.0,
                              max: 50,
                              value: userDistance!,
                              onChanged: (value) {
                                userDistance = value;
                                setState(() {});
                              },
                              onChangeEnd: (value) {
                                userDistance = double.parse(value.toStringAsFixed(1));
                                setState(() {});
                              },
                            ),
                          ),



                          SizedBox(height: AppFontSize.font12),
                        ],
                      )
              ],
            )),
      ),
      actions: <Widget>[
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {isRatingsData = false;
                  setState(() {});
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: AppButtons.elevatedButton(
                          AppStrings.strCancel.toUpperCase(),
                          AppFonts.mazzardFont(TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColorBlue,
                              fontSize: AppFontSize.font14)),
                          AppColors.primaryColorSkyBlue)),
                ),
                InkWell(
                  onTap: () {
                    isRatingsData = true;
                    setState(() {});
                    Provider.of<PlayerProvider>(context, listen: false)
                        .searchApi(context,
                            name: "",
                            uRating: tabWidget == 1
                                ? int.parse(utrRating!.toStringAsFixed(0))
                                : null,
                            nRating: tabWidget != 1
                                ? int.parse(ntrpRating!.toStringAsFixed(0))
                                : null,
                            distance:
                                int.parse(userDistance!.toStringAsFixed(0)));

                    // print(tabWidget != 1 ? int.parse(ntrpRating!.toStringAsFixed(0)) : -1);

                    Navigator.pop(context);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: AppButtons.elevatedButton(
                          AppStrings.strFilter.toUpperCase(),
                          AppFonts.mazzardFont(TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryColorWhite,
                              fontSize: AppFontSize.font14)),
                          AppColors.primaryColorBlue)),
                ),
              ],
            ),
            SizedBox(height: AppFontSize.font20),
          ],
        ),
      ],
    );
  }
}
