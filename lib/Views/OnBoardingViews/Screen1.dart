import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Constants/fontWeights.dart';
import 'package:getrightmealnew/Views/AppViews/Webview/webviewScreen.dart';
import 'package:getrightmealnew/Views/OnBoardingViews/Screen2.dart';
import 'package:getrightmealnew/Widgets/Text.dart';
import 'package:getrightmealnew/main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../AuthViews/LoginPage.dart';


class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((v)async{
      await copyToClipboard(fcmToken);
    });
  }
  Future copyToClipboard(String text) async{
    try{
      await  Clipboard.setData(ClipboardData(text: text));
      print("Copied: $text");
    }catch(e){
      print("error at copy to clip");
      print(e.toString());
    }
     // Optional: You can show a snackbar instead
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: SizedBox(width: w,height: h,
           child: FancyShimmerImage(
              cacheKey: 'https://s3.gifyu.com/images/bbRBi.gif',
              width: w,
              height: h,
              imageUrl: 'https://s3.gifyu.com/images/bbRBi.gif', // Network image URL
              boxFit: BoxFit.cover,
              shimmerDuration: Duration(seconds: 2 ), // Shimmer duration
              errorWidget: Icon(Icons.health_and_safety_outlined,size: 50,color: dustyRose,),
            ),          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            width: w,
            height: h,
            color: black.withOpacity(0.6),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: size12,vertical: size15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(width: w,),
                  SizedBox(height: h*0.01,),

                  Container( width: 100,height: 100,
                      alignment: Alignment.centerLeft,
                      child: Image.asset('assets/logoScreen1.png')),
                  SizedBox(height: h*0.015,),
                  MyText(
                    title: 'Diet Plans',
                    size: size25,
                    fontWeight: w800,
                    color: beige,
                  ),
                  MyTextOverflow(
                    textAlign: TextAlign.left,
                    size: size16,
                    color: beige,
                    fontWeight: w400,
                    title: 'AI-crafted weekly meal plans tailored to your health goals',
                  )
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w*0.03,vertical: size15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(() => Screen2());

                      },
                      child: Container(
                          width: w*0.46,
                          padding: EdgeInsets.symmetric(vertical: size16,horizontal: size16),
                          decoration: BoxDecoration(
                              color: red,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: red.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(1, 2),) // changes position of shadow
                              ]
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                title: 'Get Started',
                                size: size18,
                                fontWeight: w600,
                                color: beige,
                              ),
                            ],
                          )
                      ),
                    ),
                    InkWell(
                      onTap: ()async{

                        await showModalBottomSheet(
                        isScrollControlled: true,
                        isDismissible: true,
                        enableDrag: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => LoginPage(),
                        );
                      },
                      child: Container(
                          width: w*0.45,
                          padding: EdgeInsets.symmetric(vertical: size16,horizontal: size16),
                          decoration: BoxDecoration(
                              color: red,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: red.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(1, 2),) // changes position of shadow
                              ]
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MyText(
                                title: 'Login',
                                size: size18,
                                fontWeight: w600,
                                color: beige,
                              ),
                            ],
                          )
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size24,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      title: 'By continuing, you are accepting our',
                      size: size12,
                      fontWeight: w400,
                      color: beige,
                    ),

                  ],
                ),
                TermsAndPrivacyText()

              ],
            )
          ),
        )

      ],
      )
    );
  }
}


class TermsAndPrivacyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(() => WebViewScreen(url: 'https://getrightmeal.com//terms-and-conditions.html'), transition: Transition.rightToLeftWithFade,duration: Duration(seconds: 1));
      },
      child: Text.rich(
      
        TextSpan(
      
          style: GoogleFonts.roboto(
            textBaseline:  TextBaseline.alphabetic,
            textStyle: TextStyle(fontSize: size12,
              color: beige,
      
            ),
          ),
          children: [
            TextSpan(
              text: 'Terms & Conditions',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: beige,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                  decorationColor: beige,
                  fontSize: size14, // Slightly larger font size
                ),
              )
            ),
            // TextSpan(
            //   text: ' & ',
            //   style: TextStyle(fontSize: size12),
            // ),
            // TextSpan(
            //     text: 'Terms of Use',
            //     style: GoogleFonts.roboto(
            //       textStyle: TextStyle(
            //         color: beige,
            //         decorationColor: beige,
            //
            //         fontWeight: FontWeight.bold,
            //         decoration: TextDecoration.underline,
            //         fontSize: size14, // Slightly larger font size
            //       ),
            //     )
            // ),
      
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

