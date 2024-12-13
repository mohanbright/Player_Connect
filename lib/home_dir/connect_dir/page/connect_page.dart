// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/chat_dir/model/chat_player_list.dart';
import 'package:player_connect/home_dir/chat_dir/page/chat_details_page.dart';
import 'package:player_connect/home_dir/connect_dir/provider/connect_provider.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/provider/routes_provider.dart';
import 'package:provider/provider.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key}) : super(key: key);

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  @override
  void initState() {
    Provider.of<RoutesProvider>(context, listen: false)
        .getCurrentClassName(context);
    Provider.of<ConnectProvider>(context, listen: false).connectReqPlayer();
    Provider.of<ConnectProvider>(context, listen: false).connectPlayer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight(MediaQuery.of(context).size.height);
    return Consumer<ConnectProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            leading: SizedBox(width: 0),
            backgroundColor: AppColors.bgColor,
            elevation: 0,
            titleSpacing: 0,
            leadingWidth: 10,
            title: Text(AppStrings.strConnect.toUpperCase(),
                style: AppFonts.mazzardFont(TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColorBlue,
                    fontSize: AppFontSize.font20))),
            // actions: [
            // Image(
            //   image: AssetImage(AppIconImages.filterIconImg),
            //   height: AppFontSize.font24,
            //   width: AppFontSize.font24,
            // ),
            // SizedBox(width: AppFontSize.font10)
            // ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppFontSize.font10, vertical: AppFontSize.font10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.strRequests,
                          style: AppFonts.mazzardFont(TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondaryColorBlack,
                              fontSize: AppFontSize.font16))),
                      SizedBox(width: AppFontSize.font8),
                      CircleAvatar(
                          backgroundColor: AppColors.primaryColorSkyBlue,
                          radius: AppFontSize.font10,
                          child: Center(
                            child: Text("${provider.getReqPlayerList.length}",
                                style: AppFonts.poppinsFont(TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryColorBlack,
                                    fontSize: AppFontSize.font12))),
                          )),
                      Spacer(),
                      provider.getReqPlayerList.length < 4
                          ? SizedBox()
                          : InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.requestPage);
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
                    height: AppFontSize.font150 + AppFontSize.font30,
                    child: provider.isRequestLoading
                        ? Center(child: CircularProgressIndicator())
                        : provider.getReqPlayerList.isEmpty
                            ? Center(child: Text("No requests"))
                            : ListView.builder(
                                itemCount: provider.getReqPlayerList.length,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var item = provider.getReqPlayerList[index];
                                  return Padding(
                                    padding: EdgeInsets.all(AppFontSize.font8),
                                    child: Column(
                                      children: [
                                        Stack(children: [
                                          Container(
                                            height: AppFontSize.font60,
                                            width: AppFontSize.font60,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppFontSize.font50)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppFontSize.font50),
                                              child: CachedNetworkImage(
                                                  imageUrl: AppApiUtils
                                                          .imageUrl +
                                                      item.images.toString(),
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Center(
                                                              child: Icon(
                                                                  Icons.error)),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
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
                                                            BorderRadius
                                                                .circular(
                                                                    AppFontSize
                                                                        .font8),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .secondaryColorWhite,
                                                            width: 2)),
                                                  ),
                                                )
                                        ]),
                                        SizedBox(height: AppFontSize.font8),
                                        Text(
                                            "${item.rating}  ${item.ratingtype == 0 ? "UTR" : "NTPR"}",
                                            style: AppFonts.mazzardFont(
                                                TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors
                                                        .secondaryColorBlack,
                                                    fontSize:
                                                        AppFontSize.font10))),
                                        SizedBox(height: AppFontSize.font4),
                                        Text(
                                            "${item.firstName} ${item.lastName}",
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
                                            Provider.of<PlayerProvider>(context,
                                                    listen: false)
                                                .getIndividualProfileData(
                                                    context, item.id);
                                            Navigator.pushNamed(context,
                                                AppRoutes.playerProfilePage);
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
                                        SizedBox(height: AppFontSize.font4),
                                        Row(
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
                                                            provider
                                                                .responseRequest(
                                                                    context,
                                                                    item.id,
                                                                    2,
                                                                    index);
                                                            Navigator.of(ctx)
                                                                .pop();
                                                          },
                                                          child: Text(AppStrings
                                                              .strYes)),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(ctx)
                                                                .pop();
                                                          },
                                                          child: Text(AppStrings
                                                              .strNo)),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: Image(
                                                  image: AssetImage(
                                                      AppIconImages
                                                          .aceptReqIconImg),
                                                  height: AppFontSize.font22,
                                                  width: AppFontSize.font22),
                                            ),
                                            SizedBox(width: AppFontSize.font10),
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
                                                            provider
                                                                .responseRequest(
                                                                    context,
                                                                    item.id,
                                                                    3,
                                                                    index);
                                                            Navigator.of(ctx)
                                                                .pop();
                                                          },
                                                          child: Text(AppStrings
                                                              .strYes)),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.of(ctx)
                                                                .pop();
                                                          },
                                                          child: Text(AppStrings
                                                              .strNo)),
                                                    ],
                                                  ),
                                                );
                                              },
                                              child: Image(
                                                  image: AssetImage(
                                                      AppIconImages
                                                          .cnclReqIconImg),
                                                  height: AppFontSize.font22,
                                                  width: AppFontSize.font22),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: AppFontSize.font4),
                                      ],
                                    ),
                                  );
                                }),
                  ),
                  Divider(),
                  Text(AppStrings.strSuccessfullMatches,
                      style: AppFonts.mazzardFont(TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondaryColorBlack,
                          fontSize: AppFontSize.font16))),
                  SizedBox(height: AppFontSize.font8),
                  provider.isConnectedLoading
                      ? Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: Center(child: CircularProgressIndicator()))
                      : provider.getConnectPlayerList.isEmpty
                          ? Container(
                              height: MediaQuery.of(context).size.height / 3,
                              child:
                                  Center(child: Text("No successful matches")))
                          : ListView.builder(
                              itemCount: provider.getConnectPlayerList.length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                var item = provider.getConnectPlayerList[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) =>
                                                ChatDetailsPage(
                                                  name: ChatPlayerListing(
                                                      receiverFirstName:
                                                          item.firstName,
                                                      lastMessage:
                                                          item.lastName,
                                                      receiverImages:
                                                          item.images,
                                                      receiverCity: item.city,
                                                      receiverId: item.id,
                                                      senderId: int.parse(
                                                          UserDetails.userID
                                                              .toString()),
                                                      receiverIsOnline:
                                                          item.is_online
                                                      // senderId: item.id,
                                                      // receiverId: int.parse(UserDetails.userID.toString()),
                                                      ),
                                                )))
                                        .whenComplete(() {
                                      Provider.of<RoutesProvider>(context,
                                              listen: false)
                                          .currentClassName = "ConnectPage";
                                      Provider.of<RoutesProvider>(context,
                                              listen: false)
                                          .getCurrentClassName(context);
                                    });
                                  },
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: AppFontSize.font10),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.all(0),
                                        minVerticalPadding: 0.0,
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChatDetailsPage(
                                                              name: ChatPlayerListing(
                                                                  receiverFirstName:
                                                                      item
                                                                          .firstName,
                                                                  lastMessage: item
                                                                      .lastName,
                                                                  receiverImages:
                                                                      item
                                                                          .images,
                                                                  receiverCity:
                                                                      item.city,
                                                                  receiverId:
                                                                      item.id,
                                                                  senderId: int.parse(
                                                                      UserDetails
                                                                          .userID
                                                                          .toString()),
                                                                  receiverIsOnline:
                                                                      item.is_online
                                                                  // senderId: item.id,
                                                                  // receiverId: int.parse(UserDetails.userID.toString()),
                                                                  ),
                                                            )))
                                                    .whenComplete(() {
                                                  Provider.of<RoutesProvider>(
                                                              context,
                                                              listen: false)
                                                          .currentClassName =
                                                      "ConnectPage";
                                                  Provider.of<RoutesProvider>(
                                                          context,
                                                          listen: false)
                                                      .getCurrentClassName(
                                                          context);
                                                });
                                              },
                                              child: Text(
                                                  "${item.firstName} ${item.lastName}",
                                                  style: AppFonts.poppinsFont(
                                                      TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: AppColors
                                                              .primaryColorBlue,
                                                          fontSize: AppFontSize
                                                              .font14))),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Provider.of<PlayerProvider>(
                                                        context,
                                                        listen: false)
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
                                                          fontSize: AppFontSize
                                                              .font10))),
                                            ),
                                          ],
                                        ),
                                        subtitle: Text(
                                            "${item.city}   ${item.rating}  ${item.ratingtype == 0 ? "UTR" : "NTPR"}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppFonts.mazzardFont(
                                                TextStyle(
                                                    fontSize:
                                                        AppFontSize.font10,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors
                                                        .secondaryColorBlack))),
                                        leading: Stack(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Provider.of<PlayerProvider>(
                                                        context,
                                                        listen: false)
                                                    .getIndividualProfileData(
                                                        context, item.id);
                                                Navigator.pushNamed(
                                                    context,
                                                    AppRoutes
                                                        .playerProfilePage);
                                              },
                                              child: Container(
                                                height: AppFontSize.font45,
                                                width: AppFontSize.font45,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            AppFontSize
                                                                .font50)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          AppFontSize.font50),
                                                  child: CachedNetworkImage(
                                                      imageUrl:
                                                          AppApiUtils.imageUrl +
                                                              item.images
                                                                  .toString(),
                                                      placeholder: (context,
                                                              url) =>
                                                          const Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          const Center(
                                                              child: Icon(
                                                                  Icons.error)),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            ),
                                            item.is_online == 0
                                                ? SizedBox()
                                                : Positioned(
                                                    right: -1,
                                                    bottom: -1,
                                                    child: Container(
                                                      height:
                                                          AppFontSize.font14,
                                                      width: AppFontSize.font14,
                                                      decoration: BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      AppFontSize
                                                                          .font8),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .secondaryColorWhite,
                                                              width: 2)),
                                                    ),
                                                  )
                                          ],
                                        ),
                                        trailing: InkWell(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChatDetailsPage(
                                                          name: ChatPlayerListing(
                                                              receiverFirstName:
                                                                  item
                                                                      .firstName,
                                                              lastMessage:
                                                                  item.lastName,
                                                              receiverImages:
                                                                  item.images,
                                                              receiverCity:
                                                                  item.city,
                                                              receiverId:
                                                                  item.id,
                                                              senderId: int.parse(
                                                                  UserDetails
                                                                      .userID
                                                                      .toString()),
                                                              receiverIsOnline:
                                                                  item.is_online
                                                              // senderId: item.id,
                                                              // receiverId: int.parse(UserDetails.userID.toString()),
                                                              ),
                                                        )))
                                                .whenComplete(() {
                                              Provider.of<RoutesProvider>(
                                                          context,
                                                          listen: false)
                                                      .currentClassName =
                                                  "ConnectPage";
                                              Provider.of<RoutesProvider>(
                                                      context,
                                                      listen: false)
                                                  .getCurrentClassName(context);
                                            });
                                          },
                                          child: Container(
                                            height: AppFontSize.font24,
                                            width: AppFontSize.font70,
                                            child: Image(
                                              image: AssetImage(
                                                  AppIconImages.commentIconImg),
                                              height: AppFontSize.font20,
                                              width: AppFontSize.font20,
                                            ),
                                          ),
                                        ),
                                      )),
                                );
                              }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
