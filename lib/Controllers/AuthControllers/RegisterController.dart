import 'dart:convert';
import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Widgets/MySnackbar.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constants/AppUrls.dart';
import '../../Models/UserModel.dart';
import '../../Views/AuthViews/VerifyOtpScreenFromRegister.dart';
import '../../constants/AppKeys.dart';
import '../../constants/Colors.dart';
import '../OnBoardingControllers/Screen2Controller.dart';
import '../ProfileScreenController.dart';
import 'AccessTokenController.dart';
import 'VerifyOtpControllerFromRegister.dart';


class RegisterController extends GetxController{


  RxBool isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();


  Future postData({required bool isLogin,required String name})async{

    final uri = Uri.parse(AppUrls.baseUrl+AppUrls.register);

    try{
      isLoading.value = true;

      final response = await http.post(
          uri,
          headers: {
            "Content-Type": "application/json"
          },
          body: jsonEncode(
              {
            "email": emailController.text,
            // "name":emailController.text.split('@')[0],
            "name":name,
            "isGoogleUser": false,
            "googleId": ""
               }
          )
      );
      print("AT REGISTER CONT~ORLLER SREGISTER");
      print(response.body);
      if(response.statusCode == 201){
        var data = jsonDecode(response.body);
        UserModel userModel = UserModel.fromJson(data);

        print(data);
        SharedPreferences pref = await SharedPreferences.getInstance();


        await pref.setString(AppKeys.emailFromForm, emailController.text!);
        // await pref.setString(AppKeys.passwordFromForm, passwordController.text!);
        await pref.setInt(AppKeys.userId, userModel.id!??3);

        AccessTokenController controller = Get.find();


        // controller.setPassword(userModel.password!);
        controller.setEmail(userModel.email!);
        controller.setUserId(userModel.id!??3);

        isLoading.value = false;
        await sendOtp(isLogin);
        //     .then((v){
        //   Get.to(()=>OtpVerificationScreen(email: emailController.text,isLogin: false,));
        // });


      }

      else if(response.statusCode == 500){
        myErrorSnackbar('User already exists');


      }
      else{
        print('error here');
        Get.snackbar(
          'Oops!',
          jsonDecode(response.body)['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: red,
          colorText:white,
          duration: Duration(seconds: 5),
        );
      }

      isLoading.value = false;

    }
    catch(e,s){
      // await FirebaseCrashlytics.instance.recordError(e, s,
      //     reason: e.toString(),
      //     fatal: false);
      isLoading.value = false;
      print("Error at postData of RegisterPage1Controller: "+e.toString());
    }
  }



 _buildBody (){
    return {
    "email": emailController.text,
    "name":emailController.text.split('@')[0],
      "isGoogleUser": false,
      "googleId": ""
    };
  }

  Future sendOtp(bool isLogin)async{

    final uri = Uri.parse(AppUrls.baseUrl+AppUrls.getOtp);

    try{
      isLoading.value = true;
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode(  {
          "email": emailController.text,
          "name":emailController.text.split('@')[0],
          "isGoogleUser": false,
          "googleId": ""
        }),
      );
      var data = await jsonDecode(response.body);
      print("OTP RESPONSE DATA: ");
        print(data);
      if(response.statusCode==201) {
        Get.to(() => OtpVerificationScreen(email: emailController.text, isLogin: isLogin,));

      }

      else if(response.statusCode == 400){
       myErrorSnackbar('Invalid credentials');
      }
      else {
      myErrorSnackbar('Something went wrong!');
      }
      isLoading.value = false;

    }
    catch(e,s){
      await FirebaseCrashlytics.instance.recordError(e, s,
          reason: e.toString(),
          fatal: false);
      isLoading.value = false;
      print("Login Page Controller Error : "+e.toString());
    }
  }

  _buildBodyEmailOnly (){
    return {
      'email':emailController.text,
    };
  }

}