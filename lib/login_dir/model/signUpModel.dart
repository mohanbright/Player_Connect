class SignUpData {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String dob;
  final String height;
  final String country;
  final String countryCode;
  final String countryFlag;
  final String password;
  final String role;
  final String gender;
  final String rating;
  final String city;
  final String about;
  final String desiredPartner;
  final String playingStyle;
  final String dominantHand;
  final String locationRange;
  final String ratingType;
  final String totalExperience;

  SignUpData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.dob,
    required this.height,
    required this.country,
    required this.countryCode,
    required this.countryFlag,
    required this.password,
    required this.role,
    required this.gender,
    required this.rating,
    required this.city,
    required this.about,
    required this.desiredPartner,
    required this.playingStyle,
    required this.dominantHand,
    required this.locationRange,
    required this.ratingType,
    required this.totalExperience,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'dob': dob,
      'height': height,
      'country': country,
      'country_code': countryCode,
      'country_flag': countryFlag,
      'password': password,
      'role': role,
      'gender': gender,
      'rating': rating,
      'city': city,
      'about': about,
      'desired_partner': desiredPartner,
      'playingstyle': playingStyle,
      'dominnant_hand': dominantHand,
      'location_range': locationRange,
      'ratingtype': ratingType,
      'total_experience': totalExperience,
    };
  }
}
