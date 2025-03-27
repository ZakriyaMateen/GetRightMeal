import 'dart:convert';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Views/AppViews/HomeScreen.dart';
import 'package:getrightmealnew/Widgets/MySnackbar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../Constants/AppKeys.dart';
import '../../Models/UserProfileModel.dart';
import '../../Views/AppViews/CustomNavBar.dart';
import '../../Views/AuthViews/VerifyOtpScreenFromRegister.dart';
import '../../constants/AppUrls.dart';
import '../../constants/Colors.dart';
import '../OnBoardingControllers/Screen2Controller.dart';
import '../ProfileScreenController.dart';
import 'AccessTokenController.dart';

class LoginPageController extends GetxController{

  final loginKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;
  AccessTokenController accessTokenController = Get.put(AccessTokenController());
  Screen2Controller screen2controller = Get.put(Screen2Controller());
  Rx<UserProfileModel?> userProfileModel = Rx<UserProfileModel?>(null);

  Future<void> signinWithApple({bool isLogin = true})async{
    try{

      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print(credential.identityToken!);
      try{
        await myApiLoginApple (credential.identityToken!,isLogin: isLogin);
      }catch(e){
        print(e.toString());
        myErrorSnackbar('Could not sign in with apple!');
      }
    }catch(e){
      myErrorSnackbar('Could not sign in with your apple account!',);
      print(e.toString());
    }
  }


  Future<void> signInWithGoogleAndroid({bool isLogin = true}) async {
    try {
        isLoading.value = true;
      final GoogleSignIn _googleSignIn = Platform.isIOS? GoogleSignIn(
          scopes: [
            'email',
          ],
          // clientId: "589894780984-904l2plg71gg0bnid5tmcpcrl6joevkk.apps.googleusercontent.com",
          // clientId: "589894780984-ra21kucvc0hgb5mkvb0drgcmbv1j90fl.apps.googleusercontent.com",
          // clientId: "589894780984-0751u8ucpd3una61njh2aoc63vvcesc8.apps.googleusercontent.com",
          forceCodeForRefreshToken: true,

      ):GoogleSignIn(
        scopes: [
          'email',
        ],
        forceCodeForRefreshToken: true,

      );
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("GOOGLE USER IS NULL");
        return;
      }
        print('GOOGLE USER IS NOT NULL');
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // You can now use googleAuth.accessToken and googleAuth.idToken
      print("Access Token: ${googleAuth.accessToken}");

      print("ID Token: ${googleAuth.idToken}");

      try{
        await myApiLogin( googleAuth.idToken!,isLogin: isLogin);
      }catch(e){
          myErrorSnackbar('Could not sign in with your google account!',);
      }

    } catch (error) {
      print("Google Sign In Error!");
      print(error);
    }finally{
      isLoading.value = false;
    }
  }
  double convertHeightToCm(double height, String unit) {
    switch (unit.toLowerCase()) {
      case 'cm':
        return height; // Already in centimeters.
      case 'in':
        return height * 2.54; // 1 inch = 2.54 cm.
      case 'ft':
        return height * 30.48; // 1 foot = 30.48 cm.
      default:
        return height; // Fallback: assume the value is already in cm.
    }
  }

  double convertWeightToKg(double weight, String unit) {
    switch (unit.toLowerCase()) {
      case 'kg':
        return weight; // Already in kilograms.
      case 'lbs':
        return weight * 0.453592; // 1 lb = 0.453592 kg.
      default:
        return weight; // Fallback: assume the value is already in kg.
    }
  }

  Future<void> myApiLogin(String idToken,{required bool isLogin}) async {
    try{
        isLoading.value = true;
      final uri = Uri.parse(AppUrls.baseUrl + "auth/google-login");
      final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'idToken': idToken,
        }),
      );
      if(response.statusCode == 201){
        print("response Body22123 : " +response.body);
        var data = await jsonDecode(response.body);

        await fetchUserWithEmail(email: data['user']['email']);

        AccessTokenController controller = Get.find();
        SharedPreferences pref = await SharedPreferences.getInstance();

        await pref.setString(AppKeys.access_token, data[AppKeys.access_token]);

        await pref.setString(AppKeys.emailFromForm, data['user']['email']);



        await pref.setInt(AppKeys.userId, userProfileModel.value?.id! ?? 3);


        controller.setAccessToken(data[AppKeys.access_token]);
        controller.setEmail(data['user']['email']);

        print(data[AppKeys.access_token]);


        print('gonna patch the user profile at next line');
        print(isLogin);
        if(!isLogin){
          await patchUserProfile();
        }
        else{
          await refreshFcm();

          print('Not patching the user profile');
          ProfileScreenController controller = Get.put(ProfileScreenController());
          await controller.fetchProfile();

          Get.offAll(()=>CustomNavBar(),transition: Transition.fadeIn);
          // await routeToSplashScreenIfNeedsToSignUp();

        isLoading.value = false;
        }

      }else{
        print("response Body 232123: " +response.body);
      }

    }catch(e){
      myErrorSnackbar('Unable to sign in with your google account!',);
      print(e.toString());
    }
    finally{
      isLoading.value = false;

    }
  }
  Future<void> myApiLoginApple(String idToken,{required bool isLogin}) async {
    try{
      isLoading.value = true;
      final uri = Uri.parse(AppUrls.baseUrl + "auth/apple-login");
      final response = await http.post(uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'idToken': idToken,
        }),
      );
      print("Response at apple login");
      print(response.body);
      if(response.statusCode == 201){
        print("response Body22123 : " +response.body);
        var data = await jsonDecode(response.body);

        await fetchUserWithEmail(email: data['user']['email']);

        AccessTokenController controller = Get.find();
        SharedPreferences pref = await SharedPreferences.getInstance();

        await pref.setString(AppKeys.access_token, data[AppKeys.access_token]);

        await pref.setString(AppKeys.emailFromForm, data['user']['email']);



        await pref.setInt(AppKeys.userId, userProfileModel.value?.id! ?? 3);


        controller.setAccessToken(data[AppKeys.access_token]);
        controller.setEmail(data['user']['email']);

        print(data[AppKeys.access_token]);


        print('gonna patch the user profile at next line');
        print(isLogin);
        if(!isLogin){
          await patchUserProfile();
        }
        else{
          await refreshFcm();
          print('Not patching the user profile');
          ProfileScreenController controller = Get.put(ProfileScreenController());
          await controller.fetchProfile();

          Get.offAll(()=>CustomNavBar(),transition: Transition.fadeIn);
          // await routeToSplashScreenIfNeedsToSignUp();

          isLoading.value = false;
        }

      }else{
        print("response Body 232123: " +response.body);
      }

    }catch(e){
      Get.snackbar(
        'Error Occurred',
        'Please try again later',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: black,
        colorText:plumGrey,
        duration: Duration(seconds: 5),
      );
      print(e.toString());
    }
    finally{
      isLoading.value = false;

    }
  }

  Future<void> refreshFcm() async {

    await accessTokenController.initializeAutomatically();
    isLoading.value = true;

    // Map your selectedIndex to allowed goal values

    // Ensure goal is valid
    print('heelloo');
    var cmInchFeet = screen2controller.cmInchFeet.value;
    var kgLbs = screen2controller.kgLbs.value;




    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if(screen2controller.cmInchFeet.value == 'ft'){
      screen2controller.cmInchFeet.value = 'in';
    }
    final Map<String, dynamic> payload = {
      'notificationToken':fcmToken??''
    };

    try {
      print(accessTokenController.userId.value);
      print(accessTokenController.accessToken.value);

      final response = await http.patch(
        Uri.parse('${AppUrls.baseUrl}${AppUrls.patchUserProfile}'),
        headers: {
          'Authorization': "Bearer ${accessTokenController.accessToken.value}",
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode(payload), // Encode the payload to JSON
      );
      print("response body at next line");
      print(response.body);
      if(response.statusCode == 200){
        print("FCM TOkeN UPDAteD");
        print('REsponse after updating');
        print(response.body);
        ProfileScreenController controller = Get.put(ProfileScreenController());
        await controller.fetchProfile();

      }
      Get.offAll(()=>CustomNavBar(),transition: Transition.fadeIn);

      isLoading.value = false;

    }
    catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s,
          reason: e.toString(),
          fatal: false);
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }
  Future<void> patchUserProfile() async {

    await accessTokenController.initializeAutomatically();
    isLoading.value = true;

    // Map your selectedIndex to allowed goal values

    // Ensure goal is valid
    print('heelloo');
    var cmInchFeet = screen2controller.cmInchFeet.value;
    var kgLbs = screen2controller.kgLbs.value;




    String? fcmToken = await FirebaseMessaging.instance.getToken();
    if(screen2controller.cmInchFeet.value == 'ft'){
      screen2controller.cmInchFeet.value = 'in';
    }
    final Map<String, dynamic> payload = {
      'country': screen2controller.country.value == "Select Country"? 1: screen2controller.country.value, // Assuming you need to add this field
      'city': 'Dubai', // Add city if required
      'dateOfBirth': screen2controller.selectedDateOfBirth.value.toString(), // Ensure valid date format
      'gender': screen2controller.selectedGender.value.toLowerCase(), // Send gender as string
      'height': screen2controller.selectedHeight.value, // Send as int
      'weight': screen2controller.selectedWeight.value??0.0, // Send as double
      "weightUnit": screen2controller.kgLbs.value,
      "heightUnit": screen2controller.cmInchFeet.value,
      'goal': screen2controller.selectedGoal.value, // Use the validated goal value
      // 'name': screen2controller.name.value,
      'activityLevel': (screen2controller.selectedActivityLevel.value) ?? 1, // Keep as int
      'dairyPreferences': screen2controller.selectedDietaryPreferences.value, // Send List as-is
      'cuisinePreferences':screen2controller.selectedCuisinePreferences.value,
      'notificationToken':fcmToken??''
    };

    try {
      print(accessTokenController.userId.value);
      print(accessTokenController.accessToken.value);

      final response = await http.patch(
        Uri.parse('${AppUrls.baseUrl}${AppUrls.patchUserProfile}'),
        headers: {
          'Authorization': "Bearer ${accessTokenController.accessToken.value}",
          'Content-Type': 'application/json', // Set the content type to JSON
        },
        body: jsonEncode(payload), // Encode the payload to JSON
      );
      print("response body at next line");
      print(response.body);
      if(response.statusCode == 200){

        print('REsponse after updating');
        print(response.body);
        ProfileScreenController controller = Get.put(ProfileScreenController());
        await controller.fetchProfile();



      }
      Get.offAll(()=>CustomNavBar(),transition: Transition.fadeIn);

      isLoading.value = false;

    }
    catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s,
          reason: e.toString(),
          fatal: false);
    } finally {
      isLoading.value = false; // Reset loading state
    }
  }
  Future fetchUserWithEmail({required String email}) async {
    try {
      final uri = Uri.parse(AppUrls.baseUrl + AppUrls.getUserWithEmail + email);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data); // Print the full response to confirm

        // Set the userProfileModel from the parsed data
        userProfileModel.value = UserProfileModel.fromJson(data);

        // Print the user id from the userProfileModel to confirm it's being parsed correctly

      } else {
      }
    } catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(e, s,
          reason: e,
          fatal: false);
    }
  }


  void validate()async{
    if(loginKey.currentState!.validate()){

      await postData();
    }
  }
  Future<void> postData({bool fromOtpScreen = false}) async {
    final uri = Uri.parse(AppUrls.baseUrl + AppUrls.getOtp);

    try {
      print("making request");
      isLoading.value = true;
      final response = await http.post(
        uri,
        body: _buildBody(),
        // headers: {
        //   'Content-Type': 'application/json',
        // }
      );
      print(response.body);

      // Check if the response is JSON
      if (response.headers['content-type']?.contains('application/json') ?? false) {
        var data = await jsonDecode(response.body);
        print(data);

        if (response.statusCode == 201) {
          mySuccessSnackbar('Otp sent successfully');
         if(!fromOtpScreen) Get.to(()=>OtpVerificationScreen(email: emailController.text,isLogin: true,));
        } else if (response.statusCode == 400) {
          myErrorSnackbar(jsonDecode(response.body)['message']);
        } else {
          myErrorSnackbar(jsonDecode(response.body)['message']);

        }
      } else {
        // Handle the case where the response is not JSON
        myErrorSnackbar('Unexpected Error, try again later');

      }
      isLoading.value = false;
    } catch (e , s) {
      // await FirebaseCrashlytics.instance.recordError(e, s,
      //     reason: e.toString(),
      //     fatal: false);
      isLoading.value = false;
      print("Login Page Controller Error: " + e.toString());
     myErrorSnackbar('Unexpected Error, try again later');
    }
  }

  _buildBody (){
    return {
      'email':emailController.text,
    };
  }


}