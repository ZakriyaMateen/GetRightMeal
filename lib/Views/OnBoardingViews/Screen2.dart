import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Controllers/OnBoardingControllers/Screen2Controller.dart';
import 'package:getrightmealnew/Widgets/HeightPicker.dart';
import 'package:getrightmealnew/Widgets/MySnackbar.dart';
import 'package:getrightmealnew/Widgets/Text.dart';
import 'package:getrightmealnew/Widgets/bg.dart';
import 'package:getrightmealnew/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_date_picker/scroll_date_picker.dart';
import 'dart:math';

import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../../Constants/fontWeights.dart';
import '../../Controllers/AuthControllers/RegisterProfileInfo.dart';
import '../../Helpers/DecimalHelper.dart';
import '../AuthViews/RegisterPage.dart';
import '../CheckoutViews/CheckoutScreen.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> with SingleTickerProviderStateMixin{
  Screen2Controller controller = Get.put(Screen2Controller());
  late TabController tabBarController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.resetAll();
    tabBarController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((v)async{
      await controller.getGoals();
      await controller.getActivity();
      await controller.getDietaryPreferences();
      await controller.getCuisinePreferences();
      await controller.getCountries();
    });
  }



  Widget animate({required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 2000),
      curve: Curves.linearToEaseOut,
      builder: (context, animValue, child) {
        return Transform.translate(
          offset: Offset(-2, 2), // animate scale from 0 to 1 with bounce
          child: Opacity(
            opacity: animValue, // animate fade in
            child: child,
          ),
        );
      },
      child: child,
    );
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(

      onWillPop: ()async {
        return false;
      },
      child: Scaffold(
        backgroundColor: beige,
        body: Stack(
          children: [
            BgWidget(),
            Container(
              width: w,
              height: h,
              color: beige.withOpacity(0.9),
            ),
            SingleChildScrollView(
              child: SafeArea(

                child: Padding(
                  padding: EdgeInsets.only(top: size18, left: size13, right: size13),
                  child: Stack(
                    children: [




                      Padding(
                        padding: EdgeInsets.only(top: h*0.22),
                        child: Obx(() {
                          Widget button =    Obx(() {
                            // The middle content changes based on the pageIndex.
                            // Wrap that content with the same animation.
                            if (controller.pageIndex.value == 0) {
                              return chooseGender(controller);
                            } else if (controller.pageIndex.value == 1) {
                              return dateOfBirthPicker(controller);
                            } else if (controller.pageIndex.value == 2) {
                              return  heightPicker(controller);
                            } else if (controller.pageIndex.value == 3) {
                              return  weightPicker(controller);
                            } else if (controller.pageIndex.value == 4) {
                              return  selectGoal(controller);
                            } else if (controller.pageIndex.value == 5) {
                              return  selectActivityLevel(controller);
                            } else if (controller.pageIndex.value == 6) {
                              return  selectDietaryPreferences(controller);
                            } else if (controller.pageIndex.value == 7){
                              return selectCuisinePreferences(controller);
                            }

                            else {
                              return Container();
                            }
                          });
                          return AnimatedSwitcher(
                            switchInCurve: Curves.easeInToLinear,
                            switchOutCurve: Curves.easeInBack,
                            duration: Duration(milliseconds: 1600),
                            reverseDuration: Duration(milliseconds: 500),
                            transitionBuilder: (child, animation) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: Offset(0, -4), // Change here: widget comes down from top
                                  end: Offset.zero,
                                ).animate(animation),
                                // child: child,
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                            // Changing key forces re-animation on page change
                            child: Container(
                              key: ValueKey(controller.pageIndex.value),
                              child: button,
                            ),
                          );
                        }),
                      ),
                      // topHeader(controller),
                      Obx(() {
                        Widget button = topHeader(controller);
                        return AnimatedSwitcher(
                          switchInCurve: Curves.easeInToLinear,
                          switchOutCurve: Curves.easeInBack,
                          duration: Duration(milliseconds: 1850),
                          reverseDuration: Duration(milliseconds: 500),
                          transitionBuilder: (child, animation) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: Offset(0, -9), // Change here: widget comes down from top
                                end: Offset.zero,
                              ).animate(animation),
                              child: FadeTransition(
                                opacity: animation,
                                child: child,
                              ),
                            );
                          },
                          // Changing key forces re-animation on page change
                          child: Container(
                            key: ValueKey(controller.pageIndex.value),
                            child: button,
                          ),
                        );
                      }),
                      Padding(
                        padding: EdgeInsets.only(top: h*0.055),
                        child: Obx(() {
                          Widget button = heading(controller.headingList);
                          return AnimatedSwitcher(
                            switchInCurve: Curves.easeInToLinear,
                            switchOutCurve: Curves.easeInBack,
                            duration: Duration(milliseconds: 1000),
                            reverseDuration: Duration(milliseconds: 500),
                            transitionBuilder: (child, animation) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: Offset(0, -7), // Change here: widget comes down from top
                                  end: Offset.zero,
                                ).animate(animation),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                            // Changing key forces re-animation on page change
                            child: Container(
                              key: ValueKey(controller.pageIndex.value),
                              child: button,
                            ),
                          );
                        }),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            // Bottom button always appears at the bottom.
            Obx((){
              Widget button =Align(
                alignment: Alignment.bottomCenter,
                child: Obx(() {
                  Widget button;
                  if (controller.pageIndex.value == 1) {
                    button = InkWell(
                      onTap: () {

                          controller.pageIndex.value = 2;

                      },
                      child: Container(
                        width: w,
                        height: 60,
                        margin: EdgeInsets.only(bottom: h * 0.02, left: w * 0.04, right: w * 0.04),
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: MyText(
                            title: "Next",
                            color: white,
                            size: size19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  }
                  else if (controller.pageIndex.value == 2) {
                    button = InkWell(
                      onTap: () {
                        if(controller.selectedHeight.value!=0){
                          controller.pageIndex.value = 3;
                        }else{
                          myErrorSnackbar('Please enter your height!');
                        }
                      },
                      child: Container(
                        width: w,
                        height: 60,
                        margin: EdgeInsets.only(bottom: h * 0.02, left: w * 0.04, right: w * 0.04),
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: MyText(
                            title: "Next",
                            color: white,
                            size: size19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  } else if (controller.pageIndex.value == 3) {
                    button = InkWell(
                      onTap: () {
                       if(controller.selectedWeight.value!=0){
                         controller.pageIndex.value = 4;
                       }else{
                         myErrorSnackbar('Please enter your weight!');
                       }
                      },
                      child: Container(
                        width: w,
                        height: 60,
                        margin: EdgeInsets.only(bottom: h * 0.02, left: w * 0.04, right: w * 0.04),
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: MyText(
                            title: "Next",
                            color: white,
                            size: size19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  }
                  else if (controller.pageIndex.value == 4) {
                    button = InkWell(
                      onTap: () {
                        controller.pageIndex.value = 5;
                      },
                      child: Container(
                        width: w,
                        height: 60,
                        margin: EdgeInsets.only(bottom: h * 0.02, left: w * 0.04, right: w * 0.04),
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: MyText(
                            title: "Next",
                            color: white,
                            size: size19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  }
                  else if (controller.pageIndex.value == 5) {
                    button = InkWell(
                      onTap: () {
                        controller.pageIndex.value = 6;
                      },
                      child: Container(
                        width: w,
                        height: 60,
                        margin: EdgeInsets.only(bottom: h * 0.02, left: w * 0.04, right: w * 0.04),
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: MyText(
                            title: "Next",
                            color: white,
                            size: size19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  } else if (controller.pageIndex.value == 6) {
                    button = InkWell(
                      onTap: () {
                        if (controller.selectedDietaryPreferences.isNotEmpty) {
                            controller.pageIndex.value = 7;
                        } else {
                          myErrorSnackbar('Please select at least one dietary preference');
                        }
                      },
                      child: Container(
                        width: w,
                        height: 60,
                        margin: EdgeInsets.only(bottom: h * 0.02, left: w * 0.04, right: w * 0.04),
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: MyText(
                            title: "Next",
                            color: white,
                            size: size19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );
                  }
                  else if (controller.pageIndex.value == 7){
                    button = InkWell(
                      onTap: (){
                        if (controller.selectedCuisinePreferences.isNotEmpty) {
                          Get.to(
                                () => RegisterProfileInfo(fromRegister: true),
                            transition: Transition.rightToLeftWithFade,
                          );
                        } else {
                          myErrorSnackbar('Please select at least one cuisines preference');
                        }
                      },
                      child: Container(
                        width: w,
                        height: 60,
                        margin: EdgeInsets.only(bottom: h * 0.02, left: w * 0.04, right: w * 0.04),
                        decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: MyText(
                            title: "Next",
                            color: white,
                            size: size19,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    );


                  }
                  else {
                    button = Container();
                  }
                  // Wrap the bottom button with animation
                  return animate(child: button);
                }),
              );
             return  AnimatedSwitcher(
               duration: Duration(milliseconds: 1200),
               switchInCurve: Curves.easeInOut,  // Smooth transition
               transitionBuilder: (child, animation) {
                 final curvedAnimation = CurvedAnimation(
                   parent: animation,
                   curve: Curves.easeInOut,  // Smooth slow transition
                 );

                 return SlideTransition(
                   position: Tween<Offset>(
                     begin: Offset(0, 0.5),  // Pehle se chhoti movement
                     end: Offset.zero,
                   ).animate(curvedAnimation),
                   child: FadeTransition(
                     opacity: curvedAnimation,  // Smooth fade-in
                     child: child,
                   ),
                 );
               },
               child: Container(
                 key: ValueKey(controller.pageIndex.value),
                 child: button,
               ),
             );

            })
            ,
          ],
        ),
      )

    );
  }
  Widget heading (List<String> headingList){
    return Container(
      color: beige,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: size20),
            child:Obx(()=> MyTextOverflow(
              textAlign: TextAlign.center,
              title: headingList[controller.pageIndex.value],
              color: dustyRose,
              fontWeight: w800,
              size: size20,
            ),)
          ),
          SizedBox(height: h*0.01,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: w*0.05),
            child: MyTextOverflow(
              textAlign: TextAlign.center,
              title: 'Please answer the above question to help us personalise your plan and calculate your daily goal',
              color: plumGrey,
              fontWeight: w300,
              size: size14,
            ),
          )
        ],
      ),
    );
  }

  Widget topHeader (Screen2Controller controller){

    return Column(
      children: [
        Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: (){
                controller.pageIndex.value != 0?
                controller.pageIndex.value--:Get.back();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back,color: red,),
                  SizedBox(width: size4,),
                  MyText(
                    title: 'Back',
                    fontWeight: w500,
                    size: size15,
                    color: red,
                  )
                ],
              ),
            ),
          Obx((){
            int step = controller.pageIndex.value +1;
            return MyText(
              title: "Step ${step}",
              color: plumGrey,
              fontWeight: w500,
              size: size15,
            );
          }),
            Row(
              children: [
                Icon(Icons.arrow_back,color: beige,),
                SizedBox(width: size4,),
                MyText(
                  title: 'Back',
                  fontWeight: w500,
                  size: size15,
                  color: beige,
                )
              ],
            ),
    ]),
        SizedBox(height: h*0.02,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: size10),
          child:   Obx((){
            int step = controller.pageIndex.value +1;
            return   LinearProgressIndicator(
              minHeight: size5,
              borderRadius: BorderRadius.circular(50),
              value: (step)/9,
              backgroundColor: red.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(red),
            );
          }),
        )

      ]);

  }

  // Widget weightPicker (Screen2Controller controller){
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Padding(
  //         padding:  EdgeInsets.only(right: size15),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Container(padding:EdgeInsets.symmetric(horizontal: 20,),
  //               decoration: BoxDecoration(
  //                   color: white,
  //                   borderRadius: BorderRadius.circular(12),
  //                   border: Border.all(color: dustyRose,width: 1),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.grey.withOpacity(0.2),
  //                       spreadRadius: 1,
  //                       blurRadius: 1,
  //                       offset: Offset(0, 1), // changes position of shadow
  //                     ),
  //                   ]
  //               ),
  //               alignment: Alignment.center,
  //               child: Center(
  //                 child: DropdownButton(
  //                     value: controller.kgLbs.value,
  //                     style: TextStyle(color: dustyRose,fontSize: size18,fontWeight: w600),
  //                     borderRadius: BorderRadius.circular(12),
  //                     underline: Container(),
  //                     dropdownColor: white,
  //                     items: [
  //                       DropdownMenuItem(
  //                         child: MyText(title: 'kg',color: dustyRose, size: 18,fontWeight: w600),value: 'kg',),
  //                       DropdownMenuItem(
  //                         child: MyText(title: 'lbs',color: dustyRose, size: 18,fontWeight: w600),value: 'lbs',),
  //
  //                     ], onChanged: (v){
  //                   controller.kgLbs.value = v.toString();
  //                 }),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //
  //       Container(
  //         padding: EdgeInsets.only(left: w*0.05,right: w*0.05,top: h*0.5),
  //         alignment: Alignment.topCenter,
  //         width: w,
  //         height: h*0.65,
  //         child:Obx(()=>AnimatedWeightPicker(
  //
  //           min: 20,
  //         division: 1,
  //           suffixText: controller.kgLbs.value,
  //           squeeze: 4,
  //           selectedValueColor: plumGrey,
  //           suffixTextColor: plumGrey,
  //           dialColor: red,
  //           max: 400,
  //           majorIntervalThickness: 2,
  //           onChange: (newValue) {
  //             // Convert the newValue to a double
  //             double newValueDouble = double.parse(newValue.toString());
  //             // Get the ceiling value
  //             int ceilingValue = newValueDouble.ceil();
  //             controller.selectedWeight.value = ceilingValue;
  //             print(controller.selectedWeight.value);
  //           },
  //         ))
  //
  //       ),
  //
  //       InkWell(
  //         onTap: (){
  //           Future.delayed(Duration(
  //             milliseconds: 400,
  //           ),(){
  //             controller.pageIndex.value = 4;
  //           });
  //         },
  //         child: Container(
  //           width: w,
  //           height: 45,
  //           decoration: BoxDecoration(
  //               color: red,
  //               borderRadius: BorderRadius.circular(50)
  //           ),
  //           child: Center(
  //             child: MyText(
  //               title: "Continue",
  //               color: white,
  //               size: size15,
  //               fontWeight: FontWeight.w700,
  //             ),
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }


  // Widget heightPicker (Screen2Controller controller){
  //
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.end,
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Padding(
  //         padding:  EdgeInsets.only(right: size15),
  //         child: Row(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Container(
  //               padding:EdgeInsets.symmetric(horizontal: 20,),
  //               decoration: BoxDecoration(
  //                   color: white,
  //                   borderRadius: BorderRadius.circular(12),
  //                   border: Border.all(color: dustyRose,width: 1),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Colors.grey.withOpacity(0.2),
  //                       spreadRadius: 1,
  //                       blurRadius: 1,
  //                       offset: Offset(0, 1), // changes position of shadow
  //                     ),
  //                   ]
  //               ),
  //               alignment: Alignment.center,
  //               child: Center(
  //                 child: DropdownButton(
  //                     value: controller.cmInchFeet.value,
  //                     style: TextStyle(color: dustyRose,fontSize: size18,fontWeight: w600),
  //                     borderRadius: BorderRadius.circular(12),
  //                     underline: Container(),
  //                     dropdownColor: white,
  //                     items: [
  //
  //
  //                       DropdownMenuItem(
  //                         child: MyText(title: 'cm',color: dustyRose, size: size18,fontWeight: w600),value: 'cm',),
  //                       DropdownMenuItem(
  //                         child: MyText(title: 'in',color: dustyRose, size: size18,fontWeight: w600),value: 'in',),
  //                       DropdownMenuItem(
  //                         child: MyText(title: 'ft',color: dustyRose, size: size18,fontWeight: w600),value: 'ft',),
  //
  //                     ], onChanged: (v){
  //                   controller.cmInchFeet.value = v.toString();
  //                 }),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //       Container(
  //         width: w,
  //         height: h*0.65,
  //         child: Obx(()=>CupertinoPicker(
  //           selectionOverlay: Container(
  //             height: 75,
  //             decoration: BoxDecoration(
  //               borderRadius: BorderRadius.circular(12),
  //               color: red.withOpacity(0.2),
  //               border: Border(
  //                 top: BorderSide(color: red, width: 3.0),
  //                 bottom: BorderSide(color: red, width: 3.0),
  //                 left: BorderSide(color: red, width: 3.0),
  //                 right: BorderSide(color: red, width: 3.0),
  //               ),
  //             ),
  //           ),
  //
  //           useMagnifier: true,
  //           magnification: 1.3,
  //           itemExtent: 50,
  //           onSelectedItemChanged: (int index){
  //             if(controller.cmInchFeet.value == 'ft'){
  //               controller.selectedHeight.value = index+1;
  //             }else{
  //               controller.selectedHeight.value = index+50;
  //             }
  //           },
  //           children:
  //           controller.cmInchFeet.value == 'ft'?
  //           List.generate(14, (index){
  //             return Center(
  //               child: MyText(
  //                 title: '${index+1} '+controller.cmInchFeet.value,
  //                 color: dustyRose,
  //                 size: size20,
  //                 fontWeight: FontWeight.w700,
  //               ),
  //             );
  //           }):
  //           List.generate(400, (index){
  //             return Center(
  //               child: MyText(
  //                 title: '${index+50} '+controller.cmInchFeet.value,
  //                 color: dustyRose,
  //                 size: size20,
  //                 fontWeight: FontWeight.w700,
  //               ),
  //             );
  //           }),
  //         )),
  //       ),
  //
  //       InkWell(
  //         onTap: (){
  //           Future.delayed(Duration(
  //             milliseconds: 400,
  //           ),(){
  //             controller.pageIndex.value = 3;
  //           });
  //         },
  //         child: Container(
  //           width: w,
  //           height: 45,
  //           decoration: BoxDecoration(
  //               color: red,
  //               borderRadius: BorderRadius.circular(50)
  //           ),
  //           child: Center(
  //             child: MyText(
  //               title: "Continue",
  //               color: white,
  //               size: size15,
  //               fontWeight: FontWeight.w700,
  //             ),
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  Widget weightPicker(Screen2Controller controller) {
    FocusNode weightFocus = FocusNode();
    weightFocus.requestFocus();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Replace dropdown with animated tabs for unit selection.
        Padding(
          padding: EdgeInsets.only(top: size15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => weightUnitTab(controller, unit: 'kg')),
              Obx(() => weightUnitTab(controller, unit: 'lbs')),
            ],
          ),
        ),
        SizedBox(width: w,),
        SizedBox(height: h*0.08,),
        Container(
          width: 200,
          height: 60,
          alignment: Alignment.center,
          child: SizedBox(
            height: 60,
            child: TextFormField(
              focusNode: weightFocus,
              textAlign: TextAlign.center,
              onChanged: (newValue) {
                // Convert the newValue to a double
                double newValueDouble = double.parse(newValue);
                // Get the ceiling value
                int ceilingValue = newValueDouble.ceil();
                controller.selectedWeight.value = ceilingValue;
                print(controller.selectedWeight.value);
              },
              decoration: InputDecoration(
                suffixText: controller.kgLbs.value,
                suffixStyle:GoogleFonts.roboto(
                  fontSize: size17,
                  color: red,
                  fontWeight: FontWeight.w600,
                ),
                hintText: controller.selectedWeight.value != 0?controller.selectedWeight.value.toString() :'0',
                border: InputBorder.none, // No border
                contentPadding: EdgeInsets.zero, // Remove padding
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              inputFormatters: [
                DecimalTextInputFormatter(decimalRange: 0, integerRange: 3),
              ],
              style: GoogleFonts.roboto(
                fontSize: 50,
                color: red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )

        ,

      ],
    );
  }

  Widget weightUnitTab(Screen2Controller controller, {required String unit}) {
    bool isSelected = controller.kgLbs.value == unit;
    return GestureDetector(
      onTap: () {
        controller.kgLbs.value = unit;
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 70,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? red.withOpacity(0.3) : Colors.white70,
          border: Border.all(color: dustyRose, width: 0.5),
        ),
        child: MyText(
          title: unit,
          color: isSelected ? red : dustyRose,
          size: size18,
          fontWeight: w600,
        ),
      ),
    );
  }

  Widget heightPicker(Screen2Controller controller) {
    FocusNode heightFocus = FocusNode();
    heightFocus.requestFocus();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Custom animated unit tabs instead of a dropdown
        Padding(
          padding: EdgeInsets.only(top: size15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => unitTab(controller, unit: 'cm')),
              Obx(() => unitTab(controller, unit: 'in')),
              Obx(() => unitTab(controller, unit: 'ft')),
            ],
          ),
        ),
        SizedBox(width: w,),
        SizedBox(height: h*0.08,),
        Obx((){return
    controller.cmInchFeet.value == "ft"?
    HeightPicker( controller:controller,):


    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 200,
          height: 60,
          alignment: Alignment.center,
          child: SizedBox(
            height: 60,
            child: TextFormField(
              focusNode: heightFocus,
              textAlign: TextAlign.center,
              onChanged: (newValue) {
               if(newValue == ''){

                 controller.selectedHeight.value = 0.0;
                 print(controller.selectedHeight.value);
               }else{
                 double value = double.parse(newValue);
                 controller.selectedHeight.value = value;
                 print(controller.selectedHeight.value);
               }
                },
              decoration: InputDecoration(
                suffixText: controller.cmInchFeet.value,
                suffixStyle:GoogleFonts.roboto(
                  fontSize: size17,
                  color: red,
                  fontWeight: FontWeight.w600,
                ),
                hintText: controller.selectedHeight.value!=0?controller.selectedHeight.value.toString():"0",
                border: InputBorder.none, // No border
                contentPadding: EdgeInsets.zero, // Remove padding
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: false),
              inputFormatters: [
                DecimalTextInputFormatter(decimalRange: 0, integerRange: controller.cmInchFeet.value == "cm"? 4:3),
              ],
              style: GoogleFonts.roboto(
                fontSize: 50,
                color: red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    )
    ;


    })


      ],
    );
  }

  Widget unitTab(Screen2Controller controller, {required String unit}) {
    bool isSelected = controller.cmInchFeet.value == unit;
    return GestureDetector(
      onTap: () {
        controller.cmInchFeet.value = unit;
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: 70,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? red.withOpacity(0.3) : Colors.white70,
          border: Border.all(color: dustyRose, width: 0.5),
        ),
        child: MyText(
          title: unit,
          color: isSelected ? red : dustyRose,
          size: size18,
          fontWeight: w600,
        ),
      ),
    );
  }

  Widget dateOfBirthPicker (Screen2Controller controller){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          width: w,
          height: h*0.7,
          child: ScrollDatePicker(

              scrollViewOptions: DatePickerScrollViewOptions(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                day: ScrollViewDetailOptions(selectedTextStyle: GoogleFonts.roboto(
                  color: red,
                  fontSize: size27,
                  fontWeight: FontWeight.w700,
                )),
                month: ScrollViewDetailOptions(selectedTextStyle: GoogleFonts.roboto(
                  color: red,
                  fontSize: size27,
                  fontWeight: FontWeight.w700,
                )),
                year: ScrollViewDetailOptions(selectedTextStyle: GoogleFonts.roboto(
                  color: red,
                  fontSize: size27,
                  fontWeight: FontWeight.w700,
                )),
              ),
              options: DatePickerOptions(
                  backgroundColor:beige,
                  diameterRatio: 40,
                  itemExtent: 100,
                  isLoop: false
              ),
              maximumDate:DateTime.now().subtract(Duration(days: 365*18)  ),
              selectedDate: controller.selectedDateOfBirth.value,
              locale: Locale('en'),
              onDateTimeChanged: (DateTime value) {
                controller.selectedDateOfBirth.value = value;
              }
          ),

        ),


      ],
    );
  }



  Widget chooseGender(Screen2Controller controller) {
    RxString selectedGender = controller.selectedGender;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        SizedBox(height: h * 0.06,width: w,),
//I want it to scale from 0 to 1 like a droplet or bubble

          genderButton(
            controller,
            gender: 'Female',
            image: 'assets/female.png',
          ),

        SizedBox(height: h * 0.04),

          genderButton(
            controller,
            gender: 'Male',
            image: 'assets/male.png',
          ),
      ],
    );
  }
  Widget genderButton(Screen2Controller controller, {required String gender, required String image}) {
    RxBool isPressed = false.obs; // Tracks press state

    return GestureDetector(
      onTapDown: (_) => isPressed.value = true, // Shrink on press
      onTapUp: (_) {
        isPressed.value = false; // Restore size
        controller.selectedGender.value = gender;
        Future.delayed(Duration(milliseconds: 400), () {
          controller.pageIndex.value = 1;
        });
      },
      onTapCancel: () => isPressed.value = false, // Reset if tap is canceled
      child: Obx(() {
        bool isSelected = controller.selectedGender.value == gender;
        return AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: isPressed.value ? w * 0.32 : w * 0.35, // Shrink slightly when pressed
          height: isPressed.value ? w * 0.32 : w * 0.35,
          decoration: BoxDecoration(
            color: isSelected ? red.withOpacity(0.8) : white,
            shape: BoxShape.circle,
            boxShadow: isPressed.value
                ? []
                : [BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 1)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(image, width: w * 0.13),
              SizedBox(height: 5),
              MyText(
                title: gender,
                color: isSelected ? beige : dustyRose,
                size: size16,
                fontWeight: w700,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget selectGoal(Screen2Controller controller) {

    return Container(
      width: w,
      margin: EdgeInsets.only(top: size30,bottom: 100),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(3, (index) {
            return InkWell(
              splashColor: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
        
              onTap: () {
               try{
                 controller.selectedGoal.value = int.parse(controller.goals[index]['value'].toString());
                  print (controller.selectedGoal.value);
               }catch(e){
                 print(e.toString());
               }
                // Future.delayed(Duration(milliseconds: 400), () {
                //   controller.pageIndex.value = 1;
                // });
              },
              child: Obx(() {
                bool selected = controller.selectedGoal.value == (index+1);
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.06,
                    vertical: h * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? red.withOpacity(0.8) : red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    // Add a subtle shadow when selected.
                    boxShadow: !selected
                        ? []
                        : [BoxShadow(color: Colors.black26, blurRadius: 8, spreadRadius: 1)],
                  ),
                  // Slightly scale up the selected container.
                  transform: Matrix4.identity()..scale(selected ? 1.0 : 0.85),
                  transformAlignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(
                              title: controller.goals[index]['title'],
                              size: size20,
                              color: selected? beige:dustyRose,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: h * 0.003),
                            MyTextOverflow(
                              textAlign: TextAlign.left,
                              title: controller.goals[index]['description'],
                              size: size15,
                              color: selected? beige:dustyRose,
                              fontWeight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 8),
                      Image.asset(controller.goals[index]['icon']!, width: 50)
                    ],
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
  Widget selectActivityLevel(Screen2Controller controller) {
    return Container(
      width: w,
      margin: EdgeInsets.only(top: size30,bottom: 100),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(5, (index) {
            return InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                controller.selectedActivityLevel.value = int.parse(controller.activityLevels[index]["value"].toString());
                print(controller.selectedActivityLevel.value);
              },
              child: Obx(() {
                // Use the correct controller property here
                bool selected = controller.selectedActivityLevel.value == (index+1);
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.06,
                    vertical: h * 0.02,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? red.withOpacity(0.8) : red.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: selected
                        ? [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        spreadRadius: 1,
                      )
                    ]
                        : [],
                  ),
                  // Scale the container: selected ones are full size, others slightly smaller.
                  transform: Matrix4.identity()..scale(selected ? 1.0 : 0.85),
                  transformAlignment: Alignment.center,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      index == 0
                          ? SizedBox()
                          : MyText(
                              title: controller.activityLevelTextIcons[index],
                              size: size20,
                              color: selected? beige:dustyRose,
                              fontWeight: FontWeight.w700,
        
                      ),
                      SizedBox(width: size15,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyText(
                              title: controller.activityLevels[index]['title'],
                              size: size20,
                              color:selected?beige: dustyRose,
                              fontWeight: FontWeight.w700,
                            ),
                            SizedBox(height: h * 0.003),
                            SizedBox(
                              width: w * 0.6,
                              child: MyTextOverflow(
                                textAlign: TextAlign.left,
                                title: controller.activityLevels[index]['description'],
                                size: size15,
                                color:selected?beige: dustyRose,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Optionally hide the icon for the first index if needed.
                      index == 0
                          ? SizedBox()
                          : Image.asset(
                        controller.activityLevels[index]['icon']!,
                        width: 50,
                      )
                    ],
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
  Widget selectDietaryPreferences (Screen2Controller controller){
    return Container(
      width: w,
      height: h*0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
      GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
        crossAxisSpacing: size14,
        mainAxisSpacing: size14,
        childAspectRatio: 0.7,
      ),
      itemCount: controller.dietaryPreferences.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (!controller.selectedDietaryPreferences.contains(int.parse(controller.dietaryPreferences[index]['value'].toString()))) {
              controller.selectedDietaryPreferences.add(int.parse(controller.dietaryPreferences[index]['value'].toString()));
            } else {
              controller.selectedDietaryPreferences.remove(int.parse(controller.dietaryPreferences[index]['value'].toString()));
            }
          },
          child: Obx(() {
            bool isSelected = controller.selectedDietaryPreferences.contains((index+1));

            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              // Slightly scale up when selected
              transform: Matrix4.identity()..scale(isSelected ? 1.05 : 0.9),
              transformAlignment: Alignment.center,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: w * 0.28,
                    height: w * 0.28,
                    padding: EdgeInsets.all(size7),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white60, beige, white],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: red, width: 0.5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: Offset(1, 2),
                        )
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        controller.dietaryPreferencesIcons[index],
                        fit: BoxFit.cover
                        ,
                      ),
                    ),
                  ),
                  SizedBox(height: size8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: size8, vertical: size6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: isSelected ? red : Colors.white,
                    ),
                    child: Center(
                      child: MyText(
                        title: controller.dietaryPreferences[index]['title'],
                        size: size12,
                        color: isSelected ? beige : dustyRose,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    ),
        ],
      ),
    );
  }
  Widget selectCuisinePreferences (Screen2Controller controller){
    return Container(
      width: w,
      height: h*0.75,
      child: ListView.builder(
      itemCount: controller.cuisinePreferences.length,
      shrinkWrap: true,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            if (!controller.selectedCuisinePreferences.contains(int.parse(controller.cuisinePreferences[index]['value'].toString()))) {
              controller.selectedCuisinePreferences.add(int.parse(controller.cuisinePreferences[index]['value'].toString()));
            } else {
              controller.selectedCuisinePreferences.remove(int.parse(controller.cuisinePreferences[index]['value'].toString()));
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Obx(() {
            bool isSelected = controller.selectedCuisinePreferences.contains(int.parse(controller.cuisinePreferences[index]['value'].toString()));

            return AnimatedContainer(

              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              // Slightly scale up when selected
              transform: Matrix4.identity()..scale(isSelected ? 1.0 : 0.9),
              transformAlignment: Alignment.center,
              margin: EdgeInsets.only(top: 3,bottom: index == controller.cuisinePreferences.length-1?400:0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Container(
                width: w,
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: size12, vertical: size6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size15),
                  color: isSelected ? red : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3,
                      spreadRadius: 1,
                      offset: Offset(1, 2),
                    )
                  ]
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // MyText(
                    //   title: controller.cuisinePreferences[index]['icon'].toString(),
                    //   size: size23,
                    // ),
                    SizedBox(width: size13,),
                    MyText(
                      title: controller.cuisinePreferences[index]['title'].toString(),
                      size: size18,
                      color: isSelected ? beige : dustyRose,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
          ),
    );
  }
}

class GenderButtonAnimation extends StatefulWidget {
  final Widget child;
  const GenderButtonAnimation({Key? key, required this.child}) : super(key: key);

  @override
  _GenderButtonAnimationState createState() => _GenderButtonAnimationState();
}

class _GenderButtonAnimationState extends State<GenderButtonAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Animation duration can be adjusted as needed.
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );
    // EaseOutBack provides a nice 'bubble' effect.
    _animation = CurvedAnimation(
      reverseCurve: Curves.easeInBack,
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation.drive(CurveTween(curve: Curves.easeIn)),
      child: ScaleTransition(
        
        scale: _animation,
        child: widget.child,
      ),
    );
  }
}
