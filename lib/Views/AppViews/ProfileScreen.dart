import 'package:fancy_drawer/fancy_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Controllers/OnBoardingControllers/Screen2Controller.dart';
import 'package:getrightmealnew/Views/AppViews/AboutUs.dart';
import 'package:getrightmealnew/Views/AppViews/HelpAndSupport.dart';
import '../../Constants/Colors.dart';
import '../../Constants/Gradients.dart';
import '../../Controllers/ProfileScreenController.dart';
import '../../Widgets/Drawer.dart';
import '../../Widgets/NoDataFoundWidget.dart';
import '../../constants/Sizes.dart';
import '../../constants/fontWeights.dart';
import '../../main.dart';
import '../../widgets/Text.dart';
import 'ContactUsScreen.dart';
import 'CustomNavBar.dart';
import 'EditProfileScreen.dart';
import 'HomeScreen.dart';
import 'PrivacyPolicy.dart';
import 'RateUsScreen.dart';
import 'TermsAndConditions.dart';
import 'UserProfileScreen.dart';
import 'Webview/webviewScreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  late FancyDrawerController drawerController;
  Screen2Controller screen2controller = Get.put(Screen2Controller());
  ProfileScreenController controller = Get.put(ProfileScreenController());


  final scaffoldKey = GlobalKey<ScaffoldState>();
  ScrollController _scrollController = ScrollController();
  RxBool showUserName = false.obs;
  @override
  void initState() {

    print(controller.userProfileModel.toString());
    drawerController = FancyDrawerController(
        vsync: this, duration: Duration(milliseconds: 250))
      ..addListener(() {
        setState(() {});
      });
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
    });
    _scrollController.addListener((){
      if(_scrollController.offset>38){
        showUserName.value = true;
      }else{
        showUserName.value = false;
      }
    });
    // controller.fetchProfile();
    WidgetsBinding.instance.addPostFrameCallback((v)async{
      await controller.fetchProfile();
    });

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    drawerController.dispose();

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
    double w = MediaQuery.of(context).size.width;
    return FancyDrawerWrapper(
      drawerPadding: EdgeInsets.only(right: w*0.3,left: w*0.02),
      hideOnContentTap: true,
      cornerRadius: 20,
      itemGap: 0,
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
          onTap: () async{
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
        //   icon: FontAwesomeIcons.envelope, // Contact Us Icon
        //   title: 'Contact Us',
        //   onTap: () {
        //     drawerController.close();
        //     Get.to(() => ContactUsScreen(), transition: Transition.rightToLeftWithFade);
        //   },
        // ),
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
      backgroundColor: beige,

      controller: drawerController,
      child: Scaffold(

        key: scaffoldKey,
        backgroundColor: beige,
        // endDrawer: CustomDrawer(scaffoldKey: scaffoldKey,),
        // appBar: AppBar(
        //     leading: IconButton(
        //       icon: Icon(
        //         drawerController.percentOpen>0?Icons.close: Icons.menu,
        //         color: black,
        //       ),
        //       onPressed: drawerController.percentOpen>0?null: () {
        //         print(
        //             drawerController.percentOpen>0? 'open':'not opened'
        //
        //         );
        //         drawerController.toggle();
        //       },
        //     ),
        //   bottom: PreferredSize(
        //       preferredSize: const Size.fromHeight(0.5),
        //       child: Container(
        //         color: plumGrey,
        //         height: 0.5,
        //       )),
        //
        //   forceMaterialTransparency: true,
        //   automaticallyImplyLeading: true,
        //   backgroundColor: Colors.white,
        //   elevation: 5,
        //   centerTitle: true,
        //   title: Obx(()=>
        //   showUserName.value?
        //
        //   MyText(
        //     title: controller.userProfileModel.value!.name??'Profile',
        //     fontWeight: w700,
        //     size: size18,
        //     color: black,
        //   ):
        //   MyText(
        //     title: 'Profile',
        //     fontWeight: w700,
        //     size: size18,
        //     color: black,
        //   ),
        //   )
        // ),
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
                                  drawerController.percentOpen>0?Icons.close: Icons.menu,
                                  color: white,
                                ),
                                onPressed: drawerController.percentOpen>0?null: () {
                                  print(
                                      drawerController.percentOpen>0? 'open':'not opened'

                                  );
                                  drawerController.toggle();
                                },
                              ),
                              SizedBox(width: 10),
                               Obx(()=>
                              showUserName.value?

                              MyText(
                                title: controller.userProfileModel.value!.name??'Profile',
                                fontWeight: w700,
                                size: size20,
                                color: white,
                              ):
                              MyText(
                                title: 'Profile',
                                fontWeight: w700,
                                size: size20,
                                color: white,
                              ),)

                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ];
          }, body: Obx(()=>


        controller.isLoading.value?


        Center(child:CupertinoActivityIndicator()):
        controller.isNullValue.value?
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SizedBox(width: w,),
            GestureDetector(
                onTap: ()async{
                  Get.to(()=>EditProfileScreen(),transition: Transition.rightToLeftWithFade);
                },
                child: NoDataFoundWidget()),

          ],
        ):

        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding:  EdgeInsets.only(left: Get.width*0.05,right: Get.width*0.05,),
                child: Column(
                  children: [
                    SizedBox(height: 20,),
                    profileRow(),
                    SizedBox(height: 20,),
                    ViewFullProfile(w),

                    // accountCard(w),
                    // notificationCard(w),
                    SizedBox(height: 20,),

                    otherCard(w),
                    SizedBox(height: 20,),

                    // SizedBox(height: 100,),
                    // Obx(()=>
                    // controller.isLoading.value?
                    // CupertinoActivityIndicator():
                    // InkWell(
                    //   onTap: ()async{
                    //     await controller.logout();
                    //   },
                    //   child: Container(
                    //     width: w,
                    //     height: 45,
                    //     decoration: BoxDecoration(
                    //         boxShadow: [
                    //           BoxShadow(
                    //               color: plumGrey.withOpacity(0.5),
                    //               offset: Offset(1, 2),
                    //               spreadRadius: 1,
                    //               blurRadius: 3
                    //           ),
                    //         ],
                    //         borderRadius: BorderRadius.circular(50),
                    //         gradient: LinearGradient(
                    //             begin: Alignment.topCenter,
                    //             end: Alignment.bottomCenter,
                    //             colors: [
                    //               red.withOpacity(0.6),red.withOpacity(0.8),red,
                    //             ])
                    //     ),
                    //     child: Center(
                    //       child: MyText(
                    //         title: 'Logout',
                    //         fontWeight: w700,
                    //         size: size16,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // )
                    // )
                  ],
                ),
              ),



            ],
          ),
        )),)
      ),
    );
  }

  Widget ViewFullProfile(double w){
    return
      InkWell(
        onTap: (){
          Get.to(()=>UserProfileScreen(userProfile: controller.userProfileModel.value!,),transition: Transition.rightToLeftWithFade);
        },
        child: Container(
          width: w,
          decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: plumGrey.withOpacity(0.3),
                    offset: Offset(1, 2),
                    spreadRadius: 1,
                    blurRadius: 3
                ),
              ]
          ),
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.account_circle_rounded
                        ,color: red,size: size28,),
                      MyText(
                        title: '  View Full Profile',
                        color: red,
                        size: size17,
                        fontWeight: w700,
                      ),
                    ],
                  ),
                      Icon(Icons.arrow_forward_ios,color: plumGrey,size: 15,)

                ],
              ),

            ],
          ),

        ),
      )
    ;
  }

  Widget otherCard(double w){
    return
      Container(
        width: w,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: plumGrey.withOpacity(0.2),
                  offset: Offset(1, 2),
                  spreadRadius: 1,
                  blurRadius: 3
              ),
            ]
        ),
        padding: EdgeInsets.only(top: 15,bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Padding(
            //   padding:  EdgeInsets.only(left: 15,),
            //   child: MyText(
            //     title: 'Other',
            //     size: size15,
            //     color: black,
            //     fontWeight: w600,
            //   ),
            // ),
            // SizedBox(height: 12,),
            buildTile(icon: "💬", title: 'Help and Support', onTap: () {
              Get.to(() => ContactUsScreen(), transition: Transition.rightToLeftWithFade);
            }),
            buildTile(icon: "📝", title: 'Terms and Conditions', onTap: () {
              Get.to(() => WebViewScreen(url: "https://getrightmeal.com//terms-and-conditions.html"), transition: Transition.rightToLeftWithFade);
            }),
            buildTile(icon: "🔏", title: 'Privacy Policy', onTap: () {
              Get.to(() => WebViewScreen(url: "https://getrightmeal.com//privacy-policy.html"), transition: Transition.rightToLeftWithFade);

            }),

            // buildTile(icon: Icons.feedback_outlined, title: 'Feedback', onTap: () { showImprovementDialog(context); }),
            // buildTile(icon: Icons.info_outline, title: 'About Us', onTap: () { Get.to(()=>AboutUsScreen(),transition: Transition.rightToLeftWithFade);  }),
            // buildTile(icon: CupertinoIcons.question_circle, title: 'Help & Support', onTap: () {  Get.to(()=>HelpAndSupportScreen(),transition: Transition.rightToLeftWithFade); }),
            logoutTile(icon: Icons.logout, title: 'Logout', onTap: () async{
              await controller.logout();

            }),



          ],
        ),

      )
    ;
  }

  Widget accountCard(double w){
    return
      Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        color: white,
        elevation: 5.0,
        child: Container(
          width: w,
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                title: 'Account',
                size: size15,
                color: black,
                fontWeight: w600,
              ),
              SizedBox(height: 12,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Get.to(()=>UserProfileScreen(userProfile: controller.userProfileModel.value!,));
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/profileScreenAccountIcon1.png',width: 18,height: 18,),
                        SizedBox(width: 5,),
                        MyText(
                          title: 'Personal Data',
                          color: plumGrey,
                          fontWeight: w400,
                          size: 11,
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios,color: plumGrey,size: 15,)
                ],
              ),
              SizedBox(height: 4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/profileScreenAccountIcon2.png',width: 18,height: 18,),
                      SizedBox(width: 5,),
                      MyText(
                        title: 'Achievement',
                        color: plumGrey,
                        fontWeight: w400,
                        size: 11,
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,color: plumGrey,size: 15,)
                ],
              ),
              SizedBox(height: 4,),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/profileScreenAccountIcon3.png',width: 18,height: 18,),
                      SizedBox(width: 5,),
                      MyText(
                        title: 'Activity History',
                        color: plumGrey,
                        fontWeight: w400,
                        size: 11,
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,color: plumGrey,size: 15,)
                ],
              ),
              SizedBox(height: 4,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/profileScreenAccountIcon4.png',width: 18,height: 18,),
                      SizedBox(width: 5,),
                      MyText(
                        title: 'Workout Progress',
                        color: plumGrey,
                        fontWeight: w400,
                        size: 11,
                      ),
                    ],
                  ),
                  Icon(Icons.arrow_forward_ios,color: plumGrey,size: 15,)
                ],
              )

            ],
          ),

        ),
      )
    ;
  }

  Widget profileInfoCard(String title, String subtitle,String icon){
    return
      Container(
        margin: EdgeInsets.only(top: size5,bottom: size5),
        height: 45,
        padding: EdgeInsets.symmetric(horizontal: size16,),
        decoration: BoxDecoration(
          color: beige,
            boxShadow: [
              BoxShadow(
                  color: plumGrey.withOpacity(0.3),
                  offset: Offset(1, 2),
                  spreadRadius: 1,
                  blurRadius: 3
              ),
            ],
          borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  title: icon,
                  size: size25,
                ),
                MyText(
                  title: " "+title,
                  color: dustyRose,
                  size: size18,
                  fontWeight: w700,
                ),
              ],
            ),
            SizedBox(height: 3,),
            MyText(
              title: subtitle,
              color: red,
              size: size16,
              fontWeight: w600,
            ),
          ],
        ),
      )
    ;
  }

  Widget profileRow(){
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: w*0.05,vertical: 10),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: plumGrey.withOpacity(0.2),
                  offset: Offset(1, 2),
                  spreadRadius: 1,
                  blurRadius: 3
              ),
            ]
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          (controller.userProfileModel.value?.profile!.gender ?? 'male') == 'female'
                              ? 'assets/female.png'
                              : 'assets/male.png'
                      ),
                    ),
                    SizedBox(width: 7,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyText(
                          title: (controller.userProfileModel.value!.name ?? '').length > 14
                              ? controller.userProfileModel.value!.name!.substring(0, 12) + "..."
                              : controller.userProfileModel.value!.name ?? '',                          fontWeight: w500,
                          size: size16,
                          color: Colors.black,
                        ),
                        MyText(
                          title: controller.userProfileModel.value?.profile!.gender.toString()??'',

                          fontWeight: w400,
                          size: size18,
                          color: plumGrey,
                        ),
                      ],
                    ),

                  ],
                ),
                InkWell(
                  onTap: (){
                    Get.to(()=>EditProfileScreen(userProfileModel: controller.userProfileModel.value,));
                  },
                  child: Container(
                    // width: 70,
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    height: 30,
                    decoration: BoxDecoration(
                        gradient: blueGradient,

                        borderRadius: BorderRadius.circular(80),  boxShadow: [
                      BoxShadow(
                          color: plumGrey.withOpacity(0.5),
                          offset: Offset(1, 2),
                          spreadRadius: 1,
                          blurRadius: 3
                      ),
                    ]
                    ),
                    child: Center(
                      child: MyText(
                        title: 'Edit Profile',
                        color: white,
                        fontWeight: w500,
                        size: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                profileInfoCard('Gender', controller.userProfileModel.value?.profile!.gender??'Male','⚧️'),
                profileInfoCard('Age', (controller.userProfileModel.value?.profile!.age.toString()??'unknown')+" yrs",'🎂'),
                profileInfoCard('Height',(controller.userProfileModel.value?.profile!.height.toString()??'Male')+" "+(controller.userProfileModel.value?.profile!.heightUnit??'kg'),'↕'),
                profileInfoCard('Weight', (controller.userProfileModel.value!.profile!.weight.toString()??'Male')+" "+(controller.userProfileModel.value?.profile!.weightUnit??'kg'),'⏲️'),
                profileInfoCard(
                    'Goal',
                    controller.userProfileModel.value!.profile!.goal != null
                        ? screen2controller.goals[controller.userProfileModel.value!.profile!.goal==0?0:controller.userProfileModel.value!.profile!.goal! - 1]['title'] ?? 'Lose Weight'
                        : 'Lose Weight',
                    '🎯️'
                ),
                profileInfoCard(
                    'Activity Level',
                    controller.userProfileModel.value!.profile!.activityLevel != null
                        ? screen2controller.activityLevels[controller.userProfileModel.value!.profile!.activityLevel==0?0:controller.userProfileModel.value!.profile!.activityLevel! - 1]['title'] ?? 'No Exercise'
                        : 'No Exercise',
                    '🔰'
                ),
              ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      );
  }

  Widget buildTile({required String icon,required String title, required VoidCallback onTap,
  }){
    return   InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: size5,bottom: size5,left: w*0.05,right: w*0.05),
        height: 45,
        padding: EdgeInsets.symmetric(horizontal: size16,),
        decoration: BoxDecoration(
            color: beige,
            boxShadow: [
              BoxShadow(
                  color: plumGrey.withOpacity(0.3),
                  offset: Offset(1, 2),
                  spreadRadius: 1,
                  blurRadius: 3
              ),
            ],
            borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon(icon,color: plumGrey,size: size25,),
                SizedBox(width: 5,),
                MyText(
                  title: icon,
                  size: size25,
                ),
                MyText(
                  title: " "+title,
                  color: dustyRose,
                  size: size18,
                  fontWeight: w700,
                ),
              ],
            ),
            // Icon(Icons.arrow_forward_ios,color: plumGrey,size: 15,)
          ],
        ),
      ),
    );
  }


  Widget logoutTile({required IconData icon,required String title, required VoidCallback onTap,
  }){
    return   InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: size5,bottom: size5,left: w*0.05,right: w*0.05),
        height: 45,
        padding: EdgeInsets.symmetric(horizontal: size16,),
        decoration: BoxDecoration(
            color: beige,
            boxShadow: [
              BoxShadow(
                  color: plumGrey.withOpacity(0.3),
                  offset: Offset(1, 2),
                  spreadRadius: 1,
                  blurRadius: 3
              ),
            ],
            borderRadius: BorderRadius.circular(15)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(icon,color: red,size: size25,),
                SizedBox(width: 5,),
                MyText(
                  title: title,
                  color: red,
                  fontWeight: w700,
                  size: size16,
                ),
              ],
            ),
            Obx(()=> controller.isLoading.value?CupertinoActivityIndicator():SizedBox())
          ],
        ),
      ),
    );
  }
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
