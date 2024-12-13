// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:player_connect/login_dir/provider/connect_with_provider.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';

class ConnectWithPage extends StatefulWidget {
  const ConnectWithPage({Key? key}) : super(key: key);

  @override
  State<ConnectWithPage> createState() => _ConnectWithPageState();
}

class _ConnectWithPageState extends State<ConnectWithPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectWithProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppFontSize.font24,
                    vertical: AppFontSize.font20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top),
                    Image(
                      image: AssetImage(AppImages.appLogo),
                      height: AppFontSize.font50,
                      width: AppFontSize.font60,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: AppFontSize.font14),
                    Text(AppStrings.strConnectWith,
                        style: AppFonts.mazzardFont(TextStyle(
                            fontWeight: FontWeight.w400,
                            color: AppColors.primaryColorBlue,
                            fontSize: AppFontSize.font16))),
                    SizedBox(height: AppFontSize.font14),
                    Expanded(
                      child: ListView.builder(
                          itemCount: 10,
                          shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0, AppFontSize.font4, 0, AppFontSize.font4),
                              child: Container(
                                height: AppFontSize.font120,
                                decoration: BoxDecoration(
                                    color: AppColors.secondaryColorLightGrey,
                                    borderRadius: BorderRadius.circular(
                                        AppFontSize.font10)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(width: AppFontSize.font4),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            provider.nameList[0],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: AppFonts.mazzardFont(
                                                TextStyle(
                                                    fontSize:
                                                        AppFontSize.font14,
                                                    fontWeight:
                                                        FontWeight.w600,
                                                    color: AppColors
                                                        .primaryColorBlue)),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              buildText(provider
                                                  .addressList[0]
                                                  .toString()),
                                              SizedBox(
                                                  width: AppFontSize.font8),
                                              Container(
                                                height: AppFontSize.font8,
                                                width: AppFontSize.font8,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        AppColors.greyColor),
                                              ),
                                              SizedBox(
                                                  width: AppFontSize.font8),
                                              buildText(provider.pointList[0]
                                                  .toString()),
                                              SizedBox(
                                                  width: AppFontSize.font8),
                                              buildText(provider
                                                  .shortNameList[0]
                                                  .toString()),
                                              Spacer(),
                                            ],
                                          ),
                                          InkWell(
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
                                                  3.7,
                                              child: AppButtons.elevatedButton(
                                                  provider.btnList[index],
                                                  AppFonts.poppinsFont(TextStyle(
                                                      fontSize:
                                                          AppFontSize.font14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: provider.btnList[
                                                                  index] ==
                                                              AppStrings.strSent
                                                          ? AppColors
                                                              .primaryColorSkyBlue
                                                          : AppColors
                                                              .secondaryColorBlack)),
                                                  provider.btnList[index] == AppStrings.strSent
                                                      ? AppColors
                                                          .secondaryColorWhite
                                                      : AppColors
                                                          .primaryColorSkyBlue,
                                                  border: provider.btnList[
                                                              index] ==
                                                          AppStrings.strSent
                                                      ? AppColors
                                                          .primaryColorSkyBlue
                                                      : AppColors.primaryColorSkyBlue),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: AppFontSize.font140,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(
                                                  AppFontSize.font10),
                                              bottomRight: Radius.circular(
                                                  AppFontSize.font10)),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  AppImages.connectWithImg))),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: AppFontSize.font45)
                  ],
                ),
              ),
              Positioned(
                bottom: 10,
                right: AppFontSize.font20,
                left: AppFontSize.font20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          height: AppFontSize.font40,
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
                        Navigator.pushReplacementNamed(
                            context, AppRoutes.dashBoardPage);
                        progressTaskDone = 1;
                        progressTaskValue = 0.2;
                      },
                      child: Container(
                          height: AppFontSize.font40,
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
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildText(text) {
    return Text(text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppFonts.mazzardFont(TextStyle(
            fontSize: AppFontSize.font10,
            fontWeight: FontWeight.w500,
            color: AppColors.secondaryColorBlack)));
  }
}
