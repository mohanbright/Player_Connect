// ignore_for_file: non_constant_identifier_names

class PlayersListModel {
  final String name;
  final String locality;
  final int age;
  final String position;
  final double utr;
  final bool onlineStatus;

  PlayersListModel({
    required this.name,
    required this.locality,
    required this.age,
    required this.position,
    required this.utr,
    required this.onlineStatus,
  });

  factory PlayersListModel.fromJson(Map<String, dynamic> json) {
    return PlayersListModel(
      name: json['name'],
      locality: json['locality'],
      age: json['age'],
      position: json['position'],
      utr: json['utr'].toDouble(),
      onlineStatus: json['online_status'],
    );
  }
}

class PlayersListModelList {
  int? success;
  int? status;
  String? message;
  List<PlayersListModelListBody>? body;

  PlayersListModelList({this.success, this.status, this.message, this.body});

  PlayersListModelList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['body'] != null) {
      body = <PlayersListModelListBody>[];
      json['body'].forEach((v) {
        body!.add(PlayersListModelListBody.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['status'] = status;
    data['message'] = message;
    if (body != null) {
      data['body'] = body!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PlayersListModelListBody {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? phone;
  String? country;
  String? countryCode;
  String? loginTime;
  String? latitude;
  int? locationRange;
  String? longitude;
  var otp;
  String? images;
  int? gender;
  String? dob;
  String? password;
  String? deviceToken;
  var deviceType;
  int? role;
  int? totalexperience;
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
  int? is_online;
  String? createdAt;
  String? updatedAt;
  var senderStatus1;
  var receiverStatus1;
  var senderStatus2;
  var receiverStatus2;

  PlayersListModelListBody({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.country,
    this.countryCode,
    this.loginTime,
    this.latitude,
    this.locationRange,
    this.longitude,
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
    this.is_online,
    this.createdAt,
    this.updatedAt,
    this.senderStatus1,
    this.receiverStatus1,
    this.senderStatus2,
    this.receiverStatus2,
  });

  PlayersListModelListBody.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    phone = json['phone'];
    country = json['country'];
    countryCode = json['country_code'];
    loginTime = json['loginTime'];
    latitude = json['latitude'];
    locationRange = json['location_range'];
    longitude = json['longitude'];
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
    is_online = json['is_online'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
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
    data['location_range'] = locationRange;
    data['longitude'] = longitude;
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
    data['is_online'] = is_online;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['sender_status_1'] = senderStatus1;
    data['receiver_status_1'] = receiverStatus1;
    data['sender_status_2'] = senderStatus2;
    data['receiver_status_2'] = receiverStatus2;
    return data;
  }
}
