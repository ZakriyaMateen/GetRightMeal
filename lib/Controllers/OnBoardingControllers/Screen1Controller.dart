import 'package:get/get.dart';

class Screen1controller extends GetxController {
  final List<Map<String, dynamic>> carouselItems = [

    {
      'path': 'https://images.pexels.com/photos/6740520/pexels-photo-6740520.jpeg?auto=compress&cs=tinysrgb&w=1200',
      // 'path': 'https://s3.gifyu.com/images/bSarv.jpg',
      'heading': 'Your Path to Healthier Eating',
      'description': 'Enjoy nutritious meals crafted for your lifestyle',
      'isVideo': false,
    },
    {
      'path': 'https://images.pexels.com/photos/6740528/pexels-photo-6740528.jpeg?auto=compress&cs=tinysrgb&w=1200',
      'heading': 'Personalized Meal Plans',
      'description': 'AI-crafted weekly meal plans tailored to your health goals',
      'isVideo': false,
    },
    {
      'path': 'https://images.pexels.com/photos/6740513/pexels-photo-6740513.jpeg?auto=compress&cs=tinysrgb&w=1200',

      'heading': 'Smart Nutrition Guidance',
      'description': 'AI-powered insights to keep you on track with your goals',
      'isVideo': false,
    },
    {
      'path': 'https://images.pexels.com/photos/4099237/pexels-photo-4099237.jpeg?auto=compress&cs=tinysrgb&w=1200',
      'heading': 'Flexibility at your fingertips',
      'description': 'Unexpected plans? No worries, we got you covered',
      'isVideo': false,
    },
    // {
    //   'path': 'assets/onboarding2.jpg',
    //   'heading': 'Meals That Fit Your Lifestyle',
    //   'description': 'Customized for your dietary preferences and activity level',
    //   'isVideo': false,
    // },
  ];

  final currentIndex = 0.obs;
}
