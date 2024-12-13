// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:country_calling_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/player_dir/model/players_list_model.dart';
import 'package:player_connect/home_dir/player_dir/model/searchUserModel.dart';
import 'package:player_connect/home_dir/player_dir/page/individual_profile_model.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/home_dir/player_dir/widgets/report_user.dart';
import 'package:player_connect/setting_dir/provider/contact_suport_page_provider.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/models/userProfileModel.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

class PlayerProfilePage extends StatefulWidget {
  const PlayerProfilePage({Key? key}) : super(key: key);

  @override
  State<PlayerProfilePage> createState() => _PlayerProfilePageState();
}

class _PlayerProfilePageState extends State<PlayerProfilePage> {
  List<IndividualPlayersBodyData> getIndividualPlayersList =
      <IndividualPlayersBodyData>[];

  @override
  void initState() {
    getIndividualPlayersList =
        Provider.of<PlayerProvider>(context, listen: false)
            .getIndividualPlayersList;
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<PlayerProvider>(context, listen: false).isLoading = false;
    Provider.of<PlayerProvider>(context, listen: false).isProfileLoading =
        false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlayerProvider>(
      builder: (context, provider, child) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;

        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
                backgroundColor: AppColors.secondaryColorWhite,
                elevation: 0,
                title: Image(
                  image: AssetImage(AppImages.splashPageLogo),
                  height: AppFontSize.font35,
                  width: AppFontSize.font150,
                ),
              ),
              body: provider.getIndividualPlayersList.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 2.2,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  // image: DecorationImage(
                                  //     image: NetworkImage(AppApiUtils.imageUrl +
                                  //         provider
                                  //             .getIndividualPlayersList[0].images
                                  //             .toString()),
                                  //     fit: BoxFit.fill),
                                  ),
                              child: CachedNetworkImage(
                                  imageUrl: AppApiUtils.imageUrl +
                                      provider
                                          .getIndividualPlayersList[0].images
                                          .toString(),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Center(child: Icon(Icons.error)),
                                  fit: BoxFit.fill),
                            ),
                            // Positioned(
                            //   top: AppFontSize.font150,
                            //   left: AppFontSize.font20,
                            //   child: InkWell(
                            //     onTap: () {
                            //       print(
                            //           provider.getIndividualPlayersList[0].images);
                            //     },
                            //     child: Image(
                            //       image: AssetImage(AppIconImages.backArrowIconImg),
                            //       color: AppColors.secondaryColorWhite,
                            //       width: AppFontSize.font30,
                            //     ),
                            //   ),
                            // ),
                            // Positioned(
                            //   top: AppFontSize.font150,
                            //   right: AppFontSize.font20,
                            //   child: InkWell(
                            //     onTap: () {},
                            //     child: Image(
                            //       image:
                            //           AssetImage(AppIconImages.forwardArrowIconImg),
                            //       color: AppColors.secondaryColorWhite,
                            //       width: AppFontSize.font30,
                            //     ),
                            //   ),
                            // ),
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
                                      Text(
                                          provider.getIndividualPlayersList[0]
                                              .rating
                                              .toString(),
                                          style: AppFonts.mazzardFont(TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  AppColors.secondaryColorBlack,
                                              fontSize: AppFontSize.font45))),
                                      SizedBox(width: AppFontSize.font10),
                                      RotatedBox(
                                        quarterTurns: 3,
                                        child: Text(
                                            provider.getIndividualPlayersList[0]
                                                        .ratingtype ==
                                                    0
                                                ? AppStrings.strUtr
                                                    .toUpperCase()
                                                : AppStrings.strNtrp
                                                    .toUpperCase(),
                                            style: AppFonts.mazzardFont(
                                                TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors
                                                        .secondaryColorBlack,
                                                    fontSize:
                                                        AppFontSize.font14))),
                                      ),
                                      SizedBox(width: AppFontSize.font10),

                                      Image.asset(
                                        provider.getIndividualPlayersList[0]
                                            .countryFlag
                                            .toString(),
                                        package: countryCodePackageName,
                                        width: AppFontSize.font32,
                                        height: AppFontSize.font20,
                                      ),

                                      SizedBox(width: AppFontSize.font16),
                                      // CircleAvatar(
                                      //   backgroundColor: AppColors.primaryColorBlue,
                                      //   radius: AppFontSize.font20,
                                      //   child: Image(
                                      //     image: AssetImage(
                                      //         AppIconImages.commentIconImg),
                                      //     height: AppFontSize.font18,
                                      //     width: AppFontSize.font18,
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  SizedBox(height: AppFontSize.font14),
                                  Text(
                                      "${provider.getIndividualPlayersList[0].firstName} ${provider.getIndividualPlayersList[0].lastName}",
                                      style: AppFonts.mazzardFont(TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryColorBlue,
                                          fontSize: AppFontSize.font30))),
                                  SizedBox(height: AppFontSize.font14),
                                  Text(
                                      "${provider.getIndividualPlayersList[0].city}, ${provider.getIndividualPlayersList[0].country}",
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            titleText(AppStrings.strAge),
                                            Text.rich(TextSpan(
                                                text:
                                                    '${provider.getIndividualPlayersList[0].dob.toString().split(" ").last} ',
                                                style: AppFonts.poppinsFont(
                                                    TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .secondaryColorBlack,
                                                        fontSize: AppFontSize
                                                            .font14)),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text: AppStrings.strYears,
                                                    style: AppFonts.poppinsFont(
                                                        TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .infoPageCount,
                                                            fontSize:
                                                                AppFontSize
                                                                    .font10)),
                                                  )
                                                ])),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width / 3.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            titleText(AppStrings.strHeight),
                                            Text.rich(TextSpan(
                                                text:
                                                    "${provider.getIndividualPlayersList[0].height.toString().split(" ").first} ",
                                                style: AppFonts.poppinsFont(
                                                    TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .secondaryColorBlack,
                                                        fontSize: AppFontSize
                                                            .font14)),
                                                children: <InlineSpan>[
                                                  TextSpan(
                                                    text:
                                                        '(${provider.getIndividualPlayersList[0].height.toString().split("(").last}',
                                                    style: AppFonts.poppinsFont(
                                                        TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .infoPageCount,
                                                            fontSize:
                                                                AppFontSize
                                                                    .font10)),
                                                  )
                                                ])),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width / 3.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            titleText(AppStrings.strGender),
                                            Text(
                                                provider
                                                            .getIndividualPlayersList[
                                                                0]
                                                            .gender ==
                                                        0
                                                    ? "Male"
                                                    : provider
                                                                .getIndividualPlayersList[
                                                                    0]
                                                                .gender ==
                                                            1
                                                        ? "Female"
                                                        : "Other",
                                                style: AppFonts.poppinsFont(
                                                    TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .secondaryColorBlack,
                                                        fontSize: AppFontSize
                                                            .font14)))
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            titleText(
                                                AppStrings.strPlayingStyle),
                                            Text(
                                                provider
                                                    .getIndividualPlayersList[0]
                                                    .playingstyle
                                                    .toString(),
                                                style: AppFonts.poppinsFont(
                                                    TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .secondaryColorBlack,
                                                        fontSize: AppFontSize
                                                            .font14)))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: width / 2.5,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            titleText(
                                                AppStrings.strDiamondHand),
                                            Text(
                                                provider
                                                    .getIndividualPlayersList[0]
                                                    .dominnantHand
                                                    .toString(),
                                                style: AppFonts.poppinsFont(
                                                    TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: AppColors
                                                            .secondaryColorBlack,
                                                        fontSize: AppFontSize
                                                            .font14)))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: AppFontSize.font14),
                                  Row(
                                    mainAxisAlignment: provider.isUserBlocked(
                                            provider
                                                .getIndividualPlayersList[0].id
                                                .toString())
                                        ? MainAxisAlignment.center
                                        : MainAxisAlignment.spaceBetween,
                                    children: [
                                      provider.isUserBlocked(provider
                                              .getIndividualPlayersList[0].id
                                              .toString())
                                          ? SizedBox.shrink()
                                          : InkWell(
                                              onTap: () {
                                                provider
                                                                .getIndividualPlayersList[
                                                                    0]
                                                                .receiverStatus2 ==
                                                            null &&
                                                        provider
                                                                .getIndividualPlayersList[
                                                                    0]
                                                                .receiverStatus1 ==
                                                            null &&
                                                        provider
                                                                .getIndividualPlayersList[
                                                                    0]
                                                                .senderStatus1 ==
                                                            null &&
                                                        provider
                                                                .getIndividualPlayersList[
                                                                    0]
                                                                .senderStatus2 ==
                                                            null
                                                    ? provider.sendRequest(
                                                        context,
                                                        provider
                                                            .getIndividualPlayersList[
                                                                0]
                                                            .id,
                                                        0,
                                                        4)
                                                    : provider
                                                                    .getIndividualPlayersList[
                                                                        0]
                                                                    .receiverStatus1 ==
                                                                1 ||
                                                            provider
                                                                    .getIndividualPlayersList[
                                                                        0]
                                                                    .receiverStatus2 ==
                                                                1 ||
                                                            provider
                                                                    .getIndividualPlayersList[
                                                                        0]
                                                                    .senderStatus2 ==
                                                                1 ||
                                                            provider
                                                                    .getIndividualPlayersList[
                                                                        0]
                                                                    .senderStatus1 ==
                                                                1
                                                        ? provider
                                                            .deleteConnectionRequest(
                                                                context,
                                                                0,
                                                                4,
                                                                provider
                                                                    .getIndividualPlayersList[
                                                                        0]
                                                                    .id)
                                                            ?.whenComplete(() {
                                                            setState(() {});
                                                          })
                                                        : "CONNECTED";
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3.5,
                                                child:
                                                    AppButtons.elevatedButton(
                                                        provider.getIndividualPlayersList[0].receiverStatus2 == null &&
                                                                provider
                                                                        .getIndividualPlayersList[
                                                                            0]
                                                                        .receiverStatus1 ==
                                                                    null &&
                                                                provider
                                                                        .getIndividualPlayersList[
                                                                            0]
                                                                        .senderStatus1 ==
                                                                    null &&
                                                                provider
                                                                        .getIndividualPlayersList[
                                                                            0]
                                                                        .senderStatus2 ==
                                                                    null
                                                            ? "CONNECT"
                                                            : provider.getIndividualPlayersList[0].receiverStatus2 == 2 ||
                                                                    provider.getIndividualPlayersList[0].receiverStatus1 ==
                                                                        2 ||
                                                                    provider.getIndividualPlayersList[0].senderStatus1 ==
                                                                        2 ||
                                                                    provider.getIndividualPlayersList[0].senderStatus2 ==
                                                                        2
                                                                ? "CONNECTED"
                                                                : "CANCEL",
                                                        AppFonts.poppinsFont(
                                                            TextStyle(
                                                                fontSize:
                                                                    AppFontSize
                                                                        .font14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: AppColors
                                                                    .secondaryColorBlack)),
                                                        AppColors
                                                            .primaryColorSkyBlue,
                                                        border: AppColors
                                                            .primaryColorSkyBlue),
                                              ),
                                            ),
                                      InkWell(
                                        onTap: () {
                                          // fetchDataSPreferences();

                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return ChangeNotifierProvider(
                                                create: (context) =>
                                                    ContactSupportPageProvider(),
                                                child: ReportDialog(
                                                    UserDetails.userName,
                                                    UserDetails.userID,
                                                    provider
                                                        .getIndividualPlayersList[
                                                            0]
                                                        .id),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          child: AppButtons.elevatedButton(
                                              'Report User',
                                              AppFonts.poppinsFont(TextStyle(
                                                  fontSize: AppFontSize.font14,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppColors
                                                      .secondaryColorBlack)),
                                              AppColors.systemColorRed,
                                              border: AppColors
                                                  .primaryColorSkyBlue),
                                        ),
                                      ),
                                      provider.isUserBlocked(provider
                                              .getIndividualPlayersList[0].id
                                              .toString())
                                          ? Spacer()
                                          : SizedBox(),
                                      InkWell(
                                        onTap: () {
                                          final userId = provider
                                              .getIndividualPlayersList[0].id;
                                          provider.toggleBlockStatus(
                                              context, userId.toString());

                                          print(
                                              'Logged in User id :- ${UserDetails.userID}, player id :  $userId');
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          child: AppButtons.elevatedButton(
                                            provider.isUserBlocked(provider
                                                    .getIndividualPlayersList[0]
                                                    .id
                                                    .toString())
                                                ? 'Unblock'
                                                : 'Block',
                                            AppFonts.poppinsFont(
                                              TextStyle(
                                                fontSize: AppFontSize.font14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors
                                                    .secondaryColorBlack,
                                              ),
                                            ),
                                            provider.isUserBlocked(provider
                                                    .getIndividualPlayersList[0]
                                                    .id
                                                    .toString())
                                                ? AppColors.systemColorGreen
                                                : AppColors
                                                    .systemColorRed, // Use different colors for unblock
                                            border:
                                                AppColors.primaryColorSkyBlue,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: AppFontSize.font14),
                                  titleText(AppStrings.strAboutTennisExp),
                                  SizedBox(height: AppFontSize.font14),
                                  buildReadMoreText(
                                      "${provider.getIndividualPlayersList[0].about}"),
                                  SizedBox(height: AppFontSize.font14),
                                  buildRow(
                                      provider.getIndividualPlayersList[0]
                                                  .ratingtype ==
                                              0
                                          ? AppStrings.strUtrRating
                                          : AppStrings.strNtrpRating,
                                      "${provider.getIndividualPlayersList[0].rating} ${provider.getIndividualPlayersList[0].ratingtype == 0 ? AppStrings.strUtr.toUpperCase() : AppStrings.strNtrp.toUpperCase()}"),
                                  SizedBox(height: AppFontSize.font14),
                                  buildRow(AppStrings.strPrefDistanceFromCourt,
                                      "${provider.getIndividualPlayersList[0].locationRange} ${AppStrings.strMiles}"),
                                  SizedBox(height: AppFontSize.font14),
                                  titleText(AppStrings.strDesiredpartner),
                                  SizedBox(height: AppFontSize.font14),
                                  buildReadMoreText(
                                      "${provider.getIndividualPlayersList[0].desiredPartner}"),
                                  SizedBox(height: AppFontSize.font10),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            Visibility(
                visible: provider.isProfileLoading,
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
