import 'dart:async';
import 'dart:math';

import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Controllers/AuthControllers/LoginPageController.dart';
import 'package:getrightmealnew/Controllers/AuthControllers/VerifyOtpControllerFromRegister.dart';
import 'package:getrightmealnew/Views/AppViews/EditProfileScreen.dart';
import 'package:getrightmealnew/Views/AppViews/Webview/webviewScreen.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

import '../../Constants/Colors.dart';
import '../../Controllers/AppControllers/MealScheduleController.dart';
import '../../Controllers/ProfileScreenController.dart';
import '../../Widgets/DashedLine.dart';
import '../../Widgets/Drawer.dart';
import '../../constants/Gradients.dart';
import '../../constants/Sizes.dart';
import '../../constants/fontWeights.dart';
import '../../main.dart';
import '../../widgets/Text.dart';
import 'ContactUsScreen.dart';
import 'CustomNavBar.dart';
import 'PrivacyPolicy.dart';
import 'RateUsScreen.dart';
import 'TermsAndConditions.dart';





class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
final scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {

  MealScheduleController controller = Get.put(MealScheduleController());
  Future<void> cache(context)async{
   await precacheImage(AssetImage('assets/onboarding2.jpg'), context);
   await precacheImage(AssetImage('assets/onboarding5.jpg'), context);
   await precacheImage(AssetImage('assets/onboarding3.jpg'), context);
  }
  String image1 = 'https://images.unsplash.com/photo-1482049016688-2d3e1b311543?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTZ8fGZvb2R8ZW58MHx8MHx8fDA%3D';
  String image2 = 'https://images.unsplash.com/photo-1447078806655-40579c2520d6?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGZvb2R8ZW58MHx8MHx8fDA%3D';
  String image3 = 'https://media.istockphoto.com/id/2166415697/photo/food-products-representing-the-mind-diet.webp?a=1&b=1&s=612x612&w=0&k=20&c=ukOEr1LdFMAs7k_HcnQdvmGjyZUrpoRVude9fnKXl8g=';
  ScrollController _scrollController = ScrollController();
  RxBool showUserName = false.obs;
   PageController scrollController = PageController(viewportFraction: 1);
  late Timer _timer = Timer(Duration.zero, () {});
  late FancyDrawerController drawerController;

  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    drawerController = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
    _scrollController.addListener(() {
    });
    _scrollController.addListener((){
      if(_scrollController.offset>38){
        showUserName.value = true;
      }else{
        showUserName.value = false;
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
    });
  }
  void _startAutoScroll() {
    Future.delayed(Duration(seconds: 1), () async {
      _timer = Timer.periodic(Duration(seconds: 3), (timer) {
        if (scrollController.page!.round() == 3 - 1) {
          // Animate back to the first page
          scrollController.animateToPage(
            0,
            duration: Duration(seconds: 1), // Shorter duration for smooth looping
            curve: Curves.easeInOut,
          );
        } else {
          // Move to the next page
          scrollController.nextPage(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }
  @override
  void dispose() {
    _timer?.cancel();
    scrollController.dispose();
    _scrollController.dispose();
    drawerController.dispose();
    super.dispose();
  }
  void showImprovementDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: MyText(title: 'App Improvements',color: dustyRose,fontWeight: w700,size: size17,),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextOverflow(textAlign:TextAlign.center,title: 'We would love to hear your thoughts on improving the app!',color: dustyRose,fontWeight: w500,size: size15,),
              SizedBox(height: 8,),
              CupertinoTextField(
                cursorColor: dustyRose, // Custom cursor color
                placeholder: 'Your feedback...',
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Custom padding
                style: TextStyle(
                  color: plumGrey, // Text color
                  fontSize: 14.0, // Font size
                ),
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(12.0), // Rounded corners
                  border: Border.all(
                    color: dustyRose, // Border color
                    width: 1.5, // Border width
                  ),
                ),
                placeholderStyle: TextStyle(
                  color: Colors.grey, // Placeholder text color
                  fontSize: 14.0, // Placeholder font size
                ),
                minLines: 1, // Minimum lines (height starts small)
                maxLines: null, // No limit to the number of lines
              )

            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: MyText(title:'Cancel',color: plumGrey,fontWeight: w500,size: size16,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: MyText(title:'Submit',color: red,fontWeight: w600,size: size16,),
              onPressed: () {
                // Handle the feedback submission logic here
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 100,
      padding: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: plumGrey.withOpacity(0.5), width: 0.4)),
      ),
      child: ListTile(dense: true,
        contentPadding: EdgeInsets.only(left: 10),
        minTileHeight: 40,
        minVerticalPadding: 0,
        horizontalTitleGap: 10,

        leading: FaIcon(icon, color: plumGrey,size: icon == CupertinoIcons.home?size24:size22,), // Font Awesome Icon
        title: MyText(
          textAlign: TextAlign.left,
          title: title,
          fontWeight: w600,
          size: size15,
          color: plumGrey,
        ),
        onTap: onTap,
      ),
    );
  }
  Widget _buildLogoutItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),

      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: plumGrey.withOpacity(0.5), width: 0.4)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 10),
        minTileHeight: 40,
        minVerticalPadding: 0,
        horizontalTitleGap: 10,
        leading: FaIcon(icon, color: red), // Font Awesome Icon
        title: MyText(
          textAlign: TextAlign.left,
          title: title,
          fontWeight: w600,
          size: size17,
          color: red,
        ),
        onTap: onTap,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
   cache(context);

    double w = MediaQuery.of(context).size.width;

    return FancyDrawerWrapper(
      drawerPadding: EdgeInsets.only(right: w*0.3,left: w*0.02),
      hideOnContentTap: true,
      cornerRadius: 20,
      itemGap: 0,
      backgroundColor: beige,

      drawerItems: [
        // Drawer Header with Logo, App Name, and Tagline
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 60,
              width: 60,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            MyText(
              title: 'Get Right Meal',
              fontWeight: w700,
              size: size20,
              color: black,
            ),
            const SizedBox(height: 0),
            MyText(
              title: 'Meals That Matter',
              size: size16,
              color: dustyRose,
              fontWeight: w500,
            ),
          ],
        ),
        SizedBox(height: 30,),
        // Menu Options
        _buildDrawerItem(
          icon: CupertinoIcons.home, // Home Icon
          title: 'Home',
          onTap: () {

            final CustomNavBarController navBarController = Get.find<CustomNavBarController>();
            navBarController.setPageIndex(0);
            drawerController.close();

            // scaffoldKey.currentState!.closeEndDrawer();
          },
        ),
        _buildDrawerItem(
          icon: FontAwesomeIcons.user, // Profile Icon
          title: 'Profile',
          onTap: () {
            final CustomNavBarController navBarController = Get.find<CustomNavBarController>();
            navBarController.setPageIndex(1);
            drawerController.close();
          },
        ),
        // _buildDrawerItem(
        //   icon: FontAwesomeIcons.penToSquare, // Edit Profile Icon
        //   title: 'Edit Profile',
        //   onTap: () {
        //     drawerController.close();
        //     Get.to(() => EditProfileScreen(), transition: Transition.rightToLeftWithFade);
        //   },
        // ),
        _buildDrawerItem(
          icon: FontAwesomeIcons.shieldAlt, // Privacy Policy Icon
          title: 'Privacy Policy',
          onTap: ()async {
             await Get.to(() => WebViewScreen(url: "https://getrightmeal.com//privacy-policy.html"), transition: Transition.rightToLeftWithFade);
             drawerController.close();

          },
        ),
        _buildDrawerItem(
          icon: FontAwesomeIcons.fileLines, // Terms and Conditions Icon
          title: 'Terms and Conditions',
          onTap: ()async {
            await Get.to(() => WebViewScreen(url: "https://getrightmeal.com//terms-and-conditions.html"), transition: Transition.rightToLeftWithFade);

            drawerController.close();
          },
        ),
        _buildDrawerItem(
          icon: FontAwesomeIcons.envelope, // Contact Us Icon
          title: 'Help and Support',
          onTap: ()async {
           await Get.to(() => ContactUsScreen(), transition: Transition.rightToLeftWithFade);
           drawerController.close();
          },
        ),
        // _buildDrawerItem(
        //   icon: FontAwesomeIcons.star, // Rate Us Icon
        //   title: 'Rate Us',
        //   onTap: () {
        //     drawerController.close();
        //     Get.to(() => RateUsScreen(), transition: Transition.rightToLeftWithFade);
        //   },
        // ),
        _buildLogoutItem(
          icon: FontAwesomeIcons.signOut, // Rate Us Icon
          title: 'Logout',
          onTap: ()async {
            await ProfileScreenController().logout();

          },
        ),

      ],
      controller: drawerController,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: beige,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                snap: true,
                stretch: true,
                expandedHeight: 90, // Initial height of AppBar
                floating: true,
                pinned: true,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    // Calculating opacity based on scroll
                    double percent = (constraints.maxHeight - kToolbarHeight) / (90 - kToolbarHeight);
                    double opacity = percent.clamp(0.0, 1.0);
                    print(percent);
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            red.withOpacity(0.8 * opacity), // Opacity decreases
                            red.withOpacity(0.4 * opacity),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://images.pexels.com/photos/1323550/pexels-photo-1323550.jpeg?auto=compress&cs=tinysrgb&w=1200',
                          ),
                          fit: BoxFit.cover,
                          opacity: 0.3 * opacity, // Image opacity decreases
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  drawerController.percentOpen > 0 ? Icons.close : Icons.menu,
                                  color: Colors.white.withOpacity(opacity), // Icon fades out
                                ),
                                onPressed: drawerController.percentOpen > 0 ? null : () {
                                  drawerController.toggle();
                                },
                              ),
                              SizedBox(width: 10),
                              Obx(() => Opacity(
                                opacity: opacity, // Text fades out
                                child: showUserName.value
                                    ? Obx(() {
                                  String dateString = controller.meals[controller.selectedIndex.value].date;
                                  DateTime date = DateFormat('dd-MM-yyyy').parse(dateString);
                                  String formattedDate = DateFormat('MMM d y').format(date);
                                  return MyText(
                                    title: formattedDate,
                                    color: Colors.white,
                                    fontWeight: w700,
                                    size: size20,
                                  );
                                })
                                    : MyText(
                                  title: 'Meal Schedule',
                                  fontWeight: w700,
                                  size: size20,
                                  color: Colors.white,
                                ),
                              )),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ];
          },
          body: Obx(()=>controller.isLoading.value?
        Center(child: CupertinoActivityIndicator(),):
        LiquidPullToRefresh(
          animSpeedFactor: 1,
          color: red,
          onRefresh: () async {
            await  controller.fetch();
          },

          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25,),

                Obx(() {
                  String dateString = controller.meals[controller.selectedIndex.value].date;
                  DateTime date = DateFormat('dd-MM-yyyy').parse(dateString);
                  String formattedDate = DateFormat('MMM d y').format(date);
                  return MyText(title: formattedDate,color: dustyRose,fontWeight: w600,size: size22,);
                }),

                SizedBox(height:10,),
                Container(
                  height: 95, // Adjust the height as per your needs
                  alignment: Alignment.center,
                  child: Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.meals.length,
                      itemBuilder: (context, index) {
                        final date = extractDate(controller.meals[index].date);
                        final day = controller.meals[index].day.substring(0,3);

                        return GestureDetector(
                          onTap: () {
                            controller.selectDate(index); // Update selected index
                          },
                          child: Obx(()=>Container(
                            width: 70, // Adjust width if needed
                            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 5),
                            decoration: BoxDecoration(
                                gradient: controller.selectedIndex.value == index ? blueGradient : null,
                                color: controller.selectedIndex.value != index ? Color(0xfff2f2f2f2) : null,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: plumGrey.withOpacity(0.2),
                                      offset: Offset(1, 1),
                                      spreadRadius: 1,
                                      blurRadius: 2
                                  ),
                                ]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyText(
                                  title: date, // Day (Mon, Tue, etc.)
                                  color: controller.selectedIndex.value == index ? white : plumGrey,
                                  fontWeight: w400,
                                  size: size17,
                                ),
                                SizedBox(height: 2),
                                MyText(
                                  title: day, // Date (01, 02, etc.)
                                  color: controller.selectedIndex.value == index ? white : plumGrey,
                                  fontWeight: w700,
                                  size: size16,
                                ),
                              ],
                            ),
                          )),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Banners(pageController: scrollController,),
                SizedBox(height: 20,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      // mealHeadingRow('Breakfast'),
                      SizedBox(height: 10,),
                      foodContainer(
                          Color(
                              0xffa16748),
                          "🍳",
                          image1,controller.meals[controller.selectedIndex.value].meals.breakfast,w,"Breakfast",Color(
                          0xfffad7c4)),

                      // ListView.builder(itemBuilder: (context,index){
                      // },shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemCount: 1,),



                      // SizedBox(height: 14,),
                      // mealHeadingRow('Lunch'),
                      foodContainer(
                          Color(
                              0xffb86996),
                          "🍲",
                          image2,controller.meals[controller.selectedIndex.value].meals.lunch,w,"Lunch",Color(
                          0xfff6dfec)),
                      // SizedBox(height: 14,),

                      // mealHeadingRow('Dinner'),
                      foodContainer(
                          Color(0xff64a65d),
                          "🥘",
                          image3,controller.meals[controller.selectedIndex.value].meals.dinner,w,"Dinner",Color(
                          0xffe3f6e1)),
                      SizedBox(height: 14,),

                      // mealHeadingRow('Today Meal Nutritions'),
                      // SizedBox(height: 10,),
                      // ListView.builder(itemBuilder: (context,index){
                      //   return foodContainer('clockIcon.png', 'Honey Pancake','07:00am');
                      // },shrinkWrap: true,physics: NeverScrollableScrollPhysics(),itemCount: 2,),
                      // SizedBox(height: 15,),

                    ],
                  ),
                ),
              ],
            ),
          ),
        )

        ),)
      ),
    );
  }

  String extractDate(String dateString){
    // Define the format of the input date string
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    // Parse the string into a DateTime object
    DateTime dateTime = dateFormat.parse(dateString);

    // Extract the day
    return dateTime.day.toString();
  }




  Widget foodContainer(
      Color eatingColor,
      String icon,
      String imageUrl, String title, double containerWidth, String eating, Color backgroundColor) {
    return Padding(
      padding: const EdgeInsets.symmetric( vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(right: size8,top: size3),
                decoration: BoxDecoration(
                  color: backgroundColor.withOpacity(0.9),
                  shape: BoxShape.circle,
                  // border: Border.all(color: plumGrey, width: 0.3)
                ),
                child: Center(
                  child: MyText(
                    size: size25,
                    title:icon,
                  ),
                ),
              ),
              SizedBox(height: 4,),
              eating=='Dinner'?Container():
              Container(
                child: DashedLineVertical(
                  height: 125-20-25, // total height of the dashed line
                  dashWidth: 2,
                  dashHeight: 5, // adjust as needed
                  gap: 2, // adjust as needed
                  color: plumGrey.withOpacity(0.3),
                ),
              ),
            ],
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    offset: const Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Image section on the left

                  // Text section
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            title:
                            eating,
                            size: size17,
                            color: eatingColor,
                            fontWeight: w700,
                          ),
                          const SizedBox(height: 6),
                          MyTextOverflow(
                            title:
                            "Eat " + title,
                           size: 14,
                            fontWeight: w500,
                            color: red,
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: FancyShimmerImage(
                      imageUrl: imageUrl,
                      width: 120,
                      height: 125,
                      boxFit: BoxFit.cover,
                      shimmerDuration: const Duration(seconds: 2),
                      errorWidget: Icon(Icons.error, size: 50, color: Colors.redAccent),
                    ),
                  ),
                  // Accent side bar with rotated text
                  // Container(
                  //   width: 30,
                  //   height: 125,
                  //   decoration: BoxDecoration(
                  //     color: red,
                  //     borderRadius: const BorderRadius.only(
                  //       topRight: Radius.circular(15),
                  //       bottomRight: Radius.circular(15),
                  //     ),
                  //   ),
                  //   child: Center(
                  //     child: RotatedBox(
                  //       quarterTurns: 1,
                  //       child: Text(
                  //         'Get Right Meal',
                  //         style: const TextStyle(
                  //           fontSize: 10,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget mealHeadingRow(String title){

    return
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
            title: title,
            color: black,
            fontWeight: w600,
            size: size15,
          ),
        ],
      );
  }



}


class Banners extends StatelessWidget {
  final PageController pageController;
  final PageController _pageController = PageController();

   Banners({super.key, required this.pageController});

    List<String> imageUrls = [
        'https://images.pexels.com/photos/16221037/pexels-photo-16221037/free-photo-of-french-fries-fried-chicken-and-drinks-in-cups-on-a-table.jpeg?auto=compress&cs=tinysrgb&w=800'
      ,
      'https://images.pexels.com/photos/30081135/pexels-photo-30081135/free-photo-of-gourmet-artichoke-and-sweet-potato-dish-on-plate.jpeg?auto=compress&cs=tinysrgb&w=800',
    'https://media.istockphoto.com/id/2166415697/photo/food-products-representing-the-mind-diet.webp?a=1&b=1&s=612x612&w=0&k=20&c=ukOEr1LdFMAs7k_HcnQdvmGjyZUrpoRVude9fnKXl8g='
    ];

  RxInt index = 0.obs;
  @override
  Widget build(BuildContext context) {
    return                                       Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            height: 120,
            child:
            Center(
              child: PageView.builder(
                  allowImplicitScrolling: true,
                  padEnds: true,
                  pageSnapping: true,
                  onPageChanged: (i){
                    index.value = i;
                  },
                  dragStartBehavior: DragStartBehavior.down,
                  clipBehavior: Clip.antiAlias,
                  hitTestBehavior: HitTestBehavior.deferToChild,

                  // shrinkWrap: true,
                  controller: pageController,
                  scrollDirection: Axis.horizontal,

                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder:
                      (BuildContext context, int index) {
                    return InkWell(
                      onTap:(){
                      },
                      child: Container(
                        margin: EdgeInsets.only(left:10,right:10,bottom: 5,top: 5),
                        width: double.infinity, // Full width
                        // height: 90,
                        decoration: BoxDecoration(
                          color: red.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: plumGrey.withOpacity(0.3),
                              offset: Offset(1, 1 ),
                              blurRadius: 1,
                              spreadRadius: 2
                            )
                          ]
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: FancyShimmerImage(
                            imageUrl: imageUrls[index], // Network image URL
                            boxFit: BoxFit.cover,
                            shimmerDuration: Duration(seconds: 3), // Shimmer duration
                            errorWidget: Icon(Icons.health_and_safety_outlined,size: 50,color: dustyRose,),
                          ),
                        ),
                      ),
                    );

                  }),
            )

        ),
        SizedBox(height: 8,),
        Container(

          width: w,
          height: 12,

          child: Center(
            child: ListView.builder(
              itemBuilder: (context,i){
              return Obx(()=>


                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 2),
                    width:index.value == i?12: 8,
                    height:index.value == i?12: 8,
                    decoration: BoxDecoration(
                      color: index.value == i?red:plumGrey.withOpacity(0.8),
                      shape: BoxShape.circle
                    ),
                  )
              );
            },itemCount: 3,shrinkWrap: true,scrollDirection: Axis.horizontal,),
          ),
        ),

      ],
    );

  }
}