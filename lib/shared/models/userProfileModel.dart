import 'package:flutter/foundation.dart';

class UserProfileModel {
   int? id;
   String? firstName;
   String? lastName;
   String? email;
   String? phone;
   String? country;
   String? countryCode;
   String? loginTime;
   String? latitude;
   String? longitude;
   int? locationRange;
   String? otp;
   String? images;
   int? gender;
   String? dob;
   String? password;
   String? deviceToken;
   String? deviceType;
   int? role;
   String? totalExperience;
   String? height;
   String? about;
   String? city;
   String? desiredPartner;
   int? ratingtype;
   String? rating;
   String? playingStyle;
   String? dominantHand;
   String? countryFlag;
   String? createdAt;
   String? updatedAt;

  UserProfileModel({
     this.id,
     this.firstName,
     this.lastName,
     this.email,
     this.phone,
     this.country,
     this.countryCode,
     this.loginTime,
       this.latitude,
       this.longitude,
       this.locationRange,
       this.otp,
       this.images,
       this.gender,
       this.dob,
       this.password,
       this.deviceToken,
       this.deviceType,
       this.role,
       this.totalExperience,
       this.height,
       this.about,
       this.city,
       this.desiredPartner,
       this.ratingtype,
       this.rating,
       this.playingStyle,
       this.dominantHand,
       this.countryFlag,
       this.createdAt,
       this.updatedAt,
  });
}


class UserDataProvidr extends ChangeNotifier{
  UserProfileModel _dataModel = UserProfileModel();

  UserProfileModel get dataModel => _dataModel;

  void updateDataModel(UserProfileModel newDataModel) {
    _dataModel = newDataModel;
    notifyListeners();
  }
}