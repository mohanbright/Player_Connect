class EditProfileModel {
  int? success;
  int? code;
  String? message;
  EditProfileModelBody? body;

  EditProfileModel({this.success, this.code, this.message, this.body});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    body = json['body'] != null
        ? EditProfileModelBody.fromJson(json['body'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    if (body != null) {
      data['body'] = body!.toJson();
    }
    return data;
  }
}

class EditProfileModelBody {
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
  var otp;
  String? images;
  int? gender;
  String? dob;
  String? password;
  var deviceToken;
  var deviceType;
  int? role;
  var totalexperience;
  String? height;
  String? about;
  String? city;
  String? desiredPartner;
  int? ratingtype;
  String? rating;
  String? playingstyle;
  String? dominnantHand;
  String? countryFlag;
  var socialType;
  var socialId;
  int? isNotification;
  String? createdAt;
  String? updatedAt;

  EditProfileModelBody(
      {this.id,
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
      this.totalexperience,
      this.height,
      this.about,
      this.city,
      this.desiredPartner,
      this.ratingtype,
      this.rating,
      this.playingstyle,
      this.dominnantHand,
      this.countryFlag,
      this.socialType,
      this.socialId,
      this.isNotification,
      this.createdAt,
      this.updatedAt});

  EditProfileModelBody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    country = json['country'];
    countryCode = json['country_code'];
    loginTime = json['loginTime'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    locationRange = json['location_range'];
    otp = json['otp'];
    images = json['images'];
    gender = json['gender'];
    dob = json['dob'];
    password = json['password'];
    deviceToken = json['deviceToken'];
    deviceType = json['deviceType'];
    role = json['role'];
    totalexperience = json['totalexperience'];
    height = json['height'];
    about = json['about'];
    city = json['city'];
    desiredPartner = json['desired_partner'];
    ratingtype = json['ratingtype'];
    rating = json['rating'];
    playingstyle = json['playingstyle'];
    dominnantHand = json['dominnant_hand'];
    countryFlag = json['country_flag'];
    socialType = json['social_type'];
    socialId = json['social_id'];
    isNotification = json['isNotification'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['phone'] = phone;
    data['country'] = country;
    data['country_code'] = countryCode;
    data['loginTime'] = loginTime;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['location_range'] = locationRange;
    data['otp'] = otp;
    data['images'] = images;
    data['gender'] = gender;
    data['dob'] = dob;
    data['password'] = password;
    data['deviceToken'] = deviceToken;
    data['deviceType'] = deviceType;
    data['role'] = role;
    data['totalexperience'] = totalexperience;
    data['height'] = height;
    data['about'] = about;
    data['city'] = city;
    data['desired_partner'] = desiredPartner;
    data['ratingtype'] = ratingtype;
    data['rating'] = rating;
    data['playingstyle'] = playingstyle;
    data['dominnant_hand'] = dominnantHand;
    data['country_flag'] = countryFlag;
    data['social_type'] = socialType;
    data['social_id'] = socialId;
    data['isNotification'] = isNotification;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
