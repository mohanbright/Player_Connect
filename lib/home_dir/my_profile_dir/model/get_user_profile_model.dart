class UserProfile {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String country;
  final String countryCode;
  final String loginTime;
  final String? latitude;
  final String? longitude;
  final int locationRange;
  final String? otp;
  final String images;
  final int gender;
  final String dob;
  final String password;
  final String? deviceToken;
  final String? deviceType;
  final int role;
  final String? totalExperience;
  final String height;
  final String about;
  final String city;
  final String desiredPartner;
  final int ratingtype;
  final String rating;
  final String playingStyle;
  final String dominantHand;
  final String countryFlag;
  final String createdAt;
  final String updatedAt;

  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.country,
    required this.countryCode,
    required this.loginTime,
    this.latitude,
    this.longitude,
    required this.locationRange,
    this.otp,
    required this.images,
    required this.gender,
    required this.dob,
    required this.password,
    this.deviceToken,
    this.deviceType,
    required this.role,
    this.totalExperience,
    required this.height,
    required this.about,
    required this.city,
    required this.desiredPartner,
    required this.ratingtype,
    required this.rating,
    required this.playingStyle,
    required this.dominantHand,
    required this.countryFlag,
    required this.createdAt,
    required this.updatedAt,
  });
}