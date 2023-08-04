// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:player_connect/login_dir/provider/create_profile_provider.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/local_db_saver.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';

class CreateProfilePage3 extends StatefulWidget {
  const CreateProfilePage3({Key? key}) : super(key: key);

  @override
  State<CreateProfilePage3> createState() => _CreateProfilePage3State();
}

class _CreateProfilePage3State extends State<CreateProfilePage3> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateProfileProvider>(
      create: (_) {
        return CreateProfileProvider();
      },
      child: Consumer<CreateProfileProvider>(
        builder: (context, provider, child) {
          return SafeArea(
              child: Scaffold(
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppFontSize.font24,
                        vertical: AppFontSize.font20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(AppImages.appLogo),
                          height: AppFontSize.font50,
                          width: AppFontSize.font60,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: AppFontSize.font24),
                        Text(AppStrings.strWhereLocated,
                            style: AppFonts.mazzardFont(TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColorBlue,
                                fontSize: AppFontSize.font16))),
                        SizedBox(height: AppFontSize.font20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: LinearProgressIndicator(
                                // value: provider.completeProgressBar,
                                value: progressTaskValue,
                                color: AppColors.primaryColorSkyBlue,
                                minHeight: AppFontSize.font8,
                                backgroundColor:
                                    AppColors.secondaryColorLightGrey,
                                // borderRadius:
                                //     BorderRadius.circular(AppFontSize.font4),
                              ),
                            ),
                            SizedBox(width: AppFontSize.font14),
                            Text.rich(TextSpan(
                                // text: '${provider.completeTaskValue}',
                                text: '$progressTaskDone',
                                style: AppFonts.poppinsFont(TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryColorBlue,
                                    fontSize: AppFontSize.font16)),
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: '/5',
                                    style: AppFonts.poppinsFont(TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryColorBlue,
                                        fontSize: AppFontSize.font16)),
                                  )
                                ])),
                          ],
                        ),
                        SizedBox(height: AppFontSize.font20),
                        provider.buildText(AppStrings.strFindCity),
                        SizedBox(height: AppFontSize.font12),
                        Container(
                          // height: AppFontSize.font45,
                          decoration: BoxDecoration(
                              color: AppColors.secondaryColorWhite,
                              border: Border.all(
                                  color: AppColors.infoPageCount, width: 1),
                              borderRadius:
                                  BorderRadius.circular(AppFontSize.font12)),
                          child: Center(
                            child: TextFormField(
                                onTap: () async {
                                  provider.isLocationLoading = true;
                                  setState(() {});
                                  provider
                                      .getCurrentPosition(context)
                                      .whenComplete(() {
                                    provider.isLocationLoading = false;
                                    setState(() {});
                                  });
                                },
                                controller: provider.locationController,
                                readOnly: true,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppStrings.strSelect,
                                    contentPadding:
                                        EdgeInsets.fromLTRB(14, 14, 10, 10),
                                    hintStyle: AppFonts.poppinsFont(TextStyle(
                                        fontSize: AppFontSize.font14,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.secondaryColorBlack)),
                                    suffixIcon: Align(
                                        widthFactor: 1,
                                        heightFactor: 1,
                                        child: Image(
                                          image: AssetImage(
                                              AppIconImages.locationIconImg),
                                          height: AppFontSize.font24,
                                          width: AppFontSize.font24,
                                        )))),
                          ),
                        ),
                        SizedBox(height: AppFontSize.font300),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                // provider.setProgressTask(2);
                                // provider.setProgressBar(0.4);
                                Navigator.pop(context);
                              },
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: AppButtons.elevatedButton(
                                      AppStrings.strBack.toUpperCase(),
                                      AppFonts.mazzardFont(TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColorBlue,
                                          fontSize: AppFontSize.font16)),
                                      AppColors.primaryColorSkyBlue)),
                            ),
                            InkWell(
                              onTap: () async {
                                if (provider.locationController.text
                                    .trim()
                                    .isEmpty) {
                                  AppSnackBarToast.buildShowSnackBar(
                                      context, AppStrings.strSelectCity);
                                } else {
                                  LocalDataSaver.saveUserLocation(
                                      provider.locationController.text);
                                  await fetchDataSPreferences();

                                  provider.setProgressTask(4);
                                  provider.setProgressBar(0.8);

                                  progressTaskValue > 0.8
                                      ? null
                                      : progressTaskValue = 0.8;
                                  progressTaskDone > 4
                                      ? null
                                      : progressTaskDone = 4;

                                  Navigator.pushNamed(
                                      context, AppRoutes.createProfilePage4);
                                }
                              },
                              child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: AppButtons.elevatedButton(
                                      AppStrings.strNext.toUpperCase(),
                                      AppFonts.mazzardFont(TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondaryColorWhite,
                                          fontSize: AppFontSize.font16)),
                                      AppColors.primaryColorBlue)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                    visible: provider.isLocationLoading,
                    child: Scaffold(
                        backgroundColor: Colors.black45,
                        body: Center(
                          child: CircularProgressIndicator(),
                        )))
              ],
            ),
          ));
        },
      ),
    );
  }
}
