import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Controllers/AuthControllers/LoginPageController.dart';
import 'package:getrightmealnew/Views/AppViews/CustomNavBar.dart';
import 'package:getrightmealnew/Views/AuthViews/VerifyOtpScreenFromRegister.dart';
import 'package:getrightmealnew/Widgets/MySnackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/AppUrls.dart';
import '../../Models/UserProfileModel.dart';
import '../../constants/AppKeys.dart';
import '../../constants/Colors.dart';
import '../OnBoardingControllers/Screen2Controller.dart';
import '../ProfileScreenController.dart';
import 'AccessTokenController.dart';

class VerifyOtpScreenController extends GetxController{
  AccessTokenController accessTokenController = Get.put(AccessTokenController());
  Screen2Controller screen2controller = Get.put(Screen2Controller());
  LoginPageController loginPageController = Get.put(LoginPageController());
  Future<void> patchUserProfile() async {

    await accessTokenController.initializeAutomatically();
    isLoading.value = true;
    String? fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('FcmToken : '+fcmToken!);
    if(screen2controller.cmInchFeet.value == 'ft'){
      screen2controller.cmInchFeet.value = 'in';
    }
    final Map<String, dynamic> payload = {
      'cuisinePreferences':screen2controller.selectedCuisinePreferences.value,
      'country': screen2controller.country.value == "Select Country"? 1: screen2controller.country.value, // Assuming you need to add this field
      'dateOfBirth': screen2controller.selectedDateOfBirth.value.toString(), // Ensure valid date format
      'gender': screen2controller.selectedGender.value.toLowerCase(), // Send gender as string
      'height': screen2controller.selectedHeight.value, // Send as int
      "heightUnit": screen2controller.cmInchFeet.value,
      "weightUnit": screen2controller.kgLbs.value,
      'weight': screen2controller.selectedWeight.value, // Send as double
      'goal': screen2controller.selectedGoal.value, // Use the validated goal value
      'activityLevel': (screen2controller.selectedActivityLevel.value) ?? 1, // Keep as int
      'dairyPreferences': screen2controller.selectedDietaryPreferences.value, // Send List as-is
      'name': screen2controller.name.value,
      'city': screen2controller.city.value,
      'phone':screen2controller.phone.value,
      'notificationToken':fcmToken??''
    };


      print("PAYLOAD AT VERIFY OTP CONTROLLER : ");
      print(payload);

    try {

      final response = await http.patch(
        Uri.parse('${AppUrls.baseUrl}${AppUrls.patchUserProfile}'),
        headers: {
          'Authorization': "Bearer ${accessTokenController.accessToken.value}",
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode(payload), // Encode the payload to JSON
      );
      print("Response body at patch user profile");
      print(response.body);
      print("status code : ");
      print(response .statusCode);
      if(response.statusCode == 200){
        ProfileScreenController controller = Get.put(ProfileScreenController());
        await controller.fetchProfile();
      }
      screen2controller.resetAll();
      Get.offAll(()=>CustomNavBar(),transition: Transition.fadeIn);

      isLoading.value = false;
    } catch (e,s) {
      await FirebaseCrashlytics.instance.recordError(e, s,
          reason: e.toString(),
          fatal: false);
      print('Error occurred: ${e.toString()}');
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }
  var otp = ''.obs;
  var email = ''.obs;
  RxBool isLoading = false.obs;
  Rx<UserProfileModel?> userProfileModel = Rx<UserProfileModel?>(null);

  Future postData({bool isLogin = true})async{
    try{
      isLoading.value = true;
      var uri = Uri.parse(AppUrls.baseUrl+AppUrls.login);

      final response = await http.post(
          uri,
          body:  _buildBody()
      );
      if(response.statusCode == 201){
        print(" response Body : " +response.body);
        AccessTokenController controller = Get.find();
        await fetchUserWithEmail();
        var data = await jsonDecode(response.body);

        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString(AppKeys.access_token, data[AppKeys.access_token]);
        await pref.setString(AppKeys.emailFromForm, email.value);
        await pref.setString(AppKeys.passwordFromForm, otp.value);
        await pref.setInt(AppKeys.userId, userProfileModel.value?.id! ?? 3);
        controller.setAccessToken(data[AppKeys.access_token]);
        controller.setEmail(email.value);
          print("ISLOGIN AT OTP VERIFY CONTROLLER : "+isLogin.toString());

        if(!isLogin){
          await patchUserProfile();
        }else{
         await loginPageController.refreshFcm();

          ProfileScreenController controller = Get.put(ProfileScreenController());
          await controller.fetchProfile();
          screen2controller.resetAll();
          Get.offAll(()=>CustomNavBar(),transition: Transition.fadeIn);
          mySuccessSnackbar('Login Successful!');
        }

        isLoading.value = false;
      }else{
        myErrorSnackbar('Please try again with correct Otp');

      }
    }
    catch(e,s){
      // await FirebaseCrashlytics.instance.recordError(e, s,
      //     reason: e.toString(),
      //     fatal: false);
      print(e.toString());
    }
    finally{
      isLoading.value = false;
    }
  }


  Future fetchUserWithEmail() async {
    try {
      final uri = Uri.parse(AppUrls.baseUrl + AppUrls.getUserWithEmail + email.value);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data); // Print the full response to confirm

        // Set the userProfileModel from the parsed data
        userProfileModel.value = UserProfileModel.fromJson(data);

        // Print the user id from the userProfileModel to confirm it's being parsed correctly
        print("USER ID from userProfileModel: ${userProfileModel.value?.id.toString() ?? 'ID is null'}");

      } else {
        print("Failed to fetch user data.");
      }
    } catch (e,s) {
      // await FirebaseCrashlytics.instance.recordError(e, s,
      //     reason: e.toString(),
      //     fatal: false);
      print("Error in fetching user: $e");
    }
  }

  _buildBody(){
    return {
      'email':email.value,
      'otp':otp.value
    };
  }

  validation(){
    return otp.value.length>=6;
  }

}