import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Constants/Colors.dart';




void myErrorSnackbar(String title,){
       Get.snackbar(
    'Oops!',
    title,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: red,
    colorText:white,
    duration: Duration(seconds: 5),
  );
}


void mySuccessSnackbar(String title,){
  Get.snackbar(
    'Success!',
    title,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: green,
    colorText:white,
    duration: Duration(seconds: 5),
  );
}




