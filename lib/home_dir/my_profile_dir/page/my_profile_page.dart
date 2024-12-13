// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/my_profile_dir/provider/my_profile_provider.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/provider/routes_provider.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    Provider.of<RoutesProvider>(context, listen: false)
        .getCurrentClassName(context);
    Provider.of<MyProfileProvider>(context, listen: false).fetchUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight(MediaQuery.of(context).size.height);
    return Consumer<MyProfileProvider>(
      builder: (context, provider, child) {
        String heightString = provider.userProfile?.height.toString() ?? '0';
        String splitResult = heightString.split("(").last;
        splitResult = splitResult.replaceAll(RegExp(r'[^0-9.]'), '');

        double personHeight = double.tryParse(splitResult) ?? 0.0;
        int roundedHeight = personHeight.round();
        String roundedHeightString = roundedHeight.toString();

        final availableHeight = MediaQuery.of(context).size.height -
            AppBar().preferredSize.height -
            MediaQuery.of(context).padding.top -
            MediaQuery.of(context).padding.bottom;
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Scaffold(
          body: provider.userProfile == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top),
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 2.2,
                          width: MediaQuery.of(context).size.width,
                          child: CachedNetworkImage(
                            imageUrl: AppApiUtils.imageUrl +
                                provider.userProfile!.images.toString(),
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Center(child: Icon(Icons.error)),
                            fit: BoxFit.fill,
                          ),
                        ),
                        // Container(
                        //     height: MediaQuery.of(context).size.height / 2.2,
                        //     decoration: BoxDecoration(
                        //         image: DecorationImage(
                        //             image: NetworkImage(AppApiUtils.imageUrl +
                        //                 provider.userProfile!.images
                        //                     .toString()),
                        //             fit: BoxFit.fill))),
                        Positioned(
                          top: AppFontSize.font20,
                          right: AppFontSize.font20,
                          child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.settingPage);
                              },
                              child: CircleAvatar(
                                  backgroundColor:
                                      AppColors.infoPageCount.withOpacity(0.6),
                                  radius: AppFontSize.font18,
                                  child: Image(
                                    image:
                                        AssetImage(AppIconImages.editIconImg),
                                    height: AppFontSize.font18,
                                    width: AppFontSize.font18,
                                  ))),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: AppFontSize.font16),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(provider.userProfile!.rating,
                                      style: AppFonts.mazzardFont(TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondaryColorBlack,
                                          fontSize: AppFontSize.font45))),
                                  SizedBox(width: AppFontSize.font10),
                                  RotatedBox(
                                      quarterTurns: 3,
                                      child: Text(
                                          provider.userProfile!.ratingtype == 0
                                              ? AppStrings.strUtr.toUpperCase()
                                              : AppStrings.strNtrp
                                                  .toUpperCase(),
                                          style: AppFonts.mazzardFont(TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  AppColors.secondaryColorBlack,
                                              fontSize: AppFontSize.font14)))),
                                  SizedBox(width: AppFontSize.font10),
                                  Image.asset(
                                    provider.userProfile!.countryFlag
                                        .toString(),
                                    package: countryCodePackageName,
                                    width: AppFontSize.font32,
                                    height: AppFontSize.font20,
                                  ),
                                ],
                              ),
                              SizedBox(height: AppFontSize.font8),
                              Text(
                                  "${provider.userProfile!.firstName} ${provider.userProfile!.lastName}",
                                  style: AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryColorBlue,
                                      fontSize: AppFontSize.font30))),
                              // SizedBox(height: AppFontSize.font14),
                              // Text("${provider.userProfile!.city}, ${provider.userProfile!.country}",
                              //     style: AppFonts.poppinsFont(TextStyle(
                              //         fontWeight: FontWeight.w400,
                              //         color: AppColors.secondaryColorBlack,
                              //         fontSize: AppFontSize.font14))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width / 3.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        titleText(AppStrings.strAge),
                                        Text.rich(TextSpan(
                                            text:
                                                '${provider.userProfile!.dob.split(" ").last} ',
                                            style: AppFonts.poppinsFont(
                                                TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors
                                                        .secondaryColorBlack,
                                                    fontSize:
                                                        AppFontSize.font14)),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text: AppStrings.strYears,
                                                style: AppFonts.poppinsFont(
                                                    TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .infoPageCount,
                                                        fontSize: AppFontSize
                                                            .font10)),
                                              )
                                            ])),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 3.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        titleText(AppStrings.strHeight),
                                        Text.rich(TextSpan(
                                            text: provider.userProfile!.height
                                                .toString()
                                                .split(" ")
                                                .first,
                                            style: AppFonts.poppinsFont(
                                                TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors
                                                        .secondaryColorBlack,
                                                    fontSize:
                                                        AppFontSize.font14)),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text:
                                                    ' (${roundedHeightString.toString()} cm)',
                                                // ' (${provider.userProfile!.height.toString().split("(").last}',

                                                style: AppFonts.poppinsFont(
                                                    TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .infoPageCount,
                                                        fontSize: AppFontSize
                                                            .font10)),
                                              )
                                            ])),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 3.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        titleText(AppStrings.strGender),
                                        Text(
                                            provider.userProfile!.gender == 0
                                                ? AppStrings.strMale
                                                : provider.userProfile!
                                                            .gender ==
                                                        1
                                                    ? AppStrings.strFemale
                                                    : "Other",
                                            style: AppFonts.poppinsFont(
                                                TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors
                                                        .secondaryColorBlack,
                                                    fontSize:
                                                        AppFontSize.font14)))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppFontSize.font14),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width / 2.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        titleText(AppStrings.strPlayingStyle),
                                        Text(provider.userProfile!.playingStyle,
                                            style: AppFonts.poppinsFont(
                                                TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors
                                                        .secondaryColorBlack,
                                                    fontSize:
                                                        AppFontSize.font14)))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: width / 2.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        titleText(AppStrings.strDiamondHand),
                                        Text(provider.userProfile!.dominantHand,
                                            style: AppFonts.poppinsFont(
                                                TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors
                                                        .secondaryColorBlack,
                                                    fontSize:
                                                        AppFontSize.font14)))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppFontSize.font14),
                              titleText(AppStrings.strTennisExp),
                              SizedBox(height: AppFontSize.font14),
                              buildReadMoreText(provider.userProfile!.about),
                              SizedBox(height: AppFontSize.font14),
                              buildRow(
                                  provider.userProfile!.ratingtype == 0
                                      ? AppStrings.strUtrRating
                                      : AppStrings.strNtrpRating,
                                  provider.userProfile!.ratingtype == 0
                                      ? "${provider.userProfile!.rating} ${AppStrings.strUtr.toUpperCase()}"
                                      : "${provider.userProfile!.rating} ${AppStrings.strNtrp.toUpperCase()}"),
                              SizedBox(height: AppFontSize.font14),
                              buildRow(AppStrings.strPrefDistanceFromCourt,
                                  "${provider.userProfile!.locationRange} ${AppStrings.strMiles}"),
                              SizedBox(height: AppFontSize.font14),
                              titleText(AppStrings.strDesiredpartner),
                              SizedBox(height: AppFontSize.font14),
                              buildReadMoreText(
                                  provider.userProfile!.desiredPartner),
                              SizedBox(height: AppFontSize.font10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget buildReadMoreText(text) {
    return ReadMoreText(
      text,
      trimLines: 3,
      colorClickableText: AppColors.primaryColorBlue,
      trimMode: TrimMode.Line,
      trimCollapsedText: AppStrings.strShowMore,
      trimExpandedText: AppStrings.strShowLess,
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
