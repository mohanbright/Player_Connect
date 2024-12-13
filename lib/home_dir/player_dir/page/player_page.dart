// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/shared/constant/appCachedData.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/provider/routes_provider.dart';
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
  void initState() {
    Provider.of<RoutesProvider>(context, listen: false)
        .getCurrentClassName(context);
    Provider.of<PlayerProvider>(context, listen: false).getPlayerListData();
    Provider.of<PlayerProvider>(context, listen: false).getIRecommendedData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, provider, child) {
        // if (provider.getPlayersList.isEmpty) {
        //   provider.getProfileData()!.whenComplete(() {
        //     setState(() {});
        //   });
        // }
        return Stack(
          children: [
            Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: AppColors.bgColor,
                  elevation: 0,
                  titleSpacing: 0,
                  leadingWidth: 10,
                  leading: SizedBox(width: 0),
                  title: Text(AppStrings.strHome.toUpperCase(),
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
                            provider.getRecommendedPlayersList.length < 5
                                ? SizedBox()
                                : InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.recommendedPage);
                                    },
                                    child: Text(AppStrings.strViewMore,
                                        style: AppFonts.poppinsFont(TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.primaryColorSkyBlue,
                                            fontSize: AppFontSize.font14))),
                                  ),
                          ],
                        ),
                        SizedBox(height: AppFontSize.font16),
                        Container(
                          height: AppFontSize.font150,
                          child: provider.isRecommendedListLoading
                              ? Center(child: CircularProgressIndicator())
                              : provider.getRecommendedPlayersList.isEmpty
                                  ? Center(
                                      child:
                                          Text("No nearby recommended players"))
                                  : ListView.builder(
                                      itemCount: provider
                                                  .getRecommendedPlayersList
                                                  .length <
                                              5
                                          ? provider
                                              .getRecommendedPlayersList.length
                                          : provider.getRecommendedPlayersList
                                              .length = 5,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        var item = provider
                                            .getRecommendedPlayersList[index];
                                        return Padding(
                                          padding:
                                              EdgeInsets.all(AppFontSize.font8),
                                          child: Column(
                                            children: [
                                              Stack(
                                                children: [
                                                  AppCachesImages.cachedImages(
                                                      item.images),
                                                  item.is_online == 0
                                                      ? SizedBox()
                                                      : Positioned(
                                                          right: 1,
                                                          bottom: 1,
                                                          child: Container(
                                                            height: AppFontSize
                                                                .font14,
                                                            width: AppFontSize
                                                                .font14,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        AppFontSize
                                                                            .font8),
                                                                border: Border.all(
                                                                    color: AppColors
                                                                        .secondaryColorWhite,
                                                                    width: 2)),
                                                          ),
                                                        ),
                                                  provider.isUserBlocked(
                                                          item.id.toString())
                                                      ? Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        5.0,
                                                                    vertical:
                                                                        2.0),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.red,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.3),
                                                                  offset:
                                                                      Offset(
                                                                          0, 4),
                                                                  blurRadius:
                                                                      8.0,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Text(
                                                              'Blocked',
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                // fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : SizedBox.shrink(),
                                                ],
                                              ),
                                              SizedBox(
                                                  height: AppFontSize.font8),
                                              Text(
                                                  item.ratingtype == 0
                                                      ? "${item.rating}  ${AppStrings.strUtr.toUpperCase()}"
                                                      : "${item.rating}  ${AppStrings.strNtrp.toUpperCase()}",
                                                  style: AppFonts.mazzardFont(
                                                      TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: AppColors
                                                              .secondaryColorBlack,
                                                          fontSize: AppFontSize
                                                              .font10))),
                                              SizedBox(
                                                  height: AppFontSize.font4),
                                              Text(
                                                  "${item.firstName} ${item.lastName}",
                                                  style: AppFonts.poppinsFont(
                                                      TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColors
                                                              .secondaryColorBlack,
                                                          fontSize: AppFontSize
                                                              .font14))),
                                              SizedBox(
                                                  height: AppFontSize.font4),
                                              InkWell(
                                                onTap: () {
                                                  provider
                                                      .getIndividualProfileData(
                                                          context, item.id);
                                                  Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .playerProfilePage);
                                                },
                                                child: Text(
                                                    AppStrings.strViewProfile,
                                                    style: AppFonts.mazzardFont(
                                                        TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .primaryColorBlue,
                                                            fontSize:
                                                                AppFontSize
                                                                    .font10))),
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
                                  onChanged: (value) {
                                    if (value.trim().isEmpty) {
                                      provider.getSearchPlayersList.clear();
                                      isRatingsData = false;
                                      setState(() {});
                                    }
                                  },
                                  onFieldSubmitted: (value) {
                                    isRatingsData == false;
                                    if (provider.searchController.text
                                        .trim()
                                        .isNotEmpty) {
                                      isRatingsData = false;
                                      provider.searchNameApi(context,
                                          name: value.trimRight().trimLeft());
                                      setState(() {});
                                      provider.searchNameApi(
                                        context,
                                        name: provider.searchController.text
                                            .trimLeft()
                                            .trimRight(),
                                      );
                                    } else if (provider.searchController.text
                                        .trim()
                                        .isEmpty) {
                                      isRatingsData = false;
                                      provider.getSearchPlayersList.clear();
                                      setState(() {});
                                    }
                                    setState(() {});
                                  },
                                  decoration: InputDecoration(
                                      hintText: AppStrings.strSearchPlayers,
                                      hintStyle: AppFonts.poppinsFont(TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.secondaryColorBlack
                                              .withOpacity(0.5),
                                          fontSize: AppFontSize.font16)),
                                      border: InputBorder.none,
                                      prefixIcon: Align(
                                          widthFactor: 1,
                                          heightFactor: 1,
                                          child: InkWell(
                                            onTap: () {},
                                            child: Image(
                                              image: AssetImage(
                                                  AppIconImages.searchIconImg),
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
                                provider.getSearchPlayersList.clear();
                                provider.getSearchPlayersList.clear();
                                setState(() {});
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertFilterTabWidget();
                                    }).then((value) {
                                  provider.searchController.clear();
                                });
                              },
                              child: Image(
                                image: AssetImage(AppIconImages.filterIconsImg),
                                height: AppFontSize.font24,
                                width: AppFontSize.font24,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: AppFontSize.font16),
                        provider.getSearchPlayersList.isNotEmpty
                            ? Text("Searched Player")
                            : SizedBox(),
                        provider.isPlayerListLoading
                            ? Container(
                                height: MediaQuery.of(context).size.height / 3,
                                child:
                                    Center(child: CircularProgressIndicator()))
                            : provider.getPlayersList.isEmpty &&
                                    provider.searchController.text
                                        .trim()
                                        .isEmpty
                                ? Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    child: Center(child: Text("Not any user")))
                                : provider.getSearchPlayersList.isEmpty &&
                                        (provider.searchController.text
                                                .trim()
                                                .isNotEmpty ||
                                            isRatingsData == true)
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        child: Center(
                                            child:
                                                Text("No searched user found")))
                                    : provider.getSearchPlayersList.isNotEmpty
                                        ? ListView.builder(
                                            itemCount: provider
                                                .getSearchPlayersList.length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var item = provider
                                                  .getSearchPlayersList[index];
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        AppFontSize.font10),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      // height: AppFontSize.font50,
                                                      child: Row(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              AppCachesImages
                                                                  .cachedImages(
                                                                      item.images),
                                                              item.is_online ==
                                                                      0
                                                                  ? SizedBox()
                                                                  : Positioned(
                                                                      right: 1,
                                                                      bottom: 1,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            AppFontSize.font14,
                                                                        width: AppFontSize
                                                                            .font14,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.green,
                                                                            borderRadius: BorderRadius.circular(AppFontSize.font8),
                                                                            border: Border.all(color: AppColors.secondaryColorWhite, width: 2)),
                                                                      ),
                                                                    )
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              width: AppFontSize
                                                                  .font10),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "${item.firstName} ${item.lastName}",
                                                                    style: AppFonts.poppinsFont(TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: AppColors
                                                                            .primaryColorBlue,
                                                                        fontSize:
                                                                            AppFontSize.font12))),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Expanded(
                                                                      child: provider.buildText(
                                                                          // "${item.city}, ${item.country!.substring(0, 2)}"),
                                                                          "${item.city},"),
                                                                    ),
                                                                    SizedBox(
                                                                        width: AppFontSize
                                                                            .font6),
                                                                    Container(
                                                                      height: AppFontSize
                                                                          .font8,
                                                                      width: AppFontSize
                                                                          .font8,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          color:
                                                                              AppColors.greyColor),
                                                                    ),
                                                                    SizedBox(
                                                                        width: AppFontSize
                                                                            .font6),
                                                                    provider.buildText(item
                                                                        .rating
                                                                        .toString()),
                                                                    SizedBox(
                                                                        width: AppFontSize
                                                                            .font8),
                                                                    provider.buildText(item.ratingtype ==
                                                                            0
                                                                        ? "UTR"
                                                                        : "NTRP"),
                                                                    Spacer(),
                                                                  ],
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    provider.getIndividualProfileData(
                                                                        context,
                                                                        item.id);
                                                                    Navigator
                                                                        .pushNamed(
                                                                      context,
                                                                      AppRoutes
                                                                          .playerProfilePage,
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                      AppStrings
                                                                          .strViewProfile,
                                                                      style: AppFonts.poppinsFont(TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color: AppColors
                                                                              .primaryColorBlue,
                                                                          fontSize:
                                                                              AppFontSize.font12))),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          provider.isUserBlocked(
                                                                  item.id
                                                                      .toString())
                                                              ? SizedBox()
                                                              : Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            AppFontSize.font8),
                                                                    item.receiverStatus2 == null &&
                                                                            item.receiverStatus1 ==
                                                                                null &&
                                                                            item.senderStatus1 ==
                                                                                null &&
                                                                            item.senderStatus2 ==
                                                                                null
                                                                        ? InkWell(
                                                                            onTap:
                                                                                () {
                                                                              provider.sendRequest(context, item.id.toString(), index, 1);
                                                                              // item.receiverRequestStatus = 1;
                                                                              print(item.id);
                                                                              setState(() {});
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              height: AppFontSize.font40,
                                                                              width: MediaQuery.of(context).size.width / 4,
                                                                              child: AppButtons.elevatedButton("CONNECT", AppFonts.poppinsFont(TextStyle(fontSize: AppFontSize.font12, fontWeight: FontWeight.w400, color: AppColors.secondaryColorBlack)), AppColors.primaryColorSkyBlue, border: AppColors.primaryColorSkyBlue),
                                                                            ),
                                                                          )
                                                                        : item.receiverStatus1 == 2 ||
                                                                                item.receiverStatus2 == 2 ||
                                                                                item.senderStatus2 == 2 ||
                                                                                item.senderStatus1 == 2
                                                                            ? Container(
                                                                                height: AppFontSize.font40,
                                                                                width: MediaQuery.of(context).size.width / 4,
                                                                                child: AppButtons.elevatedButton("CONNECTED", AppFonts.poppinsFont(TextStyle(fontSize: AppFontSize.font12, fontWeight: FontWeight.w400, color: AppColors.secondaryColorBlack)), AppColors.primaryColorSkyBlue, border: AppColors.primaryColorSkyBlue),
                                                                              )
                                                                            : Row(
                                                                                // mainAxisAlignment:
                                                                                //     MainAxisAlignment
                                                                                //         .center,
                                                                                children: [
                                                                                  // Image(
                                                                                  //   image:
                                                                                  //       AssetImage(AppIconImages.commentIconImg),
                                                                                  //   height:
                                                                                  //       AppFontSize.font20,
                                                                                  //   width:
                                                                                  //       AppFontSize.font20,
                                                                                  // ),  //change
                                                                                  // SizedBox(
                                                                                  //     width:
                                                                                  //         AppFontSize.font24),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      provider.deleteConnectionRequest(context, index, 1, item.id);

                                                                                      setState(() {});
                                                                                    },
                                                                                    child: Image(image: AssetImage(AppIconImages.removeCircleIconImg), height: AppFontSize.font24, width: AppFontSize.font24),
                                                                                  ),
                                                                                  SizedBox(width: AppFontSize.font30),
                                                                                ],
                                                                              ),
                                                                  ],
                                                                )
                                                        ],
                                                      ),
                                                    ),
                                                    provider.isUserBlocked(
                                                            item.id.toString())
                                                        ? Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          5.0,
                                                                      vertical:
                                                                          2.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.3),
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            4),
                                                                    blurRadius:
                                                                        8.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Text(
                                                                'Blocked',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  // fontSize: 16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox.shrink(),
                                                  ],
                                                ),
                                              );
                                            })
                                        : ListView.builder(
                                            itemCount:
                                                provider.getPlayersList.length,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              var item = provider
                                                  .getPlayersList[index];

                                              if (item.firstName == null ||
                                                  item.lastName == null ||
                                                  item.city == null ||
                                                  item.country == null ||
                                                  item.rating == null) {
                                                return SizedBox();
                                              }
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        AppFontSize.font10),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      // height: AppFontSize.font50,
                                                      child: Row(
                                                        children: [
                                                          Stack(
                                                            children: [
                                                              AppCachesImages
                                                                  .cachedImages(
                                                                      item.images),
                                                              item.is_online ==
                                                                      0
                                                                  ? SizedBox()
                                                                  : Positioned(
                                                                      right: 1,
                                                                      bottom: 1,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            AppFontSize.font14,
                                                                        width: AppFontSize
                                                                            .font14,
                                                                        decoration: BoxDecoration(
                                                                            color:
                                                                                Colors.green,
                                                                            borderRadius: BorderRadius.circular(AppFontSize.font8),
                                                                            border: Border.all(color: AppColors.secondaryColorWhite, width: 2)),
                                                                      ),
                                                                    ) //change
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              width: AppFontSize
                                                                  .font10),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                    "${item.firstName} ${item.lastName}",
                                                                    style: AppFonts.poppinsFont(TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        color: AppColors
                                                                            .primaryColorBlue,
                                                                        fontSize:
                                                                            AppFontSize.font12))),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  // crossAxisAlignment:
                                                                  //     CrossAxisAlignment
                                                                  //         .start,
                                                                  children: [
                                                                    Expanded(
                                                                      child: provider
                                                                          .buildText(
                                                                              "${item.city}, ${item.country!.substring(0, 2)}"),
                                                                    ),
                                                                    SizedBox(
                                                                        width: AppFontSize
                                                                            .font6),
                                                                    Container(
                                                                      height: AppFontSize
                                                                          .font8,
                                                                      width: AppFontSize
                                                                          .font8,
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          color:
                                                                              AppColors.greyColor),
                                                                    ),
                                                                    SizedBox(
                                                                        width: AppFontSize
                                                                            .font6),
                                                                    provider.buildText(item
                                                                        .rating
                                                                        .toString()),
                                                                    SizedBox(
                                                                        width: AppFontSize
                                                                            .font8),
                                                                    provider.buildText(item.ratingtype ==
                                                                            0
                                                                        ? "UTR"
                                                                        : "NTRP"),
                                                                    Spacer(),
                                                                  ],
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    provider.getIndividualProfileData(
                                                                        context,
                                                                        item.id);
                                                                    Navigator
                                                                        .pushNamed(
                                                                      context,
                                                                      AppRoutes
                                                                          .playerProfilePage,
                                                                    );
                                                                  },
                                                                  child: Text(
                                                                      AppStrings
                                                                          .strViewProfile,
                                                                      style: AppFonts.poppinsFont(TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color: AppColors
                                                                              .primaryColorBlue,
                                                                          fontSize:
                                                                              AppFontSize.font12))),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                          provider.isUserBlocked(
                                                                  item.id
                                                                      .toString())
                                                              ? SizedBox()
                                                              : Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            AppFontSize.font8),
                                                                    item.senderStatus1 == null &&
                                                                            item.senderStatus2 ==
                                                                                null &&
                                                                            item.receiverStatus1 ==
                                                                                null &&
                                                                            item.receiverStatus2 ==
                                                                                null
                                                                        ? InkWell(
                                                                            onTap:
                                                                                () {
                                                                              provider.sendRequest(context, item.id.toString(), index, 2);
                                                                              // item.receiverRequestStatus =
                                                                              //     1;
                                                                              print(item.id);
                                                                              setState(() {});
                                                                            },
                                                                            child: Container(
                                                                                height: AppFontSize.font40,
                                                                                width: MediaQuery.of(context).size.width / 4,
                                                                                child: AppButtons.elevatedButton("CONNECT", AppFonts.poppinsFont(TextStyle(fontSize: AppFontSize.font12, fontWeight: FontWeight.w400, color: AppColors.secondaryColorBlack)), AppColors.primaryColorSkyBlue, border: AppColors.primaryColorSkyBlue)),
                                                                          )
                                                                        : item.senderStatus1 == 1 ||
                                                                                item.senderStatus2 == 1 ||
                                                                                item.receiverStatus1 == 1 ||
                                                                                item.receiverStatus2 == 1
                                                                            ? Row(
                                                                                // mainAxisAlignment:
                                                                                //     MainAxisAlignment
                                                                                //         .center,
                                                                                children: [
                                                                                  // Image(
                                                                                  //   image:
                                                                                  //       AssetImage(AppIconImages.commentIconImg),
                                                                                  //   height:
                                                                                  //       AppFontSize.font20,
                                                                                  //   width:
                                                                                  //       AppFontSize.font20,
                                                                                  // ),  //change
                                                                                  SizedBox(width: AppFontSize.font24),
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      provider.deleteConnectionRequest(context, index, 2, item.id)?.whenComplete(() {
                                                                                        setState(() {});
                                                                                      });
                                                                                      setState(() {});
                                                                                    },
                                                                                    child: Image(image: AssetImage(AppIconImages.removeCircleIconImg), height: AppFontSize.font24, width: AppFontSize.font24),
                                                                                  ),
                                                                                  SizedBox(width: AppFontSize.font30),
                                                                                ],
                                                                              )
                                                                            : Container(
                                                                                height: AppFontSize.font40,
                                                                                width: MediaQuery.of(context).size.width / 4,
                                                                                child: AppButtons.elevatedButton("CONNECTED", AppFonts.poppinsFont(TextStyle(fontSize: AppFontSize.font12, fontWeight: FontWeight.w400, color: AppColors.secondaryColorBlack)), AppColors.primaryColorSkyBlue, border: AppColors.primaryColorSkyBlue),
                                                                              ),
                                                                  ],
                                                                )
                                                        ],
                                                      ),
                                                    ),
                                                    provider.isUserBlocked(
                                                            item.id.toString())
                                                        ? Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          5.0,
                                                                      vertical:
                                                                          2.0),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.3),
                                                                    offset:
                                                                        Offset(
                                                                            0,
                                                                            4),
                                                                    blurRadius:
                                                                        8.0,
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Text(
                                                                'Blocked',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  // fontSize: 16.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : SizedBox.shrink(),
                                                  ],
                                                ),
                                              );
                                            })
                      ],
                    ),
                  ),
                )),
            Visibility(
                visible: provider.isLoading,
                child: Scaffold(
                    backgroundColor: Colors.black45,
                    body: Center(
                      child: CircularProgressIndicator(),
                    )))
          ],
        );
      },
    );
  }
}
