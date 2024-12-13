class IndividualPlayersModelList {
  int? success;
  int? code;
  String? message;
  IndividualPlayersBodyData? body;

  IndividualPlayersModelList(
      {this.success, this.code, this.message, this.body});

  IndividualPlayersModelList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
    body = json['body'] != null
        ? IndividualPlayersBodyData.fromJson(json['body'])
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

class IndividualPlayersBodyData {
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
  String? rating;
  String? playingstyle;
  String? dominnantHand;
  String? countryFlag;
  var socialType;
  var socialId;
  var senderStatus1;
  var receiverStatus1;
  var senderStatus2;
  var receiverStatus2;

  IndividualPlayersBodyData(
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
      this.rating,
      this.playingstyle,
      this.dominnantHand,
      this.countryFlag,
      this.socialType,
      this.socialId,
      this.senderStatus1,
      this.receiverStatus1,
      this.senderStatus2,
      this.receiverStatus2});

  IndividualPlayersBodyData.fromJson(Map<String, dynamic> json) {
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
    rating = json['rating'];
    playingstyle = json['playingstyle'];
    dominnantHand = json['dominnant_hand'];
    countryFlag = json['country_flag'];
    socialType = json['social_type'];
    socialId = json['social_id'];
    senderStatus1 = json['sender_status_1'];
    receiverStatus1 = json['receiver_status_1'];
    senderStatus2 = json['sender_status_2'];
    receiverStatus2 = json['receiver_status_2'];
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
    data['deviceToken'] = deviceToken;
    data['deviceType'] = deviceType;
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
    data['sender_status_1'] = senderStatus1;
    data['receiver_status_1'] = receiverStatus1;
    data['sender_status_2'] = senderStatus2;
    data['receiver_status_2'] = receiverStatus2;
    return data;
  }
}
