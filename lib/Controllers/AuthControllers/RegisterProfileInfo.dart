import 'package:animated_weight_picker/animated_weight_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Controllers/OnBoardingControllers/Screen2Controller.dart';
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
import '../../Views/AuthViews/RegisterPage.dart';
import 'VerifyOtpControllerFromRegister.dart';

class RegisterProfileInfo extends StatefulWidget {
  final bool fromRegister;
  const RegisterProfileInfo({super.key,  this.fromRegister = true});

  @override
  State<RegisterProfileInfo> createState() => _RegisterProfileInfoState();
}

class _RegisterProfileInfoState extends State<RegisterProfileInfo> {
  Screen2Controller screen2Controller = Get.put(Screen2Controller());
  VerifyOtpScreenController controller = Get.put(VerifyOtpScreenController());
  final _completeProfileKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   if(widget.fromRegister){
     screen2Controller.getDeviceCountry();
   }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body:Stack(
          children: [
            BgWidget(),
            Container(
              width: w,
              height: h,
              color: beige.withOpacity(0.9),
            ),
            Container(
              width: w,
              height: h,
              child: Padding(
                padding:  EdgeInsets.only(left: w*0.05,right:  w*0.05,top: h*0.08),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: (){
                                  Get.back();
                                },
                                child: Icon(Icons.arrow_back_ios_rounded,color: plumGrey,))
                          ],
                        ),
                        SizedBox(height: h*0.03,),
                        Row(
                          children: [

                            MyText(title: "Your Profile",
                              size: size20,
                              color: dustyRose,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                        SizedBox(height: h*0.01,),
                        LinearProgressIndicator(
                          minHeight: size5,
                          borderRadius: BorderRadius.circular(50),
                          value: 1,
                          backgroundColor: red.withOpacity(0.3),
                          valueColor: AlwaysStoppedAnimation<Color>(red),
                        ),
                        SizedBox(height: h*0.02,),

                        Container(
                          width: w,
                          height: h*0.75,
                          child: Form(
                            key: _completeProfileKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 40,),
                                TextFormField(
                                  onFieldSubmitted: (v)async{

                                  },
                                  onChanged: (v){
                                    screen2Controller.name.value = v;
                                  },
                                  keyboardType: TextInputType.name,
                                  controller: screen2Controller.nameController.value,

                                  validator: (v){
                                    return (v!.isEmpty || v!.length<3) ? 'Please enter a valid name' : null;
                                  },
                                  style: GoogleFonts.roboto(
                                      color: red,
                                      fontSize: size14,
                                      fontWeight: w400
                                  ),
                                  decoration: InputDecoration(
                                      labelText: 'Name',
                                      prefixIcon: Icon(Icons.person,color: red,),
                                      hintStyle: TextStyle(
                                          color: red,
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
                                          borderSide: BorderSide(color: red,width: 1)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: red,width: 1.75)
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: Colors.red,width: 1.75)
                                      )

                                  ),
                                ),
                                if(!widget.fromRegister)    SizedBox(height: 10,),
                                if(!widget.fromRegister)  TextFormField(
                                  onFieldSubmitted: (v) async {},
                                  onChanged: (v) {
                                    screen2Controller.phone.value = v;
                                  },
                                  keyboardType: TextInputType.phone,
                                  controller: screen2Controller.phoneController.value,
                                  validator: (v) {
                                    // Define a regex for a valid phone number
                                    RegExp phoneRegExp = RegExp(r'^\+?[0-9]{10,15}$');
                                    if (v == null || v.isEmpty) {
                                      return 'Please enter a phone number';
                                    } else if (!phoneRegExp.hasMatch(v)) {
                                      return 'Please enter a valid phone number';
                                    }
                                    return null;
                                  },
                                  style: GoogleFonts.roboto(
                                    color: red,
                                    fontSize: size14,
                                    fontWeight: w400,
                                  ),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.phone,color: red,),
                                    hintText: 'Phone',
                                    hintStyle: TextStyle(
                                      color: red,
                                      fontSize: size14,
                                      fontWeight: w400,
                                    ),

                                    disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: dustyRose, width: 1),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.red, width: 1.75),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: red, width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: red, width: 1.75),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide(color: Colors.red, width: 1.75),
                                    ),
                                  ),
                                ),
                                if(!widget.fromRegister)     SizedBox(height: 10,),
                                if(!widget.fromRegister)    TextFormField(
                                  onFieldSubmitted: (v)async{

                                  },
                                  onChanged: (v){
                                    screen2Controller.city.value = v;
                                  },
                                  keyboardType: TextInputType.streetAddress,
                                  controller: screen2Controller.cityController.value,
                                  validator: (v){
                                    return (v!.isEmpty || v!.length<3) ? 'Please enter a valid city' : null;
                                  },
                                  style: GoogleFonts.roboto(
                                    color: red,
                                    fontSize: size14,
                                    fontWeight: w400,
                                  ),
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.location_on,color: red,),
                                      hintText: 'City',
                                      hintStyle: TextStyle(
                                          color: red,
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
                                          borderSide: BorderSide(color: red,width: 1)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: red,width: 1.75)
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(12),
                                          borderSide: BorderSide(color: Colors.red,width: 1.75)
                                      )

                                  ),
                                ),

                                // if(widget.fromRegister)
                                SizedBox(height: 10,),
                                // if(widget.fromRegister)
                                InkWell(
                                    onTap: ()async{
                                      await showModalBottomSheet(
                                      isScrollControlled: true,
                                      isDismissible: true,
                                      enableDrag: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),

                                      ),
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      builder: (context) => Container(
                                        width: w,
                                        height: h*0.85,
                                        padding: EdgeInsets.symmetric(vertical: size20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
                                          color: beige
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.center,

                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                              child: TextFormField(

                                                onChanged: (v){
                                                  screen2Controller.searchCountries(country: v.toLowerCase());
                                                },
                                                keyboardType: TextInputType.name,
                                                controller: screen2Controller.searchCountryController,

                                                validator: (v){
                                                  return (v!.isEmpty || v!.length<3) ? 'Please enter a valid name' : null;
                                                },
                                                style: GoogleFonts.roboto(
                                                    color: red,
                                                    fontSize: size14,
                                                    fontWeight: w400
                                                ),
                                                decoration: InputDecoration(
                                                    labelText: 'Search',
                                                    prefixIcon: Icon(Icons.map,color: red,),
                                                    hintStyle: TextStyle(
                                                        color: red,
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
                                                        borderSide: BorderSide(color: red,width: 1)
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                        borderSide: BorderSide(color: red,width: 1.75)
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                        borderSide: BorderSide(color: Colors.red,width: 1.75)
                                                    )

                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: w,
                                              height: h*0.7,
                                              child: Obx(()=>ListView.builder(itemBuilder: (context,index){

                                                return InkWell(
                                                  onTap: (){
                                                    screen2Controller.countryString.value = screen2Controller.filteredCountries.value[index]['name'] as String;
                                                    screen2Controller.country.value = screen2Controller.filteredCountries.value[index]['id'] as int;
                                                    Get.back();
                                                    print(screen2Controller.country.value);
                                                  },
                                                  child: Container(
                                                    width: w,
                                                    height: 80,
                                                    margin: EdgeInsets.symmetric(horizontal: w*0.03,vertical: size10),
                                                    padding: EdgeInsets.symmetric(horizontal: size14, vertical: size6),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(size15),
                                                        color:white,
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

                                                        SizedBox(width: size13,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            MyText(
                                                              title:

                                                              screen2Controller.filteredCountries.value[index]['name'].toString(),
                                                              size: size15,
                                                              color:  dustyRose,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },itemCount: screen2Controller.filteredCountries.length,),)
                                            ),
                                          ],
                                        ),
                                      ),
                                      );
                                    },
                                    child: Obx(()=>TextFormField(
                                      onFieldSubmitted: (v)async{

                                      },
                                      onChanged: (v){
                                      },
                                      keyboardType: TextInputType.streetAddress,
                                      validator: (v){
                                      },

                                      decoration: InputDecoration(
                                          prefixIcon: Icon(Icons.map,color:   red,),
                                          hintText: screen2Controller.countryString.value.isEmpty
                                              ? screen2Controller.countries
                                              .firstWhere(
                                                (v) => v['id'] == screen2Controller.country.value,
                                            orElse: () => {'name': 'Select Country'},
                                          )['name']
                                              .toString()
                                              : screen2Controller.countryString.value,
                                          // hintText: screen2Controller.country.value.toString(),
                                          hintStyle: TextStyle(
                                              color: red,
                                              fontSize: size14,
                                              fontWeight: w600
                                          ),
                                          enabled: false,
                                          suffixIcon: Icon(Icons.arrow_drop_down,color:   black ,),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(12),
                                              borderSide: BorderSide(color: red,width: 1)
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
                                    ),)
                                ),

                                SizedBox(height: 30,),
                                Spacer(),


                              ],
                            ),
                          ),
                        )
                      ],
                    ),


                    Obx(()=>
                    controller.isLoading.value?
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                          width: w,
                          height: 60,
                          margin: EdgeInsets.only(bottom: h * 0.02),
                          child: Center(child: CupertinoActivityIndicator())),
                    ):
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: ()async{
                          try{
                            // String? fcmToken = await FirebaseMessaging.instance.getToken();
                            if(screen2Controller.cmInchFeet.value == 'ft'){
                              screen2Controller.cmInchFeet.value = 'in';
                            }
                            // final Map<String, dynamic> payload = {
                            //   'cuisinePreferences':screen2Controller.selectedCuisinePreferences.value,
                            //   'country': screen2Controller.country.value, // Assuming you need to add this field
                            //   'dateOfBirth': screen2Controller.selectedAge.value, // Ensure valid date format
                            //   'gender': screen2Controller.selectedGender.value.toLowerCase(), // Send gender as string
                            //   'height': screen2Controller.selectedHeight.value, // Send as int
                            //   "heightUnit": screen2Controller.cmInchFeet.value,
                            //   "weightUnit": screen2Controller.kgLbs.value,
                            //   'weight': screen2Controller.selectedWeight.value, // Send as double
                            //   'goal': screen2Controller.selectedGoal.value, // Use the validated goal value
                            //   'activityLevel': (screen2Controller.selectedActivityLevel.value) ?? 1, // Keep as int
                            //   'dairyPreferences': screen2Controller.selectedDietaryPreferences.value, // Send List as-is
                            //   'name': screen2Controller.name.value,
                            //   'city': screen2Controller.city.value,
                            //   'phone':screen2Controller.phone.value,
                            //   'notificationToken':fcmToken??''
                            // };
                            // print(
                            //     payload
                            //
                            // );
                            if(_completeProfileKey.currentState!.validate()){
                              screen2Controller.name.value = screen2Controller.nameController.value.text;
                              screen2Controller.city.value = screen2Controller.cityController.value.text;
                              screen2Controller.phone.value = screen2Controller.phoneController.value.text;
                              if(widget.fromRegister){
                                print("Widget.fromregister: "+widget.fromRegister.toString());

                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  isDismissible: true,
                                  enableDrag: true,
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (context) => RegisterPage(name: screen2Controller.nameController.value.text.toString(),),
                                );
                              }
                              else{
                                await controller.patchUserProfile();
                              }

                            }
                          }catch(e){
                            print(e.toString());
                          }
                        },
                        child: Container(
                          width: w,
                          height: 60,
                          margin: EdgeInsets.only(bottom: h * 0.02),
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
                      ),)
                    )





                  ],
                ),
              ),
            )
          ],
        )
    );
  }

}

