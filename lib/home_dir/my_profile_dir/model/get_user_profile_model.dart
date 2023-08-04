class ProfileModel {
  String? image;
  String? firstName;
  String? lastName;
  String? mobileNumber;
  String? about;
  String? gender;
  String? dateOfBirth;
  int? age;
  int? height;
  int? cmHeight;
  String? city;
  String? country;
  String? countryFlag;
  bool? haveUtrRating;
  double? utrRating;
  double? ntrpRating;
  int? maxDrivingDistance;
  String? desiredPartner;
  String? playingStyle;
  String? dominantHand;
  String? authToken;

  ProfileModel({
    this.image,
    this.firstName,
    this.lastName,
    this.mobileNumber,
    this.about,
    this.gender,
    this.dateOfBirth,
    this.age,
    this.height,
    this.cmHeight,
    this.city,
    this.country,
    this.countryFlag,
    this.haveUtrRating,
    this.utrRating,
    this.ntrpRating,
    this.maxDrivingDistance,
    this.desiredPartner,
    this.playingStyle,
    this.dominantHand,
    this.authToken,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      image: json['image'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      mobileNumber: json['mobile_number'],
      about: json['about'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      age: json['age'],
      height: json['height'],
      cmHeight: json['cmHeight'],
      city: json['city'],
      country: json['country'],
      countryFlag: json['country_flag'],
      haveUtrRating: json['have_utr_rating'],
      utrRating: json['have_utr_rating'] ? json['utr_rating'] : null,
      ntrpRating: json['have_utr_rating'] ? null : json['utr_rating'],
      maxDrivingDistance: json['max_driving_distance'],
      desiredPartner: json['desired_partner'],
      playingStyle: json['playing_style'],
      dominantHand: json['dominant_hand'],
      authToken: json['auth_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'first_name': firstName,
      'last_name': lastName,
      'mobile_number': mobileNumber,
      'about': about,
      'gender': gender,
      'date_of_birth': dateOfBirth.toString(),
      'age': age,
      'height': height,
      'cmHeight': cmHeight,
      'city': city,
      'country': country,
      'country_flag': countryFlag,
      'have_utr_rating': haveUtrRating,
      'utr_rating': haveUtrRating == true ? utrRating : null,
      'ntrp_rating': haveUtrRating == true ? null : ntrpRating,
      'max_driving_distance': maxDrivingDistance,
      'desired_partner': desiredPartner,
      'playing_style': playingStyle,
      'dominant_hand': dominantHand,
      'auth_token': authToken,
    };
  }
}
