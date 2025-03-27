class MealModel {
  final String date;
  final String day;
  final Meals meals;

  MealModel({
    required this.date,
    required this.day,
    required this.meals,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      date: json['date'],
      day: json['day'],
      meals: Meals.fromJson(json['meals']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'day': day,
      'meals': meals.toJson(),
    };
  }
}

class Meals {
  final String breakfast;
  final String lunch;
  final String dinner;

  Meals({
    required this.breakfast,
    required this.lunch,
    required this.dinner,
  });

  factory Meals.fromJson(Map<String, dynamic> json) {
    return Meals(
      breakfast: json['breakfast'],
      lunch: json['lunch'],
      dinner: json['dinner'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'breakfast': breakfast,
      'lunch': lunch,
      'dinner': dinner,
    };
  }
}
