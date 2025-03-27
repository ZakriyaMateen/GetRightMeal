import 'package:get/get.dart';
import 'package:getrightmealnew/Views/AppViews/CustomNavBar.dart';
import 'package:getrightmealnew/Views/OnBoardingViews/Screen1.dart';

import 'AuthControllers/AccessTokenController.dart';


class SplashScreenController extends GetxController{
  AccessTokenController accessTokenController = Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
        Future.delayed(Duration(seconds: 1),(){  try{
      accessTokenController.initializeAutomatically().then((v){
        print("Uid "+accessTokenController.userId.toString());
        print("Email "+accessTokenController.email.toString());
        print("Password "+accessTokenController.password.toString());
        print("Access Token "+accessTokenController.accessToken.toString());
        if(accessTokenController.accessToken.toString()==''){
          Get.offAll(()=>Screen1(),transition: Transition.fadeIn);

        }else{
          Get.offAll(()=>CustomNavBar(),transition: Transition.fadeIn);

        }
      });
    }catch(e){
      Get.offAll(()=>Screen1(),transition: Transition.fadeIn);
      print('Splash Screen Controller error : '+e.toString());

    }});


  }

}