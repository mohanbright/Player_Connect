import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:player_connect/shared/constant/app_strings.dart';
import 'package:player_connect/shared/constant/colors.dart';
import 'package:player_connect/shared/constant/font_size.dart';
import 'package:player_connect/shared/constant/fonts.dart';
import 'package:player_connect/shared/constant/snack_bar_toast.dart';

class EditProfileProvider extends ChangeNotifier {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumController = TextEditingController();
  TextEditingController textAreaController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController feetHeightController = TextEditingController();
  TextEditingController inchFeetController = TextEditingController();
  TextEditingController desiredPartnerController = TextEditingController();
  TextEditingController playingStyleController = TextEditingController();

  String? selectedGender;

  bool isUtrRating = true;
  bool isDiamondHand = true;
  DateTime selectedDate = DateTime.now();
  String? userDob;
  double userUtrRating = 5;
  double userNtrpRating = 3;
  double userMaxDrivDis = 10;
  bool expanded = false;
  int ratingListIndex = -1;
  bool isLocationLoading = false;
  String? _currentAddress;
  Position? _currentPosition;
  File? image;

  getRatingIndex(int index) {
    if (ratingListIndex == index) {
      ratingListIndex = -1;
      notifyListeners();
    } else {
      ratingListIndex = index;
      notifyListeners();
    }
    notifyListeners();
  }

  getBoolUtrRating(value) {
    isUtrRating = value;
    notifyListeners();
  }

  getBoolDiamondHand(value) {
    isDiamondHand = value;
    notifyListeners();
  }

  setUserUtrRating(double value) {
    userUtrRating = value;
    notifyListeners();
  }

  List ntrpList = [
    0.5,
    1.0,
    1.5,
    2.0,
    2.5,
    3.0,
    3.5,
    4.0,
    4.5,
    5.0,
    5.5,
    6.0,
    6.5,
    7.0,
    7.5,
    8.0,
    8.5,
    9.0,
    9.5,
    10.0,
  ];

  List descriptionList = [
    "This player is learning to judge where the oncoming ball is going and how much swing is needed to return it consistently. Movement to the ball and recovery are ofter not efficient. Can sustain a backcourt rally of slow pace with other players of similar ability and is beginning to develop stokes. This play is becoming more familiar with the basic positions for singles and doubles, and is ready to play social matches, leagues and low-level touraments.\n\n Potential limitations: grip weaknesses; limited swing and inconsistent toss on serve; limited transitions to the net."
  ];

  Widget buildText(title) {
    return Text(title,
        style: AppFonts.mazzardFont(TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryColorBlack,
            fontSize: AppFontSize.font14)));
  }

  Widget textFieldContainer(
      EditProfileProvider provider, hintText, controller, maxLines,
      {prefix}) {
    return Container(
      // height: AppFontSize.font45,
      decoration: BoxDecoration(
          color: AppColors.secondaryColorWhite,
          border: Border.all(color: AppColors.secondaryColorBlack, width: 1),
          borderRadius: BorderRadius.circular(AppFontSize.font12)),
      child: Center(
        child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              contentPadding: const EdgeInsets.fromLTRB(14, 10, 10, 11),
              hintStyle: AppFonts.poppinsFont(TextStyle(
                  fontSize: AppFontSize.font14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.infoPageCount)),
            )),
      ),
    );
  }

  Widget genderContainer(img, text) {
    return InkWell(
      onTap: () {
        selectedGender = text;
        notifyListeners();
      },
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        height: AppFontSize.font100,
        width: AppFontSize.font100,
        decoration: BoxDecoration(
            color: selectedGender == text
                ? AppColors.primaryColorSkyBlue
                : AppColors.secondaryColorLightGrey,
            borderRadius: BorderRadius.circular(AppFontSize.font32)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image(
                image: AssetImage(img),
                height: AppFontSize.font45,
                width: AppFontSize.font45,
              ),
            ),
            SizedBox(height: AppFontSize.font8),
            Text(text,
                style: AppFonts.poppinsFont(TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondaryColorBlack,
                    fontSize: AppFontSize.font14)))
          ],
        ),
      ),
    );
  }

  Future selectDobDate(context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: AppStrings.strSelectDob,
    );
    if (selected != null && selected != selectedDate) {
      selectedDate = selected;
      var dateTime = DateTime.parse(selectedDate.toString());
      var formatDate = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
      dobController = TextEditingController(text: formatDate);
      notifyListeners();
    }
  }

  Future<bool> handleLocationPermission(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      AppSnackBarToast.buildShowSnackBar(
          context, AppStrings.strLocationDisabled);
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        AppSnackBarToast.buildShowSnackBar(
            context, AppStrings.strLocationDenied);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      AppSnackBarToast.buildShowSnackBar(
          context, AppStrings.strLocationPermanentDenied);

      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition(context) async {
    final hasPermission = await handleLocationPermission(context);

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      notifyListeners();
      getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      _currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      locationController.text = _currentAddress!;
      notifyListeners();
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> cameraImage(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 100,
            child: Center(
              child: Row(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () async {
                            getImageFile(ImageSource.camera, context);
                          },
                          child: const Icon(Icons.photo_camera))),
                  Expanded(
                      child: InkWell(
                          onTap: () async {
                            getImageFile(ImageSource.gallery, context);
                          },
                          child: const Icon(Icons.photo_library_outlined))),
                ],
              ),
            ),
          );
        });
  }

  getImageFile(source, context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final file = await picker.pickImage(source: source);
      if (file == null) return;

      image = File(file.path);
      Navigator.pop(context);

      notifyListeners();
    } catch (e) {
      Navigator.pop(context);
      AppSnackBarToast.buildShowSnackBar(context, AppStrings.strSomethingWrong);
      debugPrint("'${AppStrings.strImgPickFailed}' $e");
    }
  }
}
