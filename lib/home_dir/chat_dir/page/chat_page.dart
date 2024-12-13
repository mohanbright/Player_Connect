// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:async';
import 'dart:convert';
import 'package:player_connect/home_dir/chat_dir/model/chat_player_list.dart';
import 'package:player_connect/main.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/provider/routes_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/chat_dir/model/chatModel.dart';
import 'package:player_connect/home_dir/chat_dir/page/chat_details_page.dart';
import 'package:player_connect/home_dir/chat_dir/provider/chat_provider.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List chatSearchUserList = [];
  bool isUserLoading = false;

  TextEditingController msgController = TextEditingController();

  IO.Socket? socket;
  List<ChatMessage> chatMessages = [
    // Add more sample messages as needed
  ];
  List chatDetailList = [];
  bool isLoading = false;

  void connect() {
    isLoading = true;
    chatDetailList.clear();
    setState(() {});
    socket = IO.io("http://18.220.106.62:3000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket?.connect();
    Map<String, dynamic> jsonData = {
      'sender_id': UserDetails.userID,
    };
    socket?.emit('get_chat_listing', jsonData);
    setState(() {});
    socket?.on('get_chat_listing', (data) {
      setState(() {
        chatDetailList.addAll(data);
        print('Chat Details List :::::----- $chatDetailList');
        isLoading = false;
      });

      int unreadMessages = getNumberOfUnreadMessages(chatDetailList);
      unreadMessagesProvider?.setUnreadMessages(unreadMessages);

      print('Number of Unread Messages :::::----- $unreadMessages');
    });
  }

  int getNumberOfUnreadMessages(List<dynamic> chatDetails) {
    int unreadCount = 0;
    for (var chat in chatDetails) {
      if (chat['status'] == 0) {
        unreadCount++;
      }
    }
    return unreadCount;
  }

  Timer? timer;

  @override
  void dispose() {
    socket?.dispose();
    timer?.cancel();
    super.dispose();
  }

  late ChatProvider? unreadMessagesProvider;

  @override
  void initState() {
    unreadMessagesProvider = Provider.of<ChatProvider>(context, listen: false);
    Provider.of<PlayerProvider>(context, listen: false).getPlayerListData();
    Provider.of<RoutesProvider>(context, listen: false)
        .getCurrentClassName(context);
    chatDetailList.clear();
    connect();
    timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      chatDetailList.clear();
      Map<String, dynamic> jsonData = {'sender_id': UserDetails.userID};
      socket?.emit('get_chat_listing', jsonData);
      socket?.connect();
    });

    super.initState();
  }

  List searchNames(String query) {
    query = query.toLowerCase();
    return chatDetailList.where((name) {
      final fullName =
          '${name["sender_first_name"]} ${name["receiver_first_name"]}'
              .toLowerCase();
      return fullName.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    deviceHeight(MediaQuery.of(context).size.height);

    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
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
                        onFieldSubmitted: (value) {
                          if (value.trim().isNotEmpty) {
                            chatSearchUserList = searchNames(value.trim());
                            setState(() {});
                          }
                        },
                        onChanged: (value) {
                          if (value.trim().isEmpty) {
                            setState(() {
                              chatSearchUserList.clear();
                            });
                          } else if (value.trim().isNotEmpty) {
                            chatSearchUserList = searchNames(value.trim());
                            setState(() {});
                          }
                        },
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
                              ),
                            )),
                      ),
                    ),
                    SizedBox(height: AppFontSize.font10),
                    chatSearchUserList.isNotEmpty
                        ? Text("Searched User")
                        : SizedBox(),
                    isLoading
                        ? Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: Center(child: CircularProgressIndicator()))
                        : provider.searchController.text.trim().isNotEmpty &&
                                chatSearchUserList.isNotEmpty
                            ? ListView.builder(
                                itemCount: chatSearchUserList.length,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: AppFontSize.font8),
                                    child: ListTile(
                                      titleAlignment:
                                          ListTileTitleAlignment.center,
                                      contentPadding: EdgeInsets.all(0),

                                      onTap: () {
                                        provider.messageId =
                                            chatSearchUserList[index]["id"]
                                                .toString();
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatDetailsPage(
                                                      name: ChatPlayerListing(
                                                        id: chatSearchUserList[
                                                            index]["id"],
                                                        receiverFirstName: UserDetails
                                                                    .userName!
                                                                    .split(" ")
                                                                    .first ==
                                                                chatSearchUserList[
                                                                            index]
                                                                        [
                                                                        "sender_first_name"]
                                                                    .toString()
                                                            ? chatSearchUserList[
                                                                    index][
                                                                "receiver_first_name"]
                                                            : chatSearchUserList[
                                                                    index][
                                                                "sender_first_name"],
                                                        senderFirstName:
                                                            chatSearchUserList[
                                                                    index][
                                                                "sender_first_name"],
                                                        lastMessage:
                                                            chatSearchUserList[
                                                                    index]
                                                                ["last_name"],
                                                        receiverImages: UserDetails
                                                                    .userPhoto!
                                                                    .split(
                                                                        "es/")
                                                                    .last ==
                                                                chatSearchUserList[
                                                                            index]
                                                                        [
                                                                        "sender_images"]
                                                                    .toString()
                                                            ? chatSearchUserList[
                                                                        index][
                                                                    "receiver_images"]
                                                                .toString()
                                                            : chatSearchUserList[
                                                                        index][
                                                                    "sender_images"]
                                                                .toString(),
                                                        senderImages:
                                                            chatSearchUserList[
                                                                    index][
                                                                "sender_images"],
                                                        receiverCity: UserDetails
                                                                    .userLocation ==
                                                                chatSearchUserList[
                                                                            index]
                                                                        [
                                                                        "sender_city"]
                                                                    .toString()
                                                            ? chatSearchUserList[
                                                                    index][
                                                                "receiver_city"]
                                                            : chatSearchUserList[
                                                                    index]
                                                                ["sender_city"],
                                                        senderCity:
                                                            chatSearchUserList[
                                                                    index]
                                                                ["sender_city"],
                                                        senderId:
                                                            chatSearchUserList[
                                                                    index]
                                                                ["sender_id"],
                                                        receiverId:
                                                            chatSearchUserList[
                                                                    index]
                                                                ["reciever_id"],

                                                        receiverIsOnline: (chatDetailList[
                                                                            index]
                                                                        [
                                                                        "sender_id"] !=
                                                                    UserDetails
                                                                        .userID &&
                                                                chatDetailList[
                                                                            index]
                                                                        [
                                                                        "receiver_is_online"] ==
                                                                    0)
                                                            ? chatSearchUserList[
                                                                    index][
                                                                "receiver_is_online"]
                                                            : chatSearchUserList[
                                                                    index][
                                                                "sender_is_online"],
                                                        senderIsOnline: chatSearchUserList[
                                                                        index][
                                                                    "sender_id"] !=
                                                                UserDetails
                                                                    .userID
                                                            ? chatSearchUserList[
                                                                    index][
                                                                "receiver_is_online"]
                                                            : chatSearchUserList[
                                                                    index][
                                                                "sender_is_online"],

                                                        // receiverIsOnline: chatSearchUserList[index]["receiver_is_online"],
                                                        // senderIsOnline: chatSearchUserList[index]["sender_is_online"],
                                                      ),
                                                    ))).whenComplete(() {
                                          Provider.of<RoutesProvider>(context,
                                                  listen: false)
                                              .currentClassName = "ChatPage";
                                          Provider.of<RoutesProvider>(context,
                                                  listen: false)
                                              .getCurrentClassName(context);

                                          provider.searchController.clear();
                                          chatDetailList[index]["status"] = 1;

                                          chatSearchUserList.clear();
                                          setState(() {});
                                        });
                                      },

                                      // Navigator.pushNamed(
                                      //     context, AppRoutes.chatDetailsPage,arguments: item);

                                      title: Text(
                                          UserDetails.userName!.split(" ").first ==
                                                  chatSearchUserList[index]
                                                          ["sender_first_name"]
                                                      .toString()
                                              ? chatSearchUserList[index]
                                                  ["receiver_first_name"]
                                              : chatSearchUserList[index]
                                                  ["sender_first_name"],
                                          style: AppFonts.poppinsFont(TextStyle(
                                              fontWeight: chatSearchUserList[index]["status"] ==
                                                          0 &&
                                                      UserDetails.userID ==
                                                          chatSearchUserList[index]
                                                                  ["reciever_id"]
                                                              .toString()
                                                  ? FontWeight.w800
                                                  : FontWeight.w400,
                                              color: AppColors.primaryColorBlue,
                                              fontSize: AppFontSize.font14))),
                                      subtitle: Text(
                                        UserDetails.userLocation ==
                                                chatSearchUserList[index]
                                                        ["sender_city"]
                                                    .toString()
                                            ? chatSearchUserList[index]
                                                ["receiver_city"]
                                            : chatSearchUserList[index]
                                                ["sender_city"],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppFonts.mazzardFont(
                                          TextStyle(
                                              fontSize: AppFontSize.font10,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors
                                                  .secondaryColorBlack),
                                        ),
                                      ),
                                      leading: Stack(
                                        children: [
                                          Container(
                                            height: AppFontSize.font45,
                                            width: AppFontSize.font45,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppFontSize.font30),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppFontSize.font30),
                                              child: CachedNetworkImage(
                                                  imageUrl: UserDetails.userPhoto!
                                                              .split("es/")
                                                              .last ==
                                                          chatSearchUserList[index]["sender_images"]
                                                              .toString()
                                                      ? AppApiUtils.imageUrl +
                                                          chatSearchUserList[index][
                                                                  "receiver_images"]
                                                              .toString()
                                                      : AppApiUtils.imageUrl +
                                                          chatSearchUserList[index][
                                                                  "sender_images"]
                                                              .toString(),
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Center(
                                                          child: Icon(Icons.error)),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                          (chatSearchUserList[index]
                                                              ["sender_id"] !=
                                                          UserDetails.userID &&
                                                      chatSearchUserList[index][
                                                              "receiver_is_online"] ==
                                                          0 ||
                                                  chatSearchUserList[index]
                                                              ["reciever_id"] !=
                                                          UserDetails.userID &&
                                                      chatSearchUserList[index][
                                                              "sender_is_online"] ==
                                                          0)
                                              ? SizedBox()
                                              : Positioned(
                                                  right: -1,
                                                  bottom: -1,
                                                  child: Container(
                                                    height: AppFontSize.font14,
                                                    width: AppFontSize.font14,
                                                    decoration: BoxDecoration(
                                                        color: chatSearchUserList[index][
                                                                        "status"] ==
                                                                    0 &&
                                                                UserDetails.userID ==
                                                                    chatSearchUserList[index]["reciever_id"]
                                                                        .toString()
                                                            ? AppColors
                                                                .primaryColorBlue
                                                            : Colors.green,
                                                        borderRadius:
                                                            BorderRadius.circular(
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
                                    ),
                                  );
                                },
                              )
                            : provider.searchController.text
                                        .trim()
                                        .isNotEmpty &&
                                    chatSearchUserList.isEmpty
                                ? Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    child: Center(child: Text("No user found")))
                                : chatDetailList.isEmpty
                                    ? Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2,
                                        child: Center(
                                          child: Text("No User Found"),
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: chatDetailList.length,
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: AppFontSize.font8),
                                            child: ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              contentPadding: EdgeInsets.all(0),
                                              title: InkWell(
                                                onTap: () {
                                                  provider.messageId =
                                                      chatDetailList[index]
                                                              ["id"]
                                                          .toString();
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChatDetailsPage(
                                                                name:
                                                                    ChatPlayerListing(
                                                                  id: chatDetailList[
                                                                          index]
                                                                      ["id"],
                                                                  receiverFirstName: UserDetails
                                                                              .userName!
                                                                              .split(
                                                                                  " ")
                                                                              .first ==
                                                                          chatDetailList[index]["sender_first_name"]
                                                                              .toString()
                                                                      ? chatDetailList[
                                                                              index]
                                                                          [
                                                                          "receiver_first_name"]
                                                                      : chatDetailList[
                                                                              index]
                                                                          [
                                                                          "sender_first_name"],
                                                                  senderFirstName:
                                                                      chatDetailList[
                                                                              index]
                                                                          [
                                                                          "sender_first_name"],
                                                                  lastMessage:
                                                                      chatDetailList[
                                                                              index]
                                                                          [
                                                                          "last_name"],
                                                                  receiverImages: UserDetails
                                                                              .userPhoto!
                                                                              .split(
                                                                                  "es/")
                                                                              .last ==
                                                                          chatDetailList[index]["sender_images"]
                                                                              .toString()
                                                                      ? chatDetailList[index]
                                                                              [
                                                                              "receiver_images"]
                                                                          .toString()
                                                                      : chatDetailList[index]
                                                                              [
                                                                              "sender_images"]
                                                                          .toString(),
                                                                  senderImages:
                                                                      chatDetailList[
                                                                              index]
                                                                          [
                                                                          "sender_images"],
                                                                  receiverCity: UserDetails
                                                                              .userLocation ==
                                                                          chatDetailList[index]["sender_city"]
                                                                              .toString()
                                                                      ? chatDetailList[
                                                                              index]
                                                                          [
                                                                          "receiver_city"]
                                                                      : chatDetailList[
                                                                              index]
                                                                          [
                                                                          "sender_city"],
                                                                  senderCity: chatDetailList[
                                                                          index]
                                                                      [
                                                                      "sender_city"],
                                                                  senderId: chatDetailList[
                                                                          index]
                                                                      [
                                                                      "sender_id"],
                                                                  receiverId: chatDetailList[
                                                                          index]
                                                                      [
                                                                      "reciever_id"],

                                                                  receiverIsOnline: (chatDetailList[index]["sender_id"] !=
                                                                              UserDetails
                                                                                  .userID &&
                                                                          chatDetailList[index]["receiver_is_online"] ==
                                                                              0)
                                                                      ? chatDetailList[
                                                                              index]
                                                                          [
                                                                          "receiver_is_online"]
                                                                      : chatDetailList[
                                                                              index]
                                                                          [
                                                                          "sender_is_online"],
                                                                  senderIsOnline: chatDetailList[index]
                                                                              [
                                                                              "sender_id"] !=
                                                                          UserDetails
                                                                              .userID
                                                                      ? chatDetailList[
                                                                              index]
                                                                          [
                                                                          "receiver_is_online"]
                                                                      : chatDetailList[
                                                                              index]
                                                                          [
                                                                          "sender_is_online"],
                                                                  // receiverIsOnline: chatDetailList[index]["receiver_is_online"],
                                                                  // senderIsOnline: chatDetailList[index]["sender_is_online"],
                                                                ),
                                                              ))).whenComplete(
                                                      () {
                                                    Provider.of<RoutesProvider>(
                                                            context,
                                                            listen: false)
                                                        .getCurrentClassName(
                                                            context);
                                                    Provider.of<RoutesProvider>(
                                                                context,
                                                                listen: false)
                                                            .currentClassName =
                                                        "ChatPage";
                                                    provider.searchController
                                                        .clear();
                                                    chatSearchUserList.clear();
                                                    chatDetailList[index]
                                                        ["status"] = 1;
                                                    setState(() {});
                                                  });
                                                },
                                                child: Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                          UserDetails.userName!
                                                                      .split(
                                                                          " ")
                                                                      .first ==
                                                                  chatDetailList[index]["sender_first_name"]
                                                                      .toString()
                                                              ? chatDetailList[index][
                                                                  "receiver_first_name"]
                                                              : chatDetailList[index]
                                                                  [
                                                                  "sender_first_name"],
                                                          style: AppFonts.poppinsFont(TextStyle(
                                                              fontWeight: chatDetailList[index]["status"] == 0 &&
                                                                      UserDetails.userID == chatDetailList[index]["reciever_id"].toString()
                                                                  ? FontWeight.w900
                                                                  : FontWeight.w400,
                                                              color: AppColors.primaryColorBlue,
                                                              fontSize: AppFontSize.font14))),
                                                      Text(
                                                          UserDetails.userLocation ==
                                                                  chatDetailList[index]["sender_city"]
                                                                      .toString()
                                                              ? chatDetailList[
                                                                      index][
                                                                  "receiver_city"]
                                                              : chatDetailList[
                                                                      index][
                                                                  "sender_city"],
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: AppFonts
                                                              .mazzardFont(TextStyle(
                                                                  fontSize:
                                                                      AppFontSize
                                                                          .font10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  color: AppColors
                                                                      .secondaryColorBlack))),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              leading: InkWell(
                                                onTap: () {
                                                  print(
                                                      'Open Requested User Profile');
                                                  playerProvider
                                                      .getIndividualProfileData(
                                                          context,
                                                          chatDetailList[index]
                                                              .id);
                                                  Navigator.pushNamed(
                                                      context,
                                                      AppRoutes
                                                          .playerProfilePage);
                                                },
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      height:
                                                          AppFontSize.font45,
                                                      width: AppFontSize.font45,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  AppFontSize
                                                                      .font30)),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppFontSize
                                                                        .font30),
                                                        child: CachedNetworkImage(
                                                            imageUrl: UserDetails.userPhoto!
                                                                        .split(
                                                                            "es/")
                                                                        .last ==
                                                                    chatDetailList[index]["sender_images"]
                                                                        .toString()
                                                                ? AppApiUtils.imageUrl +
                                                                    chatDetailList[index]["receiver_images"]
                                                                        .toString()
                                                                : AppApiUtils.imageUrl +
                                                                    chatDetailList[index]["sender_images"]
                                                                        .toString(),
                                                            placeholder: (context, url) =>
                                                                const Center(
                                                                    child:
                                                                        CircularProgressIndicator()),
                                                            errorWidget: (context,
                                                                    url,
                                                                    error) =>
                                                                const Center(child: Icon(Icons.error)),
                                                            fit: BoxFit.cover),
                                                      ),
                                                    ),
                                                    (chatDetailList[index][
                                                                        "sender_id"] !=
                                                                    UserDetails
                                                                        .userID &&
                                                                chatDetailList[
                                                                            index]
                                                                        [
                                                                        "receiver_is_online"] ==
                                                                    0 ||
                                                            chatDetailList[index]
                                                                        [
                                                                        "reciever_id"] !=
                                                                    UserDetails
                                                                        .userID &&
                                                                chatDetailList[
                                                                            index]
                                                                        [
                                                                        "sender_is_online"] ==
                                                                    0)
                                                        ? SizedBox()
                                                        : Positioned(
                                                            right: -1,
                                                            bottom: -1,
                                                            child: Container(
                                                              height:
                                                                  AppFontSize
                                                                      .font14,
                                                              width: AppFontSize
                                                                  .font14,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: chatDetailList[index]["status"] ==
                                                                            0 &&
                                                                        UserDetails.userID ==
                                                                            chatDetailList[index]["reciever_id"]
                                                                                .toString()
                                                                    ? AppColors
                                                                        .primaryColorBlue
                                                                    : Colors
                                                                        .green,
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        AppFontSize
                                                                            .font8),
                                                                border: Border.all(
                                                                    color: AppColors
                                                                        .secondaryColorWhite,
                                                                    width: 2),
                                                              ),
                                                            ),
                                                          )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
