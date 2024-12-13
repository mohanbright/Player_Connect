// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/appCachedData.dart';
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
    return Consumer<PlayerProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: AppColors.bgColor,
            iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
            centerTitle: true,
            title: Text(
              AppStrings.strRecommended,
              style: AppFonts.mazzardFont(
                TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColorBlue,
                    fontSize: AppFontSize.font16),
              ),
            ),
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppFontSize.font10, vertical: AppFontSize.font10),
            child: Column(
              children: [
                ListView.builder(
                    itemCount: provider.getRecommendedPlayersList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var item = provider.getRecommendedPlayersList[index];
                      return Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: AppFontSize.font10),
                        child: Container(
                          height: AppFontSize.font70,
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  AppCachesImages.cachedImages(item.images),
                                  item.is_online == 0
                                      ? SizedBox()
                                      : Positioned(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("${item.firstName} ${item.lastName}",
                                        style: AppFonts.poppinsFont(TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: AppColors.primaryColorBlue,
                                            fontSize: AppFontSize.font12))),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                            child:
                                                provider.buildText(item.city)),
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
                                        provider.buildText(item.rating),
                                        SizedBox(width: AppFontSize.font6),
                                        provider.buildText(item.ratingtype == 0
                                            ? AppStrings.strUtr.toUpperCase()
                                            : AppStrings.strNtrp.toUpperCase()),
                                        Spacer(),
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Provider.of<PlayerProvider>(context,
                                                listen: false)
                                            .getIndividualProfileData(
                                                context, item.id);
                                        Navigator.pushNamed(context,
                                            AppRoutes.playerProfilePage);
                                      },
                                      child: Text(AppStrings.strViewProfile,
                                          style: AppFonts.poppinsFont(TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryColorBlue,
                                              fontSize: AppFontSize.font12))),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: AppFontSize.font8),

                                  item.senderStatus1 == null &&
                                          item.senderStatus2 == null &&
                                          item.receiverStatus1 == null &&
                                          item.receiverStatus2 == null
                                      ? InkWell(
                                          onTap: () {
                                            provider.sendRequest(
                                                context, item.id, index, 3);
                                          },
                                          child: Container(
                                              height: AppFontSize.font40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: AppButtons.elevatedButton(
                                                  "CONNECT",
                                                  AppFonts.poppinsFont(TextStyle(
                                                      fontSize:
                                                          AppFontSize.font12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .secondaryColorBlack)),
                                                  AppColors.primaryColorSkyBlue,
                                                  border: AppColors
                                                      .primaryColorSkyBlue)),
                                        )
                                      : item.senderStatus1 == 1 ||
                                              item.senderStatus2 == 1 ||
                                              item.receiverStatus1 == 1 ||
                                              item.receiverStatus2 == 1
                                          ? Row(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.center,
                                              children: [
                                                // Image(
                                                //   image: AssetImage(
                                                //       AppIconImages
                                                //           .commentIconImg),
                                                //   height: AppFontSize.font20,
                                                //   width: AppFontSize.font20,
                                                // ),   //change
                                                SizedBox(
                                                    width: AppFontSize.font24),
                                                InkWell(
                                                  onTap: () {
                                                    provider
                                                        .deleteConnectionRequest(
                                                            context,
                                                            index,
                                                            3,
                                                            item.id);
                                                    setState(() {});
                                                  },
                                                  child: Image(
                                                      image: AssetImage(
                                                          AppIconImages
                                                              .removeCircleIconImg),
                                                      height:
                                                          AppFontSize.font24,
                                                      width:
                                                          AppFontSize.font24),
                                                ),
                                                SizedBox(
                                                    width: AppFontSize.font30),
                                              ],
                                            )
                                          : Container(
                                              height: AppFontSize.font40,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4,
                                              child: AppButtons.elevatedButton(
                                                  "CONNECTED",
                                                  AppFonts.poppinsFont(TextStyle(
                                                      fontSize:
                                                          AppFontSize.font12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: AppColors
                                                          .secondaryColorBlack)),
                                                  AppColors.primaryColorSkyBlue,
                                                  border: AppColors
                                                      .primaryColorSkyBlue),
                                            ),

                                  // item.requestStatus == null
                                  //     ? InkWell(
                                  //         onTap: () {
                                  //           provider.sendRequest(context,
                                  //               item.id.toString(), index, 3);
                                  //           // item.senderRequestStatus = 1;
                                  //           setState(() {});
                                  //         },
                                  //         child: Container(
                                  //           height: AppFontSize.font40,
                                  //           width: MediaQuery.of(context)
                                  //                   .size
                                  //                   .width /
                                  //               4,
                                  //           child: AppButtons.elevatedButton(
                                  //               "CONNECT",
                                  //               AppFonts.poppinsFont(TextStyle(
                                  //                   fontSize:
                                  //                       AppFontSize.font14,
                                  //                   fontWeight: FontWeight.w400,
                                  //                   color: AppColors
                                  //                       .secondaryColorBlack)),
                                  //               AppColors.primaryColorSkyBlue,
                                  //               border: AppColors
                                  //                   .primaryColorSkyBlue),
                                  //         ),
                                  //       )
                                  //     : item.requestStatus == 2
                                  //         ? Container(
                                  //             height: AppFontSize.font40,
                                  //             width: MediaQuery.of(context)
                                  //                     .size
                                  //                     .width /
                                  //                 4,
                                  //             child: AppButtons.elevatedButton(
                                  //                 "CONNECTED",
                                  //                 AppFonts.poppinsFont(TextStyle(
                                  //                     fontSize:
                                  //                         AppFontSize.font14,
                                  //                     fontWeight:
                                  //                         FontWeight.w400,
                                  //                     color: AppColors
                                  //                         .secondaryColorBlack)),
                                  //                 AppColors.primaryColorSkyBlue,
                                  //                 border: AppColors
                                  //                     .primaryColorSkyBlue),
                                  //           )
                                  //         : Row(
                                  //             mainAxisAlignment:
                                  //                 MainAxisAlignment.center,
                                  //             children: [
                                  //               Image(
                                  //                 image: AssetImage(
                                  //                     AppIconImages
                                  //                         .commentIconImg),
                                  //                 height: AppFontSize.font24,
                                  //                 width: AppFontSize.font24,
                                  //               ),
                                  //               SizedBox(
                                  //                   width: AppFontSize.font24),
                                  //               InkWell(
                                  //                 onTap: () {
                                  //                   provider
                                  //                       .deleteConnectionRequest(
                                  //                           context,
                                  //                           index,
                                  //                           3,
                                  //                           item.id);
                                  //                   // item.senderRequestStatus = null;
                                  //                   setState(() {});
                                  //                 },
                                  //                 child: Image(
                                  //                     image: AssetImage(
                                  //                         AppIconImages
                                  //                             .removeCircleIconImg),
                                  //                     height:
                                  //                         AppFontSize.font18,
                                  //                     width:
                                  //                         AppFontSize.font18),
                                  //               ),
                                  //             ],
                                  //           ),
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
        );
      },
    );
  }
}
