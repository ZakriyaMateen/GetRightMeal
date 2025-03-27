import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Views/AppViews/HomeScreen.dart';
import 'package:getrightmealnew/Views/AppViews/ProfileScreen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../../Constants/fontWeights.dart';
import '../../Controllers/AppControllers/BottomNavBarController/BottomNavBarController.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../../Controllers/AppControllers/BottomNavBarController/BottomNavBarController.dart';
import '../../main.dart';
import '../AppViews/HomeScreen.dart';
import '../AppViews/ProfileScreen.dart';

class CustomNavBar extends StatelessWidget {
  final CustomNavBarController navBarController = Get.put(CustomNavBarController());

  final List<Widget> screens = [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: beige,
      body: Obx(() => screens[navBarController.pageIndex.value]),
      bottomNavigationBar: Obx(() => Container(
        width: w,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(1, 2),
                spreadRadius: 1,
                blurRadius: 3,
              ),
            ],
            border: Border(top: BorderSide(color: Colors.white,width: 1))),
        child: BottomNavigationBar(

          elevation: 5,
          useLegacyColorScheme: true,
          backgroundColor: beige,
          selectedItemColor: red,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: plumGrey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: size14,
          unselectedFontSize: size14,
          selectedLabelStyle: GoogleFonts.roboto(
            fontSize: size14,
            fontWeight: w600,
            color: red,
          ),
          unselectedLabelStyle: GoogleFonts.roboto(
            fontSize: size14,
            fontWeight: w600,
            color: plumGrey,
          ),
          currentIndex: navBarController.pageIndex.value,
          onTap: (index) {
            navBarController.setPageIndex(index);
          },
          items: [
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding:  EdgeInsets.only(bottom: 6),
                child: Image.asset('assets/mealPlanIcon.png',width: 22,height: 22,color: red,),
              ),
              icon: Padding(
                padding:  EdgeInsets.only(bottom: 6),
                child: Image.asset('assets/mealPlanIcon.png',width: 22,height: 22,color: plumGrey,),
              ),
              label: 'Meal Plans',


            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding:  EdgeInsets.only(bottom: 6),
                child: Image.asset('assets/profileIcon.png',width: 22,height: 22,color: red,),
              ),
              icon: Padding(
                padding:  EdgeInsets.only(bottom: 6),
                child: Image.asset('assets/profileIcon.png',width: 22,height: 22,color: plumGrey,),
              ),
              label: 'Profile',
            ),

          ],
        ),
      )),
    );
  }
}



class CustomNavBarController extends GetxController {
  var pageIndex = 0.obs;

  void setPageIndex(int index) {
    pageIndex.value = index;
  }
}
