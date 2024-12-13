// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/chat_dir/model/chat_player_list.dart';
import 'package:player_connect/home_dir/chat_dir/page/chat_details_page.dart';
import 'package:player_connect/home_dir/chat_dir/page/chat_page.dart';
import 'package:player_connect/home_dir/chat_dir/provider/chat_provider.dart';
import 'package:player_connect/home_dir/connect_dir/page/connect_page.dart';
import 'package:player_connect/home_dir/connect_dir/provider/connect_provider.dart';
import 'package:player_connect/home_dir/my_profile_dir/page/my_profile_page.dart';
import 'package:player_connect/home_dir/my_profile_dir/provider/my_profile_provider.dart';
import 'package:player_connect/home_dir/player_dir/page/player_page.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/main.dart';
import 'package:player_connect/shared/auth/is_user_online.dart';
import 'package:player_connect/shared/auth/notification_service.dart';
import 'package:player_connect/shared/constant/api_utils.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/botm_nav_img.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/user_info.dart';
import 'package:player_connect/shared/models/notification_chat_message_model.dart';
import 'package:player_connect/shared/provider/routes_provider.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatefulWidget {
  final int? unreadMessages;

  const DashBoardPage({Key? key, this.unreadMessages}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  List tabList = [
    PlayerPage(),
    ChatPage(),
    ConnectPage(),
    MyProfilePage(),
  ];

  getPage() {
    NotificationService.onMessageOpen(context);
  }

  onMessage() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final chatId = message.data['sender_id'];
      final senderID = message.data['sender_id'];
      final chatMessage = message.data['last_name'];
      final firstName = message.data['first_name'];
      final lastName = message.data['last_name'];
      final image = message.data['images'];
      final city = message.data['city'];

      final newChatMessage = NotificationChatMessageModel(
        chatId: chatId,
        senderID: senderID,
        message: chatMessage,
        receiverID: UserDetails.userID!,
        firstName: firstName,
        lastName: lastName,
        image: image,
        city: city,
      );
      chatMessagesNotificationList.clear();
      setState(() {});
      bool isDataContains = chatMessagesNotificationList
          .any((message) => message.senderID == senderID);
      // String currentClassName =
      //     Provider.of<RoutesProvider>(context, listen: false)
      //         .getCurrentClassName(context);

      if (message.notification!.title.toString() == "New Message Received" &&
          isDataContains == false &&
          Provider.of<RoutesProvider>(context, listen: false)
                  .currentClassName !=
              "ChatDetailsPage") {
        showNotification(chatMessage);

        chatMessagesNotificationList.add(newChatMessage);
        setState(() {});
      }
      setState(() {});
    });
  }

  OverlayEntry? notificationOverlay;

  void showNotification(String message) {
    notificationOverlay = OverlayEntry(
        builder: (context) => pageSelected != 3
            ? Positioned(top: 0, left: 0, child: material(context))
            : Positioned(top: 0, right: 0, child: material(context)));
    Overlay.of(context).insert(notificationOverlay!);
    Future.delayed(Duration(seconds: 3), () {
      notificationOverlay!.remove();
    });
  }

  Material material(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  tileColor: Colors.white,
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(
                            builder: (context) => ChatDetailsPage(
                                    name: ChatPlayerListing(
                                  receiverFirstName:
                                      chatMessagesNotificationList[0].firstName,
                                  lastMessage:
                                      chatMessagesNotificationList[0].message,
                                  receiverImages:
                                      chatMessagesNotificationList[0].image,
                                  receiverCity:
                                      chatMessagesNotificationList[0].city,
                                  receiverId: int.parse(
                                      chatMessagesNotificationList[0].senderID),
                                  senderId:
                                      int.parse(UserDetails.userID.toString()),
                                  receiverIsOnline: 1,
                                ))))
                        .whenComplete(() {
                      Provider.of<RoutesProvider>(context, listen: false)
                          .currentClassName = "DashBoardPage";
                      Provider.of<RoutesProvider>(context, listen: false)
                          .getCurrentClassName(context);
                    });
                  },
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(AppApiUtils.imageUrl +
                          chatMessagesNotificationList[0].image)),
                  title: Text(
                      "${chatMessagesNotificationList[0].firstName} sent you a message"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    onMessage();
    UserOnlineApiService.getInstance().isUserOnline(1);
    Provider.of<RoutesProvider>(context, listen: false)
        .getCurrentClassName(context);
    Provider.of<PlayerProvider>(context, listen: false).getPlayerListData();
    // Provider.of<PlayerProvider>(context, listen: false).getIRecommendedData();
    Provider.of<ConnectProvider>(context, listen: false).connectReqPlayer();
    Provider.of<ConnectProvider>(context, listen: false).connectPlayer();
    Provider.of<MyProfileProvider>(context, listen: false).fetchUserProfile();
    print("getProviderData:::$pageSelected");
    getPage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight(MediaQuery.of(context).size.height);
    NotificationService.initialized(context);
    NotificationService.getInitialMessage();
    NotificationService.onMessage();
    // NotificationService.onMessageOpen(context);
    return Scaffold(
      body: tabList[pageSelected],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        currentIndex: pageSelected,
        onTap: onTabSelect,
        iconSize: AppFontSize.font20,
        selectedFontSize: AppFontSize.font12,
        unselectedFontSize: AppFontSize.font12,
        selectedItemColor: AppColors.primaryColorBlue,
        unselectedItemColor: AppColors.primaryColorSkyBlue,
        selectedLabelStyle: AppFonts.poppinsFont(TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.primaryColorBlue,
            fontSize: AppFontSize.font12)),
        unselectedLabelStyle: AppFonts.poppinsFont(TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.primaryColorSkyBlue,
            fontSize: AppFontSize.font12)),
        // selectedIconTheme: IconThemeData(color: AppColors.primaryColorBlue),
        // unselectedIconTheme:
        //     IconThemeData(color: AppColors.primaryColorSkyBlue),
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: pageSelected == 0
                  ? ImageIcon(AssetImage(AppBotmNavImg.playerS),
                      size: AppFontSize.font20)
                  : ImageIcon(AssetImage(AppBotmNavImg.playerN),
                      size: AppFontSize.font20),
              label: AppStrings.strPlayers),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                ImageIcon(
                  AssetImage(AppBotmNavImg.chatN),
                  size: AppFontSize.font20,
                ),
                Positioned(
                  top: -10,
                  right: -8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: Text(
                      Provider.of<ChatProvider>(context)
                          .unreadMessages
                          .toString(),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            label: AppStrings.strChat,
          ),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppBotmNavImg.connectN),
                size: AppFontSize.font20,
              ),
              label: AppStrings.strConnect),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppBotmNavImg.profileN),
                size: AppFontSize.font20,
              ),
              label: AppStrings.strMyProfile),
        ]);
  }

  onTabSelect(index) {
    setState(() {
      pageSelected = index;
    });
  }
}
