class UserProfileModel {
  final int? id;
  final String? email;
  final String? name;
  final String? otp;
  final DateTime? otpExpiry;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? roleId;
  final bool? isEnabled;
  final Profile? profile;

  UserProfileModel({
    this.id,
    this.email,
    this.name,
    this.otp,
    this.otpExpiry,
    this.createdAt,
    this.updatedAt,
    this.roleId,
    this.isEnabled,
    this.profile,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    try {
      return UserProfileModel(
        id: json['id'] ?? 0,
        email: json['email'] ?? '',
        name: json['name'] ?? '',
        otp: json['otp'] ?? '',
        otpExpiry: json['otpExpiry'] != null
            ? DateTime.tryParse(json['otpExpiry']) ?? DateTime(2002, 2, 26)
            : DateTime(2002, 2, 26),
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
            : DateTime.now(),
        updatedAt: json['updatedAt'] != null
            ? DateTime.tryParse(json['updatedAt']) ?? DateTime.now()
            : DateTime.now(),
        roleId: json['roleId'] ?? 0,
        isEnabled: json['isEnabled'] ?? false,
        profile: json['profile'] != null
            ? Profile.fromJson(json['profile'])
            : Profile.defaultProfile(),
      );
    } catch (e) {
      print("Error in UserProfileModel.fromJson: " + e.toString());
      return UserProfileModel(
        id: 0,
        email: '',
        name: '',
        otp: '',
        otpExpiry: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        roleId: 0,
        isEnabled: false,
        profile: Profile.defaultProfile(),
      );
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'otp': otp,
      'otpExpiry': otpExpiry?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'roleId': roleId,
      'isEnabled': isEnabled,
      'profile': profile?.toJson(),
    };
  }
}

class Profile {
  final int? id;
  final int? country;
  final String? city;
  final String? phone;
  final DateTime? dateOfBirth;
  final String? gender;
  final int? height;
  final String? heightUnit;
  final String? weightUnit;
  final double? weight;
  final int? goal;
  final int? activityLevel;
  final List<String>? dairyPreferences;
  final List<String>? cuisinePreferences;
  final int? age;

  Profile({
    this.id,
    this.country,
    this.city,
    this.phone,
    this.dateOfBirth,
    this.gender,
    this.height,
    this.weight,
    this.goal,
    this.activityLevel,
    this.dairyPreferences,
    this.cuisinePreferences,
    this.heightUnit,
    this.weightUnit,
    this.age,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    DateTime parsedDOB;
    try {
      parsedDOB = json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : DateTime.now();
    } catch (e) {
      parsedDOB = DateTime.now();
    }

    DateTime currentDate = DateTime.now();
    int computedAge = currentDate.year - parsedDOB.year;
    if (currentDate.month < parsedDOB.month ||
        (currentDate.month == parsedDOB.month &&
            currentDate.day < parsedDOB.day)) {
      computedAge--;
    }

    return Profile(
      id: json['id'] ?? 0,
      country: json['country'] ?? 0,
      city: json['city'] ?? '',
      phone: json['phone'] ?? 'XXXX XXX XXXX',
      dateOfBirth: parsedDOB,
      gender: json['gender'] ?? 'male',
      height: json['height'] != null
          ? double.tryParse(json['height'].toString())?.ceil()
          : 0,
      weight: json['weight'] != null
          ? double.tryParse(json['weight'].toString())?.ceil().toDouble()
          : 0.0,
      goal: json['goal'] ?? 0,
      activityLevel: json['activityLevel'] ?? 0,
      dairyPreferences: json['dairyPreferences'] != null
          ? List<String>.from(json['dairyPreferences'])
          : [],
      cuisinePreferences: json['cuisinePreferences'] != null
          ? List<String>.from(json['cuisinePreferences'])
          : [],
      heightUnit: json['heightUnit'] ?? 'cm',
      weightUnit: json['weightUnit'] ?? 'kg',
      age: computedAge,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'country': country,
      'city': city,
      'phone': phone,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'gender': gender,
      'height': height,
      'weight': weight,
      'goal': goal,
      'activityLevel': activityLevel,
      'dairyPreferences': dairyPreferences,
      'cuisinePreferences': cuisinePreferences,
      'heightUnit': heightUnit,
      'weightUnit': weightUnit,
      'age': age,
    };
  }

  static Profile defaultProfile() {
    return Profile(
      id: 0,
      country: 0,
      city: '',
      phone: 'XXXX XXX XXXX',
      dateOfBirth: DateTime.now(),
      gender: 'male',
      height: 0,
      weight: 0.0,
      goal: 0,
      activityLevel: 0,
      dairyPreferences: [],
      cuisinePreferences: [],
      heightUnit: 'cm',
      weightUnit: 'kg',
      age: 0,
    );
  }
}
