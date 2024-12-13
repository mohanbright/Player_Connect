// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:player_connect/home_dir/player_dir/provider/player_provider.dart';
import 'package:player_connect/login_dir/provider/login_provider.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  getFcmToken() async {
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.getToken().then((value) async => {
          LocalDataSaver.saveUserFcmToken(value),
          await fetchDataSPreferences(),
          print("==========$value"),
          setState(() {}),
        });
  }

  @override
  void initState() {
    getFcmToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppFontSize.font24,
                        vertical: AppFontSize.font10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: MediaQuery.of(context).padding.top),
                        Image(
                          image: AssetImage(AppImages.appLogo),
                          height: AppFontSize.font60,
                          width: AppFontSize.font70,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: AppFontSize.font10),
                        buildTextSpan(AppStrings.strLog, AppStrings.strIN),
                        SizedBox(height: AppFontSize.font18),
                        Text(
                          AppStrings.strEmail,
                          style: AppFonts.poppinsFont(
                            TextStyle(
                                fontSize: AppFontSize.font12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryColorBlack),
                          ),
                        ),
                        SizedBox(height: AppFontSize.font10),
                        textFieldContainer(provider, provider.emailController,
                            AppStrings.strEnterEmail),
                        SizedBox(height: AppFontSize.font18),
                        Text(AppStrings.strPwd,
                            style: AppFonts.poppinsFont(TextStyle(
                                fontSize: AppFontSize.font12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryColorBlack))),
                        SizedBox(height: AppFontSize.font10),
                        textFieldContainer(provider,
                            provider.passwordController, AppStrings.strPwd),
                        SizedBox(height: AppFontSize.font18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.forgotPasswordPage);
                              },
                              child: Text(AppStrings.strForgotPwd,
                                  textAlign: TextAlign.end,
                                  style: AppFonts.poppinsFont(TextStyle(
                                      fontSize: AppFontSize.font14,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.primaryColorBlue))),
                            ),
                          ],
                        ),
                        SizedBox(height: AppFontSize.font24),
                        InkWell(
                          onTap: () {
                            if (provider.emailController.text.trim().isEmpty) {
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strEnterEmail);
                            } else if (provider.passwordController.text
                                .trim()
                                .isEmpty) {
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strEnterPwd);
                            } else {
                              // AppSnackBarToast.buildShowSnackBar(
                              //     context, "Login Successfully");
                              Provider.of<PlayerProvider>(context,
                                      listen: false)
                                  .selectedId = 1;
                              getFcmToken();
                              provider.login(context)?.then((value) {
                                if (value == true) {
                                  provider.emailController.clear();
                                  provider.passwordController.clear();
                                  pageSelected = 0;
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.dashBoardPage,
                                      (route) => false);
                                }
                              });
                            }
                          },
                          child: AppButtons.elevatedButton(
                              AppStrings.strLogin.toUpperCase(),
                              AppFonts.poppinsFont(TextStyle(
                                  fontSize: AppFontSize.font14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryColorWhite)),
                              AppColors.primaryColorBlue),
                        ),
                        SizedBox(height: AppFontSize.font22),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                color: AppColors.infoPageCount,
                                height: 1,
                                width:
                                    MediaQuery.of(context).size.width / 10.5),
                            SizedBox(width: AppFontSize.font4),
                            Text(AppStrings.strSignInWithSocial,
                                textAlign: TextAlign.end,
                                style: AppFonts.poppinsFont(TextStyle(
                                    fontSize: AppFontSize.font14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.infoPageCount))),
                            SizedBox(width: AppFontSize.font4),
                            Container(
                                color: AppColors.infoPageCount,
                                height: 1,
                                width:
                                    MediaQuery.of(context).size.width / 10.5),
                          ],
                        ),
                        SizedBox(height: AppFontSize.font20),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                  onTap: () {
                                    provider.facebookSignInOrSignUp(context);
                                  },
                                  child: mediaImage(AppImages.fbLogoImg)),
                              InkWell(
                                  onTap: () {
                                    // signProvider.dialogBoxApp(context, "1", "Z6umrOGgA5fFfGokqhPcwXVjeN42");
                                    provider.appleSignInOrSignUp(context);
                                  },
                                  child: Container(
                                    height: AppFontSize.font60,
                                    width: AppFontSize.font60,
                                    decoration: BoxDecoration(
                                        color: AppColors.secondaryColorWhite,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(500))),
                                    child: Center(
                                      child: Image(
                                        image:
                                            AssetImage(AppImages.appleLogoImg),
                                        height: AppFontSize.font40,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )),
                              InkWell(
                                  onTap: () {
                                    provider.getFcmToken();
                                    provider.signInOrSignUpGoogle(context);
                                    // provider.checkUser(context, 'davindersingh00743@gmail.com');
                                  },
                                  child: mediaImage(AppImages.googleLogoImg)),
                              InkWell(
                                  onTap: () async {
                                    provider.twitterSignInOrSignUp(context);
                                  },
                                  child: mediaImage(AppImages.twitterXLogoImg)),
                            ]),
                        SizedBox(height: AppFontSize.font30),
                        Text.rich(TextSpan(
                            text: AppStrings.strNewMember,
                            style: AppFonts.poppinsFont(TextStyle(
                                fontWeight: FontWeight.w400,
                                color: AppColors.secondaryColorBlack,
                                fontSize: AppFontSize.font14)),
                            children: <InlineSpan>[
                              TextSpan(
                                  text: AppStrings.strSignUp.toUpperCase(),
                                  style: AppFonts.poppinsFont(TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primaryColorBlue,
                                      fontSize: AppFontSize.font14)),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushReplacementNamed(
                                          context, AppRoutes.signUpPage);
                                    })
                            ])),
                        SizedBox(height: AppFontSize.font32),
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: provider.isLoading,
                    child: Scaffold(
                        backgroundColor: Colors.black45,
                        body: Center(
                          child: CircularProgressIndicator(),
                        )))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget mediaImage(imgName) {
    return Image(
      image: AssetImage(imgName),
      height: AppFontSize.font60,
      width: AppFontSize.font60,
      fit: BoxFit.fill,
    );
  }

  Widget textFieldContainer(LoginProvider provider, controller, hintText) {
    return Container(
      height: AppFontSize.font45,
      decoration: BoxDecoration(
          color: AppColors.secondaryColorWhite,
          borderRadius: BorderRadius.circular(AppFontSize.font12)),
      child: Center(
        child: TextFormField(
            obscureText: controller == provider.emailController
                ? false
                : provider.isShowPassword,
            controller: controller,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                contentPadding: EdgeInsets.fromLTRB(14, 10, 10, 10),
                hintStyle: AppFonts.poppinsFont(TextStyle(
                    fontSize: AppFontSize.font14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.infoPageCount)),
                suffixIcon: controller == provider.passwordController
                    ? Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: InkWell(
                          onTap: () {
                            provider.setShowPassword();
                          },
                          child: Icon(
                            provider.isShowPassword == true
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 20,
                          ),
                        ))
                    : Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        child: Icon(
                          Icons.visibility_off,
                          size: 20,
                          color: Colors.white,
                        ),
                      ))),
      ),
    );
  }
}
