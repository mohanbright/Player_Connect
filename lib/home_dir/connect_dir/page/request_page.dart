// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/connect_dir/provider/connect_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  @override
  Widget build(BuildContext context) {
    deviceHeight(MediaQuery.of(context).size.height);
    return ChangeNotifierProvider<ConnectProvider>(
      create: (_) {
        return ConnectProvider();
      },
      child: Consumer<ConnectProvider>(
        builder: (context, provider, child) {
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.bgColor,
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
              title: Text(AppStrings.strRequest,
                  style: AppFonts.mazzardFont(TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColorBlue,
                      fontSize: AppFontSize.font18))),
              actions: [
                Image(
                  image: AssetImage(AppIconImages.filterIconImg),
                  height: AppFontSize.font20,
                  width: AppFontSize.font20,
                ),
                SizedBox(width: AppFontSize.font10)
              ],
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
                        Text(AppStrings.strRequest,
                            style: AppFonts.mazzardFont(TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryColorBlack,
                                fontSize: AppFontSize.font16))),
                        SizedBox(width: AppFontSize.font8),
                        CircleAvatar(
                            backgroundColor: AppColors.primaryColorSkyBlue,
                            radius: AppFontSize.font10,
                            child: Center(
                              child: Text("${provider.nameList.length}",
                                  style: AppFonts.poppinsFont(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondaryColorBlack,
                                      fontSize: AppFontSize.font12))),
                            )),
                        Spacer(),
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
                                          radius: AppFontSize.font28,
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
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .primaryColorBlue,
                                                    fontSize:
                                                        AppFontSize.font12))),
                                        Text(
                                            "${provider.addressList[0]}    ${provider.pointList[0]}   ${provider.shortNameList[0]}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppFonts.mazzardFont(
                                                TextStyle(
                                                    fontSize:
                                                        AppFontSize.font10,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors
                                                        .secondaryColorBlack))),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                AppRoutes.playerProfilePage,
                                                arguments:
                                                    provider.nameList[index]);
                                          },
                                          child: Text(AppStrings.strViewProfile,
                                              style: AppFonts.poppinsFont(
                                                  TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .primaryColorBlue,
                                                      fontSize:
                                                          AppFontSize.font12))),
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: AppFontSize.font8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  title: Text(AppStrings
                                                      .strRequestAccept),
                                                  content: Text(AppStrings
                                                      .strSureToAcceptRequest),
                                                  actions: <Widget>[
                                                    TextButton(
                                                        onPressed: () {
                                                          AppSnackBarToast
                                                              .buildShowSnackBar(
                                                                  context,
                                                                  AppStrings
                                                                      .strRequestAccepted);
                                                          Navigator.of(ctx)
                                                              .pop();
                                                          provider.nameList
                                                              .removeAt(index);
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                            AppStrings.strYes)),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                            AppStrings.strNo)),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Image(
                                                image: AssetImage(AppIconImages
                                                    .aceptReqIconImg),
                                                height: AppFontSize.font18,
                                                width: AppFontSize.font18),
                                          ),
                                          SizedBox(width: AppFontSize.font12),
                                          InkWell(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  title: Text(AppStrings
                                                      .strRequestDecline),
                                                  content: Text(AppStrings
                                                      .strSureToDeclineRequest),
                                                  actions: <Widget>[
                                                    TextButton(
                                                        onPressed: () {
                                                          AppSnackBarToast
                                                              .buildShowSnackBar(
                                                                  context,
                                                                  AppStrings
                                                                      .strRequestDeclinedSuccess);

                                                          provider.nameList
                                                              .removeAt(index);
                                                          setState(() {});
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                            AppStrings.strYes)),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        child: Text(
                                                            AppStrings.strNo)),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Image(
                                                image: AssetImage(AppIconImages
                                                    .cnclReqIconImg),
                                                height: AppFontSize.font18,
                                                width: AppFontSize.font18),
                                          ),
                                          SizedBox(width: AppFontSize.font12),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
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
