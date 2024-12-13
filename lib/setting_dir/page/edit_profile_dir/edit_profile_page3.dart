// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/edit_profile_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:provider/provider.dart';

class EditProfilePage3 extends StatefulWidget {
  const EditProfilePage3({Key? key}) : super(key: key);

  @override
  State<EditProfilePage3> createState() => _EditProfilePage3State();
}

class _EditProfilePage3State extends State<EditProfilePage3> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EditProfileProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Stack(
            children: [
              Scaffold(
                backgroundColor: AppColors.bgColor,
                appBar: provider.buildAppBar( context, 3),
                body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(AppFontSize.font12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        provider.buildText("Your location"),
                        SizedBox(height: AppFontSize.font12),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColorWhite,
                            border: Border.all(color: AppColors.infoPageCount, width: 1),
                            borderRadius: BorderRadius.circular(AppFontSize.font12),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: provider.locationController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: AppStrings.strSelect,
                                contentPadding: EdgeInsets.fromLTRB(14, 14, 10, 10),
                                hintStyle: AppFonts.poppinsFont(
                                  TextStyle(
                                    fontSize: AppFontSize.font14,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.secondaryColorBlack,
                                  ),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () async {
                                    provider.isLocationLoading = true;
                                    setState(() {});
                                    await provider.getCurrentPosition(context);
                                    provider.isLocationLoading = false;
                                    setState(() {});
                                  },
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      AppIconImages.locationIconImg,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppFontSize.font300),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  child: AppButtons.elevatedButton(
                                      AppStrings.strBack.toUpperCase(),
                                      AppFonts.mazzardFont(TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColorBlue,
                                          fontSize: AppFontSize.font14)),
                                      AppColors.primaryColorSkyBlue)),
                            ),
                            InkWell(
                              onTap: () {
                                if (provider.isChanged == true) {
                                  Navigator.pushNamed(
                                      context, AppRoutes.editProfilePage4);
                                  provider.isChanged = false;
                                } else {
                                  Navigator.pushNamed(
                                      context, AppRoutes.editProfilePage4);
                                }
                              },
                              child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 2.5,
                                  child: AppButtons.elevatedButton(
                                      AppStrings.strNext.toUpperCase(),
                                      AppFonts.mazzardFont(TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondaryColorWhite,
                                          fontSize: AppFontSize.font14)),
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
              ),
              Visibility(
                  visible: provider.isLoading,
                  child: Scaffold(
                    backgroundColor: Colors.black26,
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}
