// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/chat_dir/provider/chat_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    deviceHeight(MediaQuery.of(context).size.height);

    return ChangeNotifierProvider<ChatProvider>(
      create: (_) {
        return ChatProvider();
      },
      child: Consumer<ChatProvider>(
        builder: (context, provider, child) {
          return SafeArea(
              child: Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.bgColor,
              leading: SizedBox(width: 0),
              elevation: 0,
              titleSpacing: 0,
              leadingWidth: 10,
              title: Text(AppStrings.strChat.toUpperCase(),
                  style: AppFonts.mazzardFont(TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColorBlue,
                      fontSize: AppFontSize.font20))),
              actions: [SizedBox(width: AppFontSize.font10)],
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
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColorLightGrey,
                          borderRadius:
                              BorderRadius.circular(AppFontSize.font12)),
                      child: TextFormField(
                        controller: provider.searchController,
                        decoration: InputDecoration(
                            hintText: AppStrings.strSearch,
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
                                    image:
                                        AssetImage(AppIconImages.searchIconImg),
                                    height: AppFontSize.font16,
                                    width: AppFontSize.font16,
                                  ),
                                ))),
                      ),
                    ),
                    SizedBox(height: AppFontSize.font10),
                    ListView.builder(
                        itemCount: provider.nameList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: AppFontSize.font8),
                              child: ListTile(
                                titleAlignment: ListTileTitleAlignment.center,
                                contentPadding: EdgeInsets.all(0),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.chatDetailsPage);
                                },
                                title: Text(provider.nameList[index],
                                    style: AppFonts.poppinsFont(TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryColorBlue,
                                        fontSize: AppFontSize.font14))),
                                subtitle: Text(
                                    "${provider.addressList[0]}   ${provider.pointList[0]}  ${provider.shortNameList[0]}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppFonts.mazzardFont(TextStyle(
                                        fontSize: AppFontSize.font10,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.secondaryColorBlack))),
                                leading: Stack(
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
                                trailing: Container(
                                  height: AppFontSize.font24,
                                  width: AppFontSize.font24,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppFontSize.font12),
                                      color: AppColors.primaryColorSkyBlue),
                                  child: Center(
                                      child: Text(
                                    index + 1 > 9 ? "9+" : "${index + 1}",
                                    style: AppFonts.poppinsFont(TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.secondaryColorBlack,
                                        fontSize: AppFontSize.font10)),
                                  )),
                                ),
                              ));
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
