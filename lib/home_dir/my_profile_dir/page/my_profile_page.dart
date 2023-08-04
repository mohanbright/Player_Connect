// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_local_variable

import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/my_profile_dir/provider/my_profile_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    deviceHeight(MediaQuery.of(context).size.height);
    return ChangeNotifierProvider<MyProfileProvider>(
      create: (_) {
        return MyProfileProvider();
      },
      child: Consumer<MyProfileProvider>(
        builder: (context, provider, child) {
          final availableHeight = MediaQuery.of(context).size.height -
              AppBar().preferredSize.height -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom;
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          return SafeArea(
              child: Scaffold(
            body: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height / 2.2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(AppImages.playerRecc),
                                fit: BoxFit.fill))),
                    Positioned(
                      top: AppFontSize.font20,
                      right: AppFontSize.font20,
                      child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.settingPage);
                          },
                          child: CircleAvatar(
                              backgroundColor:
                                  AppColors.infoPageCount.withOpacity(0.6),
                              radius: AppFontSize.font18,
                              child: Image(
                                image: AssetImage(AppIconImages.editIconImg),
                                height: AppFontSize.font18,
                                width: AppFontSize.font18,
                              ))),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppFontSize.font16),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("11.7",
                                  style: AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryColorBlack,
                                      fontSize: AppFontSize.font45))),
                              SizedBox(width: AppFontSize.font10),
                              RotatedBox(
                                  quarterTurns: 3,
                                  child: Text(AppStrings.strUtr.toUpperCase(),
                                      style: AppFonts.mazzardFont(TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryColorBlack,
                                          fontSize: AppFontSize.font14)))),
                              SizedBox(width: AppFontSize.font10),
                              Image(
                                  image: AssetImage(AppImages.flagImg),
                                  width: AppFontSize.font32,
                                  height: AppFontSize.font20),
                              SizedBox(width: AppFontSize.font16),
                              CircleAvatar(
                                backgroundColor: AppColors.primaryColorBlue,
                                radius: AppFontSize.font20,
                                child: Image(
                                  image:
                                      AssetImage(AppIconImages.commentIconImg),
                                  height: AppFontSize.font18,
                                  width: AppFontSize.font18,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: AppFontSize.font8),
                          Text("Doris Edwards",
                              style: AppFonts.mazzardFont(TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColorBlue,
                                  fontSize: AppFontSize.font30))),
                          SizedBox(height: AppFontSize.font14),
                          Text("New Lamont, DE",
                              style: AppFonts.poppinsFont(TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.secondaryColorBlack,
                                  fontSize: AppFontSize.font14))),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: width / 3.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    titleText(AppStrings.strAge),
                                    Text.rich(TextSpan(
                                        text: '21 ',
                                        style: AppFonts.poppinsFont(TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors.secondaryColorBlack,
                                            fontSize: AppFontSize.font14)),
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: AppStrings.strYears,
                                            style: AppFonts.poppinsFont(
                                                TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.infoPageCount,
                                                    fontSize:
                                                        AppFontSize.font10)),
                                          )
                                        ])),
                                  ],
                                ),
                              ),
                              Container(
                                width: width / 3.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    titleText(AppStrings.strHeight),
                                    Text.rich(TextSpan(
                                        text: "6'5'' ",
                                        style: AppFonts.poppinsFont(TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors.secondaryColorBlack,
                                            fontSize: AppFontSize.font14)),
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text: '(196cm)',
                                            style: AppFonts.poppinsFont(
                                                TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        AppColors.infoPageCount,
                                                    fontSize:
                                                        AppFontSize.font10)),
                                          )
                                        ])),
                                  ],
                                ),
                              ),
                              Container(
                                width: width / 3.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    titleText(AppStrings.strGender),
                                    Text(AppStrings.strMale,
                                        style: AppFonts.poppinsFont(TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors.secondaryColorBlack,
                                            fontSize: AppFontSize.font14)))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppFontSize.font14),
                          Row(
                            children: [
                              Container(
                                width: width / 2.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    titleText(AppStrings.strPlayingStyle),
                                    Text("Counter Puncher",
                                        style: AppFonts.poppinsFont(TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors.secondaryColorBlack,
                                            fontSize: AppFontSize.font14)))
                                  ],
                                ),
                              ),
                              Container(
                                width: width / 2.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    titleText(AppStrings.strDiamondHand),
                                    Text(AppStrings.strRight,
                                        style: AppFonts.poppinsFont(TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color:
                                                AppColors.secondaryColorBlack,
                                            fontSize: AppFontSize.font14)))
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: AppFontSize.font14),
                          titleText(AppStrings.strAboutTennisExp),
                          SizedBox(height: AppFontSize.font14),
                          buildReadMoreText(
                              "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old."),
                          SizedBox(height: AppFontSize.font14),
                          buildRow(AppStrings.strUtrRating,
                              "11.3 '${AppStrings.strUtr.toUpperCase()}'"),
                          SizedBox(height: AppFontSize.font14),
                          buildRow(AppStrings.strNtrpRating,
                              "5.0 '${AppStrings.strUtr.toUpperCase()}'"),
                          SizedBox(height: AppFontSize.font14),
                          buildRow(
                              AppStrings.strPrefDistanceFromCourt, "15 Miles"),
                          SizedBox(height: AppFontSize.font14),
                          titleText(AppStrings.strDesiredpartner),
                          SizedBox(height: AppFontSize.font14),
                          buildReadMoreText(
                              "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable."),
                          SizedBox(height: AppFontSize.font10),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }

  Widget buildReadMoreText(text) {
    return ReadMoreText(
      text,
      trimLines: 3,
      colorClickableText: AppColors.primaryColorBlue,
      trimMode: TrimMode.Line,
      trimCollapsedText: ' Show More',
      trimExpandedText: ' Show Less',
      style: AppFonts.poppinsFont(TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.secondaryColorBlack,
          fontSize: AppFontSize.font16)),
      moreStyle: AppFonts.poppinsFont(TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColorSkyBlue,
          fontSize: AppFontSize.font16)),
      lessStyle: AppFonts.poppinsFont(TextStyle(
          fontWeight: FontWeight.w400,
          color: AppColors.primaryColorSkyBlue,
          fontSize: AppFontSize.font16)),
    );
  }

  Widget buildRow(name, value) {
    return Row(
      children: [
        Expanded(child: titleText(name)),
        Text(value,
            style: AppFonts.poppinsFont(TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryColorBlack,
                fontSize: AppFontSize.font14))),
      ],
    );
  }

  Widget titleText(title) {
    return Text(title,
        maxLines: 1,
        style: AppFonts.poppinsFont(TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.infoPageCount,
            fontSize: AppFontSize.font14)));
  }
}
