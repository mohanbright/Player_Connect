import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/chat_dir/page/chat_details_page.dart';
import 'package:player_connect/home_dir/chat_dir/page/chat_page.dart';
import 'package:player_connect/home_dir/connect_dir/page/connect_page.dart';
import 'package:player_connect/home_dir/connect_dir/page/request_page.dart';
import 'package:player_connect/home_dir/my_profile_dir/page/my_profile_page.dart';
import 'package:player_connect/home_dir/player_dir/page/player_page.dart';
import 'package:player_connect/home_dir/player_dir/page/player_profile.dart';
import 'package:player_connect/home_dir/player_dir/page/recommended_page.dart';
import 'package:player_connect/login_dir/page/connect_with_page.dart';
import 'package:player_connect/login_dir/page/create_profile_dir/create_profile_page1.dart';
import 'package:player_connect/login_dir/page/create_profile_dir/create_profile_page2.dart';
import 'package:player_connect/login_dir/page/create_profile_dir/create_profile_page3.dart';
import 'package:player_connect/login_dir/page/create_profile_dir/create_profile_page4.dart';
import 'package:player_connect/login_dir/page/create_profile_dir/create_profile_page5.dart';
import 'package:player_connect/login_dir/page/forgot_password_page.dart';
import 'package:player_connect/login_dir/page/login_page.dart';
import 'package:player_connect/login_dir/page/new_password_page.dart';
import 'package:player_connect/login_dir/page/sign_up_page.dart';
import 'package:player_connect/login_dir/page/verified_page.dart';
import 'package:player_connect/setting_dir/page/change_pass_page.dart';
import 'package:player_connect/setting_dir/page/contact_support_page.dart';
import 'package:player_connect/setting_dir/page/delete_account_page.dart';
import 'package:player_connect/setting_dir/page/edit_profile_dir/edit_profile_page1.dart';
import 'package:player_connect/setting_dir/page/edit_profile_dir/edit_profile_page2.dart';
import 'package:player_connect/setting_dir/page/edit_profile_dir/edit_profile_page3.dart';
import 'package:player_connect/setting_dir/page/edit_profile_dir/edit_profile_page4.dart';
import 'package:player_connect/setting_dir/page/edit_profile_dir/edit_profile_page5.dart';
import 'package:player_connect/setting_dir/page/notification_page.dart';
import 'package:player_connect/setting_dir/page/setting_page.dart';
import 'package:player_connect/shared/page/dashboard_page.dart';
import 'package:player_connect/shared/page/player_info_page.dart';
import 'package:player_connect/shared/page/splash_page.dart';

class AppRoutes {
  static const String splashPage = "Splash Page";
  static const String playerInfoPage = "Player Info Page";
  static const String loginPage = "Login Page";
  static const String signUpPage = "Sign Up Page";
  static const String forgotPasswordPage = "Forgot Password Page";
  static const String newPasswordPage = "New Password Page";
  static const String verifiedPage = "Verified Page";
  static const String createProfilePage1 = "Create Profile Page 1";
  static const String createProfilePage2 = "Create Profile Page 2";
  static const String createProfilePage3 = "Create Profile Page 3";
  static const String createProfilePage4 = "Create Profile Page 4";
  static const String createProfilePage5 = "Create Profile Page 5";
  static const String connectWithPage = "Connect With Page";
  static const String dashBoardPage = "DashBoard Page";
  static const String playerPage = "Player Page";
  static const String chatPage = "Chat Page";
  static const String connectPage = "Connect Page";
  static const String myProfilePage = "My Profile Page";
  static const String recommendedPage = "Recommended Page";
  static const String playerProfilePage = "Player Profile Page";
  static const String chatDetailsPage = "Chat Details Page";
  static const String settingPage = "Setting Page";
  static const String deleteAccountPage = "Delete Account Page";
  static const String editProfilePage1 = "Edit Profile Page 1";
  static const String editProfilePage2 = "Edit Profile Page 2";
  static const String editProfilePage3 = "Edit Profile Page 3";
  static const String editProfilePage4 = "Edit Profile Page 4";
  static const String editProfilePage5 = "Edit Profile Page 5";
  static const String notificationPage = "Notification Page";
  static const String changePassPage = "Change Pass Page";
  static const String contactSupportPage = "Contact Support Page";
  static const String requestPage = "Request Page";
}

Map<String, WidgetBuilder> routes = {
  AppRoutes.splashPage: (context) => const SplashPage(),
  AppRoutes.playerInfoPage: (context) => const PlayerInfoPage(),
  AppRoutes.loginPage: (context) => const LoginPage(),
  AppRoutes.signUpPage: (context) => const SignUpPage(),
  AppRoutes.forgotPasswordPage: (context) => const ForgotPasswordPage(),
  AppRoutes.newPasswordPage: (context) => const NewPasswordPage(),
  AppRoutes.verifiedPage: (context) => const VerifiedPage(),
  AppRoutes.createProfilePage1: (context) => const CreateProfilePage1(),
  AppRoutes.createProfilePage2: (context) => const CreateProfilePage2(),
  AppRoutes.createProfilePage3: (context) => const CreateProfilePage3(),
  AppRoutes.createProfilePage4: (context) => const CreateProfilePage4(),
  AppRoutes.createProfilePage5: (context) => const CreateProfilePage5(),
  AppRoutes.connectWithPage: (context) => const ConnectWithPage(),
  AppRoutes.dashBoardPage: (context) => const DashBoardPage(),
  AppRoutes.playerPage: (context) => const PlayerPage(),
  AppRoutes.chatPage: (context) => const ChatPage(),
  AppRoutes.connectPage: (context) => const ConnectPage(),
  AppRoutes.myProfilePage: (context) => const MyProfilePage(),
  AppRoutes.recommendedPage: (context) => const RecommendedPage(),
  AppRoutes.playerProfilePage: (context) => const PlayerProfilePage(),
  AppRoutes.chatDetailsPage: (context) => const ChatDetailsPage(),
  AppRoutes.settingPage: (context) => const SettingPage(),
  AppRoutes.deleteAccountPage: (context) => const DeleteAccountPage(),
  AppRoutes.editProfilePage1: (context) => const EditProfilePage1(),
  AppRoutes.editProfilePage2: (context) => const EditProfilePage2(),
  AppRoutes.editProfilePage3: (context) => const EditProfilePage3(),
  AppRoutes.editProfilePage4: (context) => const EditProfilePage4(),
  AppRoutes.editProfilePage5: (context) => const EditProfilePage5(),
  AppRoutes.notificationPage: (context) => const NotificationPage(),
  AppRoutes.changePassPage: (context) => const ChangePassPage(),
  AppRoutes.contactSupportPage: (context) => const ContactSupportPage(),
  AppRoutes.requestPage: (context) => const RequestPage(),
};
