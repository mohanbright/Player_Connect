// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/widget/alert_filter_tab_widget.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({Key? key}) : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
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
                  resizeToAvoidBottomInset: false,
                  appBar: AppBar(
                    backgroundColor: AppColors.bgColor,
                    elevation: 0,
                    titleSpacing: 0,
                    leadingWidth: 10,
                    leading: SizedBox(width: 0),
                    title: Text(AppStrings.strPlayers.toUpperCase(),
                        style: AppFonts.mazzardFont(TextStyle(
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColorBlue,
                            fontSize: AppFontSize.font20))),
                  ),
                  body: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppFontSize.font10,
                          vertical: AppFontSize.font10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppStrings.strRecommended,
                                  style: AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryColorBlack,
                                      fontSize: AppFontSize.font16))),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.recommendedPage);
                                },
                                child: Text(AppStrings.strViewMore,
                                    style: AppFonts.poppinsFont(TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryColorSkyBlue,
                                        fontSize: AppFontSize.font14))),
                              ),
                            ],
                          ),
                          SizedBox(height: AppFontSize.font16),
                          Container(
                            height: AppFontSize.font150,
                            child: ListView.builder(
                                itemCount: provider.utrList.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(AppFontSize.font8),
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            CircleAvatar(
                                                radius: AppFontSize.font32,
                                                backgroundImage: AssetImage(
                                                    provider.imgList[0])),
                                            Positioned(
                                              right: 1,
                                              bottom: 1,
                                              child: Container(
                                                height: AppFontSize.font14,
                                                width: AppFontSize.font14,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppFontSize.font8),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .secondaryColorWhite,
                                                        width: 2)),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: AppFontSize.font8),
                                        Text(
                                            "${provider.utrList[index]}  '${AppStrings.strUtr.toUpperCase()}",
                                            style: AppFonts.mazzardFont(
                                                TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors
                                                        .secondaryColorBlack,
                                                    fontSize:
                                                        AppFontSize.font10))),
                                        SizedBox(height: AppFontSize.font4),
                                        Text("${provider.nameList[index]}",
                                            style: AppFonts.poppinsFont(
                                                TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors
                                                        .secondaryColorBlack,
                                                    fontSize:
                                                        AppFontSize.font14))),
                                        SizedBox(height: AppFontSize.font4),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppRoutes.playerProfilePage,
                                                arguments:
                                                    provider.nameList[index]);
                                          },
                                          child: Text(AppStrings.strViewProfile,
                                              style: AppFonts.mazzardFont(
                                                  TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: AppColors
                                                          .primaryColorBlue,
                                                      fontSize:
                                                          AppFontSize.font10))),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          Divider(),
                          SizedBox(height: AppFontSize.font16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.secondaryColorLightGrey,
                                      borderRadius: BorderRadius.circular(
                                          AppFontSize.font12)),
                                  child: TextFormField(
                                    controller: provider.searchController,
                                    decoration: InputDecoration(
                                        hintText: AppStrings.strSearchPlayers,
                                        hintStyle: AppFonts.poppinsFont(
                                            TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: AppColors
                                                    .secondaryColorBlack
                                                    .withOpacity(0.5),
                                                fontSize: AppFontSize.font16)),
                                        border: InputBorder.none,
                                        suffixIcon: Align(
                                            widthFactor: 1,
                                            heightFactor: 1,
                                            child: InkWell(
                                              onTap: () {},
                                              child: Image(
                                                image: AssetImage(AppIconImages
                                                    .filterIconImg),
                                                height: AppFontSize.font20,
                                                width: AppFontSize.font20,
                                              ),
                                            )),
                                        prefixIcon: Align(
                                            widthFactor: 1,
                                            heightFactor: 1,
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertFilterTabWidget();
                                                    });
                                              },
                                              child: Image(
                                                image: AssetImage(AppIconImages
                                                    .searchIconImg),
                                                height: AppFontSize.font16,
                                                width: AppFontSize.font16,
                                              ),
                                            ))),
                                  ),
                                ),
                              ),
                              SizedBox(width: AppFontSize.font8),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertFilterTabWidget();
                                      });
                                },
                                child: Image(
                                  image: AssetImage(AppIconImages.shortIconImg),
                                  height: AppFontSize.font28,
                                  width: AppFontSize.font28,
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: AppFontSize.font16),
                          ListView.builder(
                              itemCount: provider.nameList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: AppFontSize.font10),
                                  child: Container(
                                    height: AppFontSize.font50,
                                    child: Row(
                                      children: [
                                        Stack(
                                          children: [
                                            CircleAvatar(
                                                radius: AppFontSize.font30,
                                                backgroundImage: AssetImage(
                                                    provider.imgList[0])),
                                            Positioned(
                                              right: 1,
                                              bottom: 1,
                                              child: Container(
                                                height: AppFontSize.font14,
                                                width: AppFontSize.font14,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                                                  style: AppFonts.poppinsFont(
                                                      TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors
                                                              .primaryColorBlue,
                                                          fontSize: AppFontSize
                                                              .font12))),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  provider.buildText(provider
                                                      .addressList[0]
                                                      .toString()),
                                                  SizedBox(
                                                      width: AppFontSize.font6),
                                                  Container(
                                                    height: AppFontSize.font8,
                                                    width: AppFontSize.font8,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: AppColors
                                                            .greyColor),
                                                  ),
                                                  SizedBox(
                                                      width: AppFontSize.font6),
                                                  provider.buildText(provider
                                                      .pointList[0]
                                                      .toString()),
                                                  SizedBox(
                                                      width: AppFontSize.font8),
                                                  provider.buildText(provider
                                                      .shortNameList[0]
                                                      .toString()),
                                                  Spacer(),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .playerProfilePage,
                                                      arguments: provider
                                                          .nameList[index]);
                                                },
                                                child: Text(
                                                    AppStrings.strViewProfile,
                                                    style: AppFonts.poppinsFont(
                                                        TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .primaryColorBlue,
                                                            fontSize:
                                                                AppFontSize
                                                                    .font12))),
                                              )
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: AppFontSize.font8),
                                            provider.btnList[index] ==
                                                    AppStrings.strSent
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image(
                                                        image: AssetImage(
                                                            AppIconImages
                                                                .commentIconImg),
                                                        height:
                                                            AppFontSize.font20,
                                                        width:
                                                            AppFontSize.font20,
                                                      ),
                                                      SizedBox(
                                                          width: AppFontSize
                                                              .font24),
                                                      InkWell(
                                                        onTap: () {
                                                          provider.btnList[
                                                                  index] =
                                                              AppStrings
                                                                  .strConnect;
                                                          setState(() {});
                                                        },
                                                        child: Image(
                                                            image: AssetImage(
                                                                AppIconImages
                                                                    .removeCircleIconImg),
                                                            height: AppFontSize
                                                                .font24,
                                                            width: AppFontSize
                                                                .font24),
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
                                                      height:
                                                          AppFontSize.font40,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                      child: AppButtons.elevatedButton(
                                                          provider
                                                              .btnList[index],
                                                          AppFonts.poppinsFont(TextStyle(
                                                              fontSize:
                                                                  AppFontSize
                                                                      .font14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: AppColors
                                                                  .secondaryColorBlack)),
                                                          AppColors
                                                              .primaryColorSkyBlue,
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
                    ),
                  )));
        },
      ),
    );
  }
}
