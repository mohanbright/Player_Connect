// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:provider/provider.dart';

class RecommendedPage extends StatefulWidget {
  const RecommendedPage({Key? key}) : super(key: key);

  @override
  State<RecommendedPage> createState() => _RecommendedPageState();
}

class _RecommendedPageState extends State<RecommendedPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PlayerProvider>(
      create: (_) {
        return PlayerProvider();
      },
      child: Consumer<PlayerProvider>(
        builder: (context, provider, child) {
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: AppColors.bgColor,
              iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
              // leading: InkWell(
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   child: Image(
              //     image: AssetImage(AppIconImages.backIconImg),
              //     height: AppFontSize.font18,
              //     width: AppFontSize.font18,
              //     fit: BoxFit.contain,
              //   ),
              // ),
              centerTitle: true,
              title: Text(AppStrings.strRecommended,
                  style: AppFonts.mazzardFont(TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColorBlue,
                      fontSize: AppFontSize.font18))),
            ),
            body: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppFontSize.font10, vertical: AppFontSize.font10),
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppFontSize.font10),
                          child: Container(
                            height: AppFontSize.font70,
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    CircleAvatar(
                                        radius: AppFontSize.font30,
                                        backgroundImage:
                                            AssetImage(provider.imgList[0])),
                                    Positioned(
                                      right: 1,
                                      bottom: 1,
                                      child: Container(
                                        height: AppFontSize.font14,
                                        width: AppFontSize.font14,
                                        decoration: BoxDecoration(
                                            color: Colors.green,
                                            borderRadius: BorderRadius.circular(
                                                AppFontSize.font8),
                                            border: Border.all(
                                                color: AppColors
                                                    .secondaryColorWhite,
                                                width: 2)),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(width: AppFontSize.font10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(provider.nameList[index],
                                          style: AppFonts.poppinsFont(TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryColorBlue,
                                              fontSize: AppFontSize.font12))),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          provider.buildText(provider
                                              .addressList[0]
                                              .toString()),
                                          SizedBox(width: AppFontSize.font6),
                                          Container(
                                            height: AppFontSize.font8,
                                            width: AppFontSize.font8,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: AppColors.greyColor),
                                          ),
                                          SizedBox(width: AppFontSize.font8),
                                          provider.buildText(
                                              provider.pointList[0].toString()),
                                          SizedBox(width: AppFontSize.font6),
                                          provider.buildText(provider
                                              .shortNameList[0]
                                              .toString()),
                                          Spacer(),
                                        ],
                                      ),
                                      Text(AppStrings.strViewProfile,
                                          style: AppFonts.poppinsFont(TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryColorBlue,
                                              fontSize: AppFontSize.font12)))
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: AppFontSize.font8),
                                    provider.btnList[index] ==
                                            AppStrings.strSent
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image(
                                                image: AssetImage(AppIconImages
                                                    .commentIconImg),
                                                height: AppFontSize.font24,
                                                width: AppFontSize.font24,
                                              ),
                                              SizedBox(
                                                  width: AppFontSize.font24),
                                              InkWell(
                                                onTap: () {
                                                  provider.btnList[index] =
                                                      AppStrings.strConnect;
                                                  setState(() {});
                                                },
                                                child: Image(
                                                    image: AssetImage(
                                                        AppIconImages
                                                            .removeCircleIconImg),
                                                    height: AppFontSize.font18,
                                                    width: AppFontSize.font18),
                                              ),
                                            ],
                                          )
                                        : InkWell(
                                            onTap: () {
                                              provider.btnList[index] =
                                                  AppStrings.strSent;
                                              setState(() {});
                                            },
                                            child: Container(
                                              height: AppFontSize.font40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: AppButtons.elevatedButton(
                                                  provider.btnList[index],
                                                  AppFonts.poppinsFont(TextStyle(
                                                      fontSize:
                                                          AppFontSize.font14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .secondaryColorBlack)),
                                                  AppColors.primaryColorSkyBlue,
                                                  border: AppColors
                                                      .primaryColorSkyBlue),
                                            ),
                                          ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })
                ],
              ),
            )),
          ));
        },
      ),
    );
  }
}
