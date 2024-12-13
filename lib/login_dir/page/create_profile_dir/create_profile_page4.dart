// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:player_connect/login_dir/provider/create_profile_provider.dart';
import 'package:player_connect/setting_dir/page/edit_profile_dir/edit_profile_page4.dart';
import 'package:player_connect/shared/constant/app_details.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/button.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/icon_image.dart';
import 'package:player_connect/shared/constant/images.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';
import 'package:player_connect/shared/auth/routes.dart';
import 'package:player_connect/shared/widget/alert_box.dart';
import 'package:provider/provider.dart';

class CreateProfilePage4 extends StatefulWidget {
  const CreateProfilePage4({Key? key}) : super(key: key);

  @override
  State<CreateProfilePage4> createState() => _CreateProfilePage4State();
}

class _CreateProfilePage4State extends State<CreateProfilePage4> {
  double _sliderValue = 1.0;

  List<Map<String, double>> predefinedRanges = [
  {'min': 1.0, 'max': 3.0},
  {'min': 3.0, 'max': 6.0},
  {'min': 6.0, 'max': 9.0},
  {'min': 9.0, 'max': 12.0},
  {'min': 12.0, 'max': 15.0},
  {'min': 15.0, 'max': 16.5},
  ];

  Map<String, double> _currentRange = {'min': 1.0, 'max': 3.0};

  void _updateRange(Map<String, double> selectedRange) {
  setState(() {
  _currentRange = selectedRange;
  _sliderValue = selectedRange['min']!;
  });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String email = args?['email']! ?? '';
    final String socialId = args?['socialId']! ?? '';
    final String socialType = args?['socialType']! ?? '';

    print('Social Data Create 4 : $email $socialId $socialType');
    return Consumer<CreateProfileProvider>(
      builder: (context, provider, child) {
        return GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: AppFontSize.font12,
                    vertical: AppFontSize.font20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top),

                    Image(
                      image: AssetImage(AppImages.appLogo),
                      height: AppFontSize.font50,
                      width: AppFontSize.font60,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: AppFontSize.font24),
                    Text(AppStrings.strTellAboutGame,
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
                            backgroundColor: AppColors.secondaryColorLightGrey,
                            // borderRadius:
                            // BorderRadius.circular(AppFontSize.font4),
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
                    SizedBox(height: AppFontSize.font10),
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
                            : AppStrings.strNtrpRating
                        ),
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
                                  },
                                );
                              },
                              child: Image(
                                image: AssetImage(AppIconImages.helpIconImg),
                                height: AppFontSize.font20,
                                width: AppFontSize.font20,
                              ),
                            ),
                            SizedBox(width: AppFontSize.font4),
                            Text(
                              AppStrings.strNotSureRatingIs,
                              style: AppFonts.mazzardFont(
                                TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.infoPageCount,
                                  fontSize: AppFontSize.font12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        provider.isUtrRating
                            ? Text(
                          provider.userUtrRating
                              .toString(),
                          style: AppFonts.poppinsFont(
                            TextStyle(
                              fontWeight: FontWeight.w600,
                              color:
                              AppColors.secondaryColorBlack,
                              fontSize: AppFontSize.font14,
                            ),
                          ),
                        )
                            :
                        Text(
                          provider.userNtrpRating
                              .toString(),
                          style: AppFonts.poppinsFont(
                            TextStyle(
                              fontWeight: FontWeight.w600,
                              color:
                              AppColors.secondaryColorBlack,
                              fontSize: AppFontSize.font14,
                            ),
                          ),
                        ),

                      ],
                    ),

                    SizedBox(height: AppFontSize.font12),






                    Column(
                      children: [

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: predefinedRanges.map((range) {
                              bool isSelected = _currentRange == range;

                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: GestureDetector(
                                 onTap: ()=>   _updateRange(range),
                                  child:
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: isSelected ?
                                      AppColors.primaryColorBlue:
                                      AppColors.secondaryColorGrey,
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: Text(
                                      '${range['min']} - ${range['max']}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),

                        SizedBox(height: 20),

                        Text(
                          'Selected Range: ${_currentRange['min']} - ${_currentRange['max']}',
                          style: AppFonts.mazzardFont(TextStyle(
                              fontWeight: FontWeight.w400,
                              color: AppColors.secondaryColorBlack,
                              fontSize: AppFontSize.font14)),
                        ),


                        Container(
                          // width: MediaQuery.of(context).size.width -
                          //     (AppFontSize.font24 + AppFontSize.font24),
                          child: CustomSlider(
                            value: _sliderValue,
                            min: _currentRange['min']!,
                            max: _currentRange['max']!,
                            onChanged: (double value) {
                              setState(() {
                                _sliderValue = value;
                              });
                            },
                            onChangeEnd: (value) {
                              provider.isUtrRating
                                  ? provider.userUtrRating =
                                  double.parse(_sliderValue.toStringAsFixed(1))
                                  : provider.userNtrpRating =
                                  double.parse(_sliderValue.toStringAsFixed(1));
                              provider.isChanged = true;
                              setState(() {});
                            },
                          ),
                        ),



                      ],
                    ),


                    SizedBox(height: AppFontSize.font30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [
                        provider.buildText(AppStrings.strMaxDriveDistance),
                        SizedBox(
                          width: 100,
                          height: 25,
                          child: Text(
                            "${provider.userMaxDrivDis.toStringAsFixed(1)} ${AppStrings.strMiles}",
                            style: AppFonts.poppinsFont(
                              TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryColorBlack,
                                fontSize: AppFontSize.font14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppFontSize.font12),




 CustomSlider(
                        min: 0.0,
                        max: 50.0,
                        value: provider.userMaxDrivDis,
                        onChanged: (value) {
                          provider.userMaxDrivDis = value;
                          provider.isChanged = true;
                          setState(() {});
                        },
                        onChangeEnd: (value) {
                          provider.userMaxDrivDis =
                              double.parse(value.toStringAsFixed(1));
                          provider.isChanged = true;
                          setState(() {});
                        },
                      ),




                    SizedBox(height: AppFontSize.font14),
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
                        child:


                        TextFormField(
                          controller: provider.desiredPartnerController,
                          maxLines: 7,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: AppStrings.strWhatLookingFor,
                            contentPadding: EdgeInsets.fromLTRB(14, 14, 10, 10),
                            hintStyle: TextStyle(
                              fontSize: AppFontSize.font14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.infoPageCount,
                            ),
                          ),
                          inputFormatters: [
                            TextInputFormatter.withFunction(
                                  (oldValue, newValue) {
                                if (newValue.text.isNotEmpty) {
                                  return TextEditingValue(
                                    text: newValue.text.substring(0, 1).toUpperCase() +
                                        newValue.text.substring(1),
                                    selection: newValue.selection,
                                  );
                                }
                                return newValue;
                              },
                            ),
                          ],
                        ),


                      ),
                    ),
                    SizedBox(height: AppFontSize.font50),
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
                                      fontSize: AppFontSize.font14)),
                                  AppColors.primaryColorSkyBlue)),
                        ),
                        InkWell(
                          onTap: () async {
                            if (provider.desiredPartnerController.text
                                .trim()
                                .isEmpty) {
                              AppSnackBarToast.buildShowSnackBar(
                                  context, AppStrings.strEnterDesiredpartner);
                            } else {
                              // LocalDataSaver.saveUserIsUtr(provider.isUtrRating);
                              // LocalDataSaver.saveUserUtr(provider.userUtrRating.toString());
                              // LocalDataSaver.saveUserNtrp(provider.userNtrpRating.toString());
                              // LocalDataSaver.saveUserDriDis(provider.userMaxDrivDis.toString());
                              // LocalDataSaver.saveUserDesPart(provider.desiredPartnerController.text);
                              // await fetchDataSPreferences();

                              provider.setProgressTask(4);
                              provider.setProgressBar(0.8);

                              progressTaskValue > 1.0
                                  ? null
                                  : progressTaskValue = 1.0;
                              progressTaskDone > 5
                                  ? null
                                  : progressTaskDone = 5;
                              Navigator.pushNamed(
                                  context, AppRoutes.createProfilePage5,
                                arguments: {
                                  'provider': provider,
                                  'email': email,
                                  'socialId': socialId,
                                  'socialType': socialType,
                                },
                              );
                            }
                          },
                          child: Container(
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
          ),
        );
      },
    );
  }
}





