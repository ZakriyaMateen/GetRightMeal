import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Constants/AppKeys.dart';
import 'package:getrightmealnew/Views/OnBoardingViews/Screen1.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/AppUrls.dart';
import '../../constants/Colors.dart';
import '../Models/UserProfileModel.dart';
import '../Widgets/MySnackbar.dart';
import 'AuthControllers/AccessTokenController.dart';


class ProfileScreenController extends GetxController{
  Rx<UserProfileModel?> userProfileModel = Rx<UserProfileModel?>(null);
  var isLoading = false.obs;
  RxBool isNullValue = false.obs;
  Future<void> logout()async{
    try{
      isLoading.value = true;

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppKeys.emailFromForm, '');
      await prefs.setString(AppKeys.passwordFromForm, '');
      await prefs.setInt(AppKeys.userId, -1);
      await prefs.setString(AppKeys.access_token, '');
      isLoading.value = false;
      Get.offAll(()=>Screen1());

    }catch(e){
      isLoading.value = false;

      print('Logout error occurred :  '+e.toString());
      Get.offAll(()=>Screen1());

    }
  }

  Future fetchProfile()async{
    isLoading.value = true;

    AccessTokenController accessTokenController = Get.find();

    try{
      isNullValue.value = false;


      // {id: 85, email: zakriyamateen3@gmail.com, name: Zakriya Mateen, otp: null, otpExpiry: null, isGoogleUser: true, googleId: 101477600040547051555, createdAt: 2025-02-21T10:40:47.101Z, updatedAt: 2025-02-21T10:40:47.101Z, roleId: 1, isEnabled: true, profile: {id: 67, country: 1, city: dubai, phone: 3331114444, dateOfBirth: 2002-02-26, gender: male, height: 84, weight: 136, goal: 2, activityLevel: 3, dairyPreferences: [2], cuisinePreferences: [1], notificationToken: null}}
      await accessTokenController.initializeAutomatically();

        if(accessTokenController.accessToken.value!=''){

          final uri = Uri.parse(AppUrls.baseUrl+AppUrls.getUserProfile);

          final response = await http.get(
              uri,
              headers: {
                'Authorization': "Bearer ${accessTokenController.accessToken}"
              }
          );
          if(response.statusCode == 200){
            var data =  jsonDecode(response.body);
            print("data at profilescreen controller: "+data.toString());
            try{
              userProfileModel.value = UserProfileModel.fromJson(data);
              userProfileModel.refresh();

            }
            catch(e,s){
              await FirebaseCrashlytics.instance.recordError(e, s,
                  reason: e.toString(),
                  fatal: false);
              isNullValue.value = true;
              print("Error at profile screen controller first: "+e.toString());
            }
          }
          isLoading.value = false;
        }
        else{
          isLoading.value = false;
          Get.snackbar(
            'Error Loading Profile!',
            'Please try again!',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: black,
            colorText:plumGrey,
            duration: Duration(seconds: 5),
          );

        }
    }
    catch(e,s){
      await FirebaseCrashlytics.instance.recordError(e, s,
          reason: e.toString(),
          fatal: false);
      Get.offAll(()=>Screen1());
      myErrorSnackbar('Please create an account first!');

      isLoading.value = false;

      print("Error at profilescreenController : "+e.toString());
    }
    finally{
      isLoading.value = false;
    }




  }

  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
  // await fetchProfile();
  }

}