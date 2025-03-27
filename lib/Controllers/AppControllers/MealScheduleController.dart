import 'dart:convert';

import 'package:get/get.dart';
import 'package:getrightmealnew/Views/OnBoardingViews/Screen1.dart';
import 'package:http/http.dart' as http;

import '../../Constants/AppUrls.dart';
import '../../Models/MealModel.dart';
import '../../constants/Colors.dart';
import '../AuthControllers/AccessTokenController.dart';

class   MealScheduleController extends GetxController{
  RxInt selectedIndex = 0.obs; // Track the selected index
  RxBool isLoading = false.obs;
  AccessTokenController accessTokenController = Get.find();
  RxList<MealModel> meals = <MealModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    accessTokenController.initializeAutomatically();
    fetch();
  }
  void selectDate(int index) {
    selectedIndex.value = index; // Update the selected index
  }
  Future fetch() async {
    try {
      print('helloooó');
      isLoading.value = true;
      DateTime now = DateTime.now();
      int year = now.year;
      DateTime firstDayOfYear = DateTime(year);
      int weekNumber = ((now.difference(firstDayOfYear).inDays + firstDayOfYear.weekday - 1) / 7).ceil();
      final uri = Uri.parse('${AppUrls.baseUrl}${AppUrls.getMealPlan}/$weekNumber/$year');

      await accessTokenController.initializeAutomatically();


      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer ${accessTokenController.accessToken}'
        },
      );
      isLoading.value = false;

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        meals.value = (data['meals'] as List).map((e) {
          return MealModel.fromJson(e);
        }).toList();
      } else {
        isLoading.value = false;
        Get.snackbar(
          'No Meal Found!',
          'Please refresh or try again later',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: black,
          colorText: plumGrey,
          duration: Duration(seconds: 5),
        );
      }
    } catch (e) {
      isLoading.value = false;
      print(e.toString());
    }
  }
}
