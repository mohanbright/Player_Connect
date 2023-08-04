// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';

class ChatDetailsPage extends StatefulWidget {
  const ChatDetailsPage({Key? key}) : super(key: key);

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  TextEditingController msgController = TextEditingController();
  bool isShowDialog = true;
  List<ChatMessage> chatMessages = [];

  @override
  Widget build(BuildContext context) {
    deviceHeight(MediaQuery.of(context).size.height);

    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.bgColor,
        iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: Image(
        //     image: AssetImage(AppIconImages.backIconImg),
        //     height: AppFontSize.font35,
        //     width: AppFontSize.font35,
        //   ),
        // ),

        title: ListTile(
          contentPadding: EdgeInsets.all(0),
          title: Text("Mark Torres",
              style: AppFonts.poppinsFont(TextStyle(
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColorBlue,
                  fontSize: AppFontSize.font14))),
          subtitle: Text("New Lamont, DE  7.9  '${AppStrings.strUtr}'",
              style: AppFonts.mazzardFont(TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryColorBlack,
                  fontSize: AppFontSize.font10))),
          leading: Stack(
            children: [
              CircleAvatar(
                  radius: AppFontSize.font20,
                  backgroundImage: AssetImage(AppImages.playerRecc)),
              Positioned(
                right: -1,
                bottom: -1,
                child: Container(
                  height: AppFontSize.font12,
                  width: AppFontSize.font12,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(AppFontSize.font8),
                      border: Border.all(
                          color: AppColors.secondaryColorWhite, width: 2)),
                ),
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: AppFontSize.font12),
                isShowDialog
                    ? Container(
                        decoration: BoxDecoration(
                            color: AppColors.secondaryColorLightGrey),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppFontSize.font16,
                              vertical: AppFontSize.font16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(AppStrings.strConnectWithPerson,
                                      style: AppFonts.poppinsFont(TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondaryColorBlack,
                                          fontSize: AppFontSize.font14))),
                                  InkWell(
                                    onTap: () {
                                      isShowDialog = false;
                                      setState(() {});
                                    },
                                    child: Image(
                                      image: AssetImage(
                                          AppIconImages.clearIconImg),
                                      height: AppFontSize.font10,
                                      width: AppFontSize.font10,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppFontSize.font8),
                              Text(AppStrings.strAlthoughUHaveNotConnected,
                                  style: AppFonts.poppinsFont(TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.secondaryColorBlack,
                                      fontSize: AppFontSize.font14))),
                              SizedBox(height: AppFontSize.font8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      isShowDialog = false;
                                      setState(() {});
                                    },
                                    child: Image(
                                        image: AssetImage(
                                            AppIconImages.aceptReqIconImg),
                                        height: AppFontSize.font24,
                                        width: AppFontSize.font24),
                                  ),
                                  SizedBox(width: AppFontSize.font8),
                                  InkWell(
                                    onTap: () {
                                      isShowDialog = false;
                                      setState(() {});
                                    },
                                    child: Text(AppStrings.strConnect,
                                        style: AppFonts.poppinsFont(TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.secondaryColorBlack,
                                            fontSize: AppFontSize.font14))),
                                  ),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          5),
                                  InkWell(
                                    onTap: () {
                                      isShowDialog = false;
                                      setState(() {});
                                    },
                                    child: Image(
                                        image: AssetImage(
                                            AppIconImages.cnclReqIconImg),
                                        height: AppFontSize.font24,
                                        width: AppFontSize.font24),
                                  ),
                                  SizedBox(width: AppFontSize.font8),
                                  InkWell(
                                    onTap: () {
                                      isShowDialog = false;
                                      setState(() {});
                                    },
                                    child: Text(AppStrings.strDeny,
                                        style: AppFonts.poppinsFont(TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color:
                                                AppColors.secondaryColorBlack,
                                            fontSize: AppFontSize.font14))),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
                ListView.builder(
                  itemCount: chatMessages.length,
                  physics: NeverScrollableScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.down,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final message = chatMessages[index];
                    return Row(
                      mainAxisAlignment: index % 2 == 0
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ChatMessageWidget(
                            index: index,
                            message: message,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: AppFontSize.font60),
              ],
            ),
          ),
          Column(
            children: [
              Spacer(),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(AppFontSize.font8, 1,
                      AppFontSize.font8, AppFontSize.font8),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.secondaryColorLightGrey,
                        borderRadius:
                            BorderRadius.circular(AppFontSize.font12)),
                    padding:
                        EdgeInsets.symmetric(horizontal: AppFontSize.font12),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Image(
                              image: AssetImage(AppIconImages.galleryIconImg),
                              height: AppFontSize.font20,
                              width: AppFontSize.font20,
                            )),
                        SizedBox(width: AppFontSize.font10),
                        InkWell(
                            onTap: () {},
                            child: Image(
                              image: AssetImage(AppIconImages.emojiIconImg),
                              height: AppFontSize.font20,
                              width: AppFontSize.font20,
                            )),
                        SizedBox(width: AppFontSize.font10),
                        Expanded(
                          child: TextFormField(
                            controller: msgController,
                            decoration: InputDecoration(
                                hintText: AppStrings.strWriteMessage,
                                hintStyle: AppFonts.poppinsFont(TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.secondaryColorBlack
                                        .withOpacity(0.5),
                                    fontSize: AppFontSize.font14)),
                                border: InputBorder.none),
                          ),
                        ),
                        SizedBox(width: AppFontSize.font10),
                        InkWell(
                            onTap: () {
                              msgController.text.trim().isNotEmpty
                                  ? setState(() {
                                      chatMessages.add(ChatMessage(
                                          sender: AppStrings.strSender,
                                          message: msgController.text
                                              .trimLeft()
                                              .trimRight(),
                                          timestamp: DateTime.now()));
                                      msgController.clear();
                                    })
                                  : null;
                            },
                            child: Image(
                              image: AssetImage(AppIconImages.sendMsgIconImg),
                              height: AppFontSize.font18,
                              width: AppFontSize.font22,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: AppFontSize.font8,
                color: Colors.white,
              )
            ],
          ),
        ],
      ),
    ));
  }
}

class ChatMessage {
  final String sender;
  final String message;
  final DateTime timestamp;

  ChatMessage(
      {required this.sender, required this.message, required this.timestamp});
}

class ChatMessageWidget extends StatelessWidget {
  final int index;
  final ChatMessage message;

  const ChatMessageWidget({
    super.key,
    required this.message,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return index % 2 == 0
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                  radius: AppFontSize.font8,
                  backgroundColor: AppColors.primaryColorSkyBlue,
                  backgroundImage: AssetImage(AppImages.playerRecc)),
              SizedBox(width: 4),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                    color: AppColors.infoPageCount.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(AppFontSize.font16)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(14, 10, 14, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(message.message,
                          style: AppFonts.poppinsFont(TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryColorBlack,
                              fontSize: AppFontSize.font16))),
                      SizedBox(height: 8),
                      Text("2 min ago",
                          style: AppFonts.mazzardFont(TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.infoPageCount,
                              fontSize: AppFontSize.font10))),
                    ],
                  ),
                ),
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                    color: AppColors.primaryColorBlue,
                    borderRadius: BorderRadius.circular(AppFontSize.font16)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(14, 10, 14, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(message.message,
                          style: AppFonts.poppinsFont(TextStyle(
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondaryColorWhite,
                              fontSize: AppFontSize.font16))),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("2 min ago",
                              style: AppFonts.mazzardFont(TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.secondaryColorWhite,
                                  fontSize: AppFontSize.font10))),
                          SizedBox(width: AppFontSize.font6),
                          Image(
                            image: AssetImage(AppIconImages.msgSentIconImg),
                            width: AppFontSize.font10,
                            height: AppFontSize.font8,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 4),
              CircleAvatar(
                  radius: AppFontSize.font8,
                  backgroundColor: AppColors.primaryColorSkyBlue)
            ],
          );
  }
}
