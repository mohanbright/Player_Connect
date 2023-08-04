// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/chat_dir/page/chat_page.dart';
import 'package:player_connect/home_dir/connect_dir/page/connect_page.dart';
import 'package:player_connect/home_dir/my_profile_dir/page/my_profile_page.dart';
import 'package:player_connect/home_dir/player_dir/page/player_page.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/botm_nav_img.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  int _selectedIndex = 0;

  List tabList = [
    PlayerPage(),
    ChatPage(),
    ConnectPage(),
    MyProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    deviceHeight(MediaQuery.of(context).size.height);
    return Scaffold(
      body: tabList[_selectedIndex],
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
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
        showUnselectedLabels: true,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
              icon: _selectedIndex == 0
                  ? ImageIcon(AssetImage(AppBotmNavImg.playerS),
                      size: AppFontSize.font20)
                  : ImageIcon(AssetImage(AppBotmNavImg.playerN),
                      size: AppFontSize.font20),
              label: AppStrings.strPlayers),
          BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage(AppBotmNavImg.chatN),
                size: AppFontSize.font20,
              ),
              label: AppStrings.strChat),
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
      _selectedIndex = index;
    });
  }
}
