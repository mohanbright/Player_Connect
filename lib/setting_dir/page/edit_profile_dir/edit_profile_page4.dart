// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:player_connect/setting_dir/provider/edit_profile_provider.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/widget/alert_box.dart';
import 'package:provider/provider.dart';

class EditProfilePage4 extends StatefulWidget {
  const EditProfilePage4({Key? key}) : super(key: key);

  @override
  State<EditProfilePage4> createState() => _EditProfilePage4State();
}

class _EditProfilePage4State extends State<EditProfilePage4> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileProvider>(
      create: (_) {
        return EditProfileProvider();
      },
      child: Consumer<EditProfileProvider>(
        builder: (context, provider, child) {
          return SafeArea(
              child: Scaffold(
            backgroundColor: AppColors.bgColor,
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: AppColors.secondaryColorWhite,
              // leading: InkWell(
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   child: Image(
              //     image: AssetImage(AppIconImages.backIconImg),
              //     height: AppFontSize.font24,
              //     width: AppFontSize.font24,
              //   ),
              // ),
              iconTheme: IconThemeData(color: AppColors.secondaryColorBlack),
              centerTitle: true,
              title: Text(AppStrings.strEditProfile,
                  style: AppFonts.mazzardFont(TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryColorBlue,
                      fontSize: AppFontSize.font18))),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(AppFontSize.font12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    provider.buildText(AppStrings.strHaveUtr),
                    Row(
                      children: [
                        Container(
                          width: 150,
                          child: RadioListTile(
                            contentPadding: EdgeInsets.all(0),
                            visualDensity: VisualDensity.compact,
                            activeColor: AppColors.primaryColorSkyBlue,
                            title: Text(AppStrings.strYes),
                            value: true,
                            groupValue: provider.isUtrRating,
                            onChanged: (value) {
                              provider.getBoolUtrRating(value as bool);
                            },
                          ),
                        ),
                        Container(
                          width: 150,
                          child: RadioListTile(
                            contentPadding: EdgeInsets.all(0),
                            activeColor: AppColors.primaryColorSkyBlue,
                            title: Text(AppStrings.strNo),
                            value: false,
                            groupValue: provider.isUtrRating,
                            onChanged: (value) {
                              provider.getBoolUtrRating(value as bool);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppFontSize.font14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        provider.buildText(provider.isUtrRating
                            ? AppStrings.strUtrRating
                            : AppStrings.strNtrpRating),
                        SizedBox(width: AppFontSize.font4),
                        provider.isUtrRating
                            ? SizedBox()
                            : Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialogWidget(
                                              provider: provider,
                                            );
                                          });
                                    },
                                    child: Image(
                                      image:
                                          AssetImage(AppIconImages.helpIconImg),
                                      height: AppFontSize.font20,
                                      width: AppFontSize.font20,
                                    ),
                                  ),
                                  SizedBox(width: AppFontSize.font4),
                                  Text(AppStrings.strNotSureRatingIs,
                                      style: AppFonts.mazzardFont(TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.infoPageCount,
                                          fontSize: AppFontSize.font14))),
                                ],
                              ),
                        Spacer(),
                        provider.isUtrRating
                            ? Text(provider.userUtrRating.toString(),
                                style: AppFonts.poppinsFont(TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryColorBlack,
                                    fontSize: AppFontSize.font14)))
                            : Text(provider.userNtrpRating.toString(),
                                style: AppFonts.poppinsFont(TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.secondaryColorBlack,
                                    fontSize: AppFontSize.font14)))
                      ],
                    ),
                    SizedBox(height: AppFontSize.font12),
                    Container(
                      width: MediaQuery.of(context).size.width -
                          (AppFontSize.font24 + AppFontSize.font24),
                      child: Slider(
                        min: 0.0,
                        max: 16.5,
                        // allowedInteraction: SliderInteraction.tapAndSlide,
                        activeColor: AppColors.primaryColorBlue,
                        thumbColor: AppColors.secondaryColorBlack,

                        inactiveColor: AppColors.infoPageCount,
                        value: provider.isUtrRating
                            ? provider.userUtrRating
                            : provider.userNtrpRating,
                        onChanged: (value) {
                          setState(() {});
                        },
                        onChangeEnd: (value) {
                          debugPrint(value.toStringAsFixed(1));
                          provider.isUtrRating
                              ? provider.userUtrRating =
                                  double.parse(value.toStringAsFixed(1))
                              : provider.userNtrpRating =
                                  double.parse(value.toStringAsFixed(1));
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: AppFontSize.font30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        provider.buildText(AppStrings.strMaxDriveDistance),
                        Text(
                            "${provider.userMaxDrivDis} '${AppStrings.strMiles}",
                            style: AppFonts.poppinsFont(TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryColorBlack,
                                fontSize: AppFontSize.font14)))
                      ],
                    ),
                    SizedBox(height: AppFontSize.font12),
                    Container(
                      width: MediaQuery.of(context).size.width -
                          (AppFontSize.font24 + AppFontSize.font24),
                      child: Slider(
                        min: 0.0,
                        max: 50,
                        // allowedInteraction: SliderInteraction.tapAndSlide,
                        activeColor: AppColors.primaryColorBlue,
                        thumbColor: AppColors.secondaryColorBlack,
                        inactiveColor: AppColors.infoPageCount,
                        value: provider.userMaxDrivDis,
                        onChanged: (value) {
                          setState(() {});
                        },
                        onChangeEnd: (value) {
                          debugPrint(value.toStringAsFixed(1));
                          provider.userMaxDrivDis =
                              double.parse(value.toStringAsFixed(1));
                          setState(() {});
                        },
                      ),
                    ),
                    SizedBox(height: AppFontSize.font30),
                    provider.buildText(AppStrings.strDesiredpartner),
                    SizedBox(height: AppFontSize.font12),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.secondaryColorWhite,
                          border: Border.all(
                              color: AppColors.infoPageCount, width: 1),
                          borderRadius:
                              BorderRadius.circular(AppFontSize.font12)),
                      child: Center(
                        child: TextFormField(
                            controller: provider.desiredPartnerController,
                            maxLines: 7,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppStrings.strWhatLookingFor,
                              contentPadding:
                                  EdgeInsets.fromLTRB(14, 14, 10, 10),
                              hintStyle: AppFonts.poppinsFont(TextStyle(
                                  fontSize: AppFontSize.font14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.infoPageCount)),
                            )),
                      ),
                    ),
                    SizedBox(height: AppFontSize.font40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: AppButtons.elevatedButton(
                                  AppStrings.strBack.toUpperCase(),
                                  AppFonts.mazzardFont(TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primaryColorBlue,
                                      fontSize: AppFontSize.font16)),
                                  AppColors.primaryColorSkyBlue)),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.editProfilePage5);
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width / 2.5,
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
          ));
        },
      ),
    );
  }
}
