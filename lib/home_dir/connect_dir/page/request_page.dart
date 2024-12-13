// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/connect_dir/provider/connect_provider.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
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
    return Consumer<ConnectProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.bgColor,
            elevation: 0,
            centerTitle: true,
            iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
            title: Text(AppStrings.strRequest,
                style: AppFonts.mazzardFont(TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColorBlue,
                    fontSize: AppFontSize.font16))),
            actions: [
              // Image(
              //   image: AssetImage(AppIconImages.filterIconImg),
              //   height: AppFontSize.font20,
              //   width: AppFontSize.font20,
              // ),
              SizedBox(width: AppFontSize.font10)
            ],
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
                            child: Text("${provider.getReqPlayerList.length}",
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
                      itemCount: provider.getReqPlayerList.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var item = provider.getReqPlayerList[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: AppFontSize.font10),
                          child: Container(
                            height: AppFontSize.font50,
                            child: Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: AppFontSize.font60,
                                      width: AppFontSize.font60,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              AppFontSize.font50)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            AppFontSize.font50),
                                        child: CachedNetworkImage(
                                            imageUrl: AppApiUtils.imageUrl +
                                                item.images.toString(),
                                            placeholder: (context, url) =>
                                                const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                            errorWidget: (context, url,
                                                    error) =>
                                                const Center(
                                                    child: Icon(Icons.error)),
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
                                      Text("${item.firstName} ${item.lastName}",
                                          style: AppFonts.poppinsFont(TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryColorBlue,
                                              fontSize: AppFontSize.font12))),
                                      Text(
                                          "${item.city}    ${item.rating}   ${item.ratingtype == 0 ? "UTR" : "NTRP"}",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: AppFonts.mazzardFont(TextStyle(
                                              fontSize: AppFontSize.font10,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors
                                                  .secondaryColorBlack))),
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
                                            style: AppFonts.poppinsFont(
                                                TextStyle(
                                                    fontWeight: FontWeight.w400,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                        provider
                                                            .responseRequest(
                                                                context,
                                                                item.id,
                                                                2,
                                                                index);
                                                        Navigator.of(context)
                                                            .pop();
                                                        setState(() {});
                                                      },
                                                      child: Text(
                                                          AppStrings.strYes)),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
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
                                                        provider
                                                            .responseRequest(
                                                                context,
                                                                item.id,
                                                                3,
                                                                index);
                                                        setState(() {});
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Text(
                                                          AppStrings.strYes)),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Text(
                                                          AppStrings.strNo)),
                                                ],
                                              ),
                                            );
                                          },
                                          child: Image(
                                              image: AssetImage(
                                                  AppIconImages.cnclReqIconImg),
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
        );
      },
    );
  }
}
