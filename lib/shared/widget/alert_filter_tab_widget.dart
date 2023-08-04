// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, deprecated_member_use, must_be_immutable

import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';

class AlertFilterTabWidget extends StatefulWidget {
  const AlertFilterTabWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<AlertFilterTabWidget> createState() => _AlertFilterTabWidgetState();
}

class _AlertFilterTabWidgetState extends State<AlertFilterTabWidget> {
  int tabWidget = 1;
  double? utrRating = 0.0;
  double? ntrpRating = 0.0;
  double? userDistance = 0.0;

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
                              Text(utrRating.toString(),
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
                              activeColor: AppColors.primaryColorBlue,
                              thumbColor: AppColors.secondaryColorBlack,
                              inactiveColor: AppColors.infoPageCount,
                              value: utrRating!,
                              onChanged: (value) {
                                setState(() {});
                              },
                              onChangeEnd: (value) {
                                utrRating =
                                    double.parse(value.toStringAsFixed(1));
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
                              Text("$userDistance '${AppStrings.strMiles}",
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
                              activeColor: AppColors.primaryColorBlue,
                              thumbColor: AppColors.secondaryColorBlack,
                              inactiveColor: AppColors.infoPageCount,
                              value: userDistance!,
                              onChanged: (value) {
                                setState(() {});
                              },
                              onChangeEnd: (value) {
                                userDistance =
                                    double.parse(value.toStringAsFixed(1));
                                setState(() {});
                              },
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
                              Text(ntrpRating.toString(),
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
                              max: 7.0,
                              // allowedInteraction: SliderInteraction.tapAndSlide,
                              activeColor: AppColors.primaryColorBlue,
                              thumbColor: AppColors.secondaryColorBlack,
                              inactiveColor: AppColors.infoPageCount,
                              value: ntrpRating!,
                              onChanged: (value) {
                                setState(() {});
                              },
                              onChangeEnd: (value) {
                                ntrpRating =
                                    double.parse(value.toStringAsFixed(1));
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
                              Text("$userDistance '${AppStrings.strMiles}",
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
                              activeColor: AppColors.primaryColorBlue,
                              thumbColor: AppColors.secondaryColorBlack,
                              inactiveColor: AppColors.infoPageCount,
                              value: userDistance!,
                              onChanged: (value) {
                                setState(() {});
                              },
                              onChangeEnd: (value) {
                                userDistance =
                                    double.parse(value.toStringAsFixed(1));
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
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: AppButtons.elevatedButton(
                          AppStrings.strCancel,
                          AppFonts.mazzardFont(TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColorBlue,
                              fontSize: AppFontSize.font14)),
                          AppColors.primaryColorSkyBlue)),
                ),
                InkWell(
                  onTap: () {
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
