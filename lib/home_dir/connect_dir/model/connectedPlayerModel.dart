// ignore_for_file: unnecessary_this

class ConnectedPlayerModel {
  int? success;
  int? code;
  String? message;
  List<ConnectedPlayerModelBody>? body;

  ConnectedPlayerModel({this.success, this.code, this.message, this.body});

  ConnectedPlayerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    if (json['body'] != null) {
      body = <ConnectedPlayerModelBody>[];
      json['body'].forEach((v) {
        body!.add(ConnectedPlayerModelBody.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.body != null) {
      data['body'] = this.body!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConnectedPlayerModelBody {
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
  String? deviceToken;
  var deviceType;
  String? height;
  String? about;
  String? city;
  String? desiredPartner;
  int? ratingtype;
  int? is_online;
  String? rating;
  String? playingstyle;
  String? dominnantHand;
  String? countryFlag;
  var socialType;
  var socialId;

  ConnectedPlayerModelBody(
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
      this.deviceToken,
      this.deviceType,
      this.height,
      this.about,
      this.city,
      this.desiredPartner,
      this.ratingtype,
      this.is_online,
      this.rating,
      this.playingstyle,
      this.dominnantHand,
      this.countryFlag,
      this.socialType,
      this.socialId});

  ConnectedPlayerModelBody.fromJson(Map<String, dynamic> json) {
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
    deviceToken = json['deviceToken'];
    deviceType = json['deviceType'];
    height = json['height'];
    about = json['about'];
    city = json['city'];
    desiredPartner = json['desired_partner'];
    ratingtype = json['ratingtype'];
    is_online = json['is_online'];
    rating = json['rating'];
    playingstyle = json['playingstyle'];
    dominnantHand = json['dominnant_hand'];
    countryFlag = json['country_flag'];
    socialType = json['social_type'];
    socialId = json['social_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    data['loginTime'] = this.loginTime;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['location_range'] = this.locationRange;
    data['otp'] = this.otp;
    data['images'] = this.images;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['deviceToken'] = this.deviceToken;
    data['deviceType'] = this.deviceType;
    data['height'] = this.height;
    data['about'] = this.about;
    data['city'] = this.city;
    data['desired_partner'] = this.desiredPartner;
    data['ratingtype'] = this.ratingtype;
    data['is_online'] = this.is_online;
    data['rating'] = this.rating;
    data['playingstyle'] = this.playingstyle;
    data['dominnant_hand'] = this.dominnantHand;
    data['country_flag'] = this.countryFlag;
    data['social_type'] = this.socialType;
    data['social_id'] = this.socialId;
    return data;
  }
}
