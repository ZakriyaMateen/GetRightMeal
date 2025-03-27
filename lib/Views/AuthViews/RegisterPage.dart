import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Views/AuthViews/VerifyOtpScreenFromRegister.dart';
import 'package:getrightmealnew/Widgets/Text.dart';
import 'package:getrightmealnew/main.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../../Constants/fontWeights.dart';
import '../../Controllers/AuthControllers/LoginPageController.dart';
import '../../Controllers/AuthControllers/RegisterController.dart';
import '../AppViews/CustomNavBar.dart';

class RegisterPage extends StatefulWidget {
  final String name;
  const RegisterPage({super.key, required this.name});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterController controller = Get.put(RegisterController());
  LoginPageController loginPageController = Get.put(LoginPageController());

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: w,
        height: h*0.95,
        decoration: BoxDecoration(
          color: beige,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                  ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: w,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                color: black,

              ),
              child: Stack(
                children: [
                  SizedBox(
                    width: w,
                    height: 250,
                    child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
                        child:
                        FancyShimmerImage(
                          imageUrl: "https://s3.gifyu.com/images/bSarv.jpg", // Network image URL
                          boxFit: BoxFit.cover,
                          shimmerDuration: Duration(seconds: 3), // Shimmer duration
                          errorWidget: Icon(Icons.health_and_safety_outlined,size: 50,color: dustyRose,),
                        ),
                        // CachedNetworkImage(imageUrl: 'https://s3.gifyu.com/images/bSarv.jpg',fit: BoxFit.cover, )
                    ),
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20,left: 20),
                      child: InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: grey,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: plumGrey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(2, 3) // changes position of shadow
                              )
                            ]
                          ),
                          child: Center(
                            child: Icon(Icons.arrow_back_ios_rounded,color: plumGrey,size:size24),
                          ),
                        ),
                      )
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: w,
              height: h*0.95-250,
              child: Form(
                key: formKey,
                child: LayoutBuilder(
                  builder: (context,constraints) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: constraints.maxWidth * 0.05,
                          right: constraints.maxWidth * 0.05,
                          top: constraints.maxHeight * 0.02,
                          bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts for keyboard
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                MyText(
                                  title: 'Ready to get started?',
                                  fontWeight: w700,
                                  color: dustyRose,
                                  size: size24,
                                )
                              ],
                            ),
                            SizedBox(height: h*0.002,),
                            Row(
                              children: [
                                MyText(
                                  title: 'Create an account to continue',
                                  fontWeight: w600,
                                  color: plumGrey,
                                  size: size14,
                                )
                              ],
                            ),
                            SizedBox(height: h*0.02,),
                            TextFormField(
                              onFieldSubmitted: (v)async{
                                if(formKey.currentState!.validate()){
                                  await controller.postData(isLogin: false,name: widget.name);
                                }
                              },
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.emailController,
                              validator: (v){
                                return EmailValidator.validate(v!)?null:'Please enter a valid email';
                              },
                              decoration: InputDecoration(
                                hintText: 'Email',

                                  hintStyle: TextStyle(
                                      color: plumGrey,
                                      fontSize: size14,
                                      fontWeight: w400
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: dustyRose,width: 1)
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.red,width: 1.75)
                                  ),
                                  enabledBorder:OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: dustyRose,width: 1)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: dustyRose,width: 1.75)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.red,width: 1.75)
                                  )

                              ),
                            ),
                            SizedBox(height: h*0.03,),
                            Obx(()=>(controller.isLoading.value || loginPageController.isLoading.value)?
                            CupertinoActivityIndicator():
                            InkWell(
                              onTap: ()async{
                                if(formKey.currentState!.validate()){
                                  await controller.postData(isLogin: false,name: widget.name);
                                }
                              },
                              child:Container(
                                width: w,
                                height: 60,
                                margin: EdgeInsets.only(bottom: h * 0.02),
                                decoration: BoxDecoration(
                                  color: red,
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Center(
                                  child: MyText(
                                    title: "Continue",
                                    color: white,
                                    size: size19,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                            ),
                            SizedBox(height: h*0.03,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(child: Divider(
                                  thickness: 1,
                                  color: plumGrey,
                                )),
                                SizedBox(width: 8,),
                                MyText(
                                  title: 'or',
                                  fontWeight: w600,
                                  color: plumGrey,
                                  size: size14,
                                ),
                                SizedBox(width: 8,),

                                Flexible(child: Divider(
                                  thickness: 1,
                                  color: plumGrey,
                                )),
                              ],
                            ),
                            SizedBox(height: h*0.03,),
                           if(Platform.isIOS)
                             Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               mainAxisAlignment: MainAxisAlignment.center,

                               children: [

                                 // InkWell(
                                 //   onTap: ()async{
                                 //     if(Platform.isIOS){
                                 //       await loginPageController.signInWithGoogleAndroid(isLogin: false);
                                 //     }
                                 //   },
                                 //   child: Container(
                                 //     padding: EdgeInsets.all(20),
                                 //     decoration: BoxDecoration(
                                 //         shape: BoxShape.circle,
                                 //         border: Border.all(color: plumGrey,width: 1)
                                 //     ),
                                 //     child: Center(
                                 //       child: Image.asset('assets/google.png',width: 30,height: 30,),
                                 //     ),
                                 //   ),
                                 // ),
                                 SizedBox(width: 20,),
                                 InkWell(
                                   onTap: ()async{
                                     await loginPageController.signinWithApple(isLogin: false);
                                   },
                                   child: Container(
                                     padding: EdgeInsets.all(20),
                                     decoration: BoxDecoration(
                                         shape: BoxShape.circle,
                                         border: Border.all(color: plumGrey,width: 1)
                                     ),
                                     child: Center(
                                       child: Image.asset('assets/apple.png',width: 30,height: 30,),
                                     ),
                                   ),
                                 )
                               ],
                             ),
                            if(Platform.isAndroid)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: [

                                  InkWell(
                                    onTap: ()async{
                                      await loginPageController.signInWithGoogleAndroid(isLogin: false);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: plumGrey,width: 1)
                                      ),
                                      child: Center(
                                        child: Image.asset('assets/google.png',width: 30,height: 30,),
                                      ),
                                    ),
                                  ),

                                ],
                              )
                          ],
                        ),
                      ),
                    );
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
