// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:getrightmealnew/Views/AppViews/ContactUsScreen.dart';
// import 'package:getrightmealnew/Views/AppViews/PrivacyPolicy.dart';
// import 'package:getrightmealnew/Views/AppViews/RateUsScreen.dart';
// import 'package:getrightmealnew/Views/AppViews/TermsAndConditions.dart';
//
// import '../Constants/Colors.dart';
// import '../Constants/Sizes.dart';
// import '../Constants/fontWeights.dart';
// import '../Controllers/ProfileScreenController.dart';
// import '../Views/AppViews/CustomNavBar.dart';
// import '../Views/AppViews/EditProfileScreen.dart';
// import '../main.dart';
// import '../widgets/Text.dart';
//
// class CustomDrawer extends StatelessWidget {
//   final GlobalKey<ScaffoldState> scaffoldKey;
//   CustomDrawer({Key? key, required this.scaffoldKey}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: backgroundGrey,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           // Drawer Header with Logo, App Name, and Tagline
//           SizedBox(
//             height: 230,
//             child: DrawerHeader(
//               padding: EdgeInsets.all(0),
//               decoration: BoxDecoration(
//                 color: red.withOpacity(0.1),
//               ),
//               child: Container(
//                 width: w,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Image.asset(
//                       'assets/logo.png',
//                       height: 70,
//                       width: 160,
//                       fit: BoxFit.cover,
//                     ),
//                     const SizedBox(height: 5),
//                     MyText(
//                       title: 'Get Right Meal',
//                       fontWeight: w700,
//                       size: size20,
//                       color: black,
//                     ),
//                     const SizedBox(height: 0),
//                     MyText(
//                       title: 'Meals That Matter',
//                       size: size16,
//                       color: dustyRose,
//                       fontWeight: w500,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//
//           // Menu Options
//           Flexible(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: [
//                 _buildDrawerItem(
//                   icon: CupertinoIcons.home, // Home Icon
//                   title: 'Home',
//                   onTap: () {
//                     final CustomNavBarController navBarController = Get.find<CustomNavBarController>();
//                     navBarController.setPageIndex(0);
//                     scaffoldKey.currentState!.closeEndDrawer();
//                   },
//                 ),
//                 _buildDrawerItem(
//                   icon: FontAwesomeIcons.user, // Profile Icon
//                   title: 'Profile',
//                   onTap: () {
//                     final CustomNavBarController navBarController = Get.find<CustomNavBarController>();
//                     navBarController.setPageIndex(1);
//                     scaffoldKey.currentState!.closeEndDrawer();
//                   },
//                 ),
//                 _buildDrawerItem(
//                   icon: FontAwesomeIcons.penToSquare, // Edit Profile Icon
//                   title: 'Edit Profile',
//                   onTap: () {
//                     scaffoldKey.currentState!.closeEndDrawer();
//                     Get.to(() => EditProfileScreen(), transition: Transition.rightToLeftWithFade);
//                   },
//                 ),
//                 _buildDrawerItem(
//                   icon: FontAwesomeIcons.shieldAlt, // Privacy Policy Icon
//                   title: 'Privacy Policy',
//                   onTap: () {
//                     scaffoldKey.currentState!.closeEndDrawer();
//                     Get.to(() => PrivacyPolicyScreen(), transition: Transition.rightToLeftWithFade);
//                   },
//                 ),
//                 _buildDrawerItem(
//                   icon: FontAwesomeIcons.fileLines, // Terms and Conditions Icon
//                   title: 'Terms and Conditions',
//                   onTap: () {
//                     scaffoldKey.currentState!.closeEndDrawer();
//                     Get.to(() => TermsAndConditionsScreen(), transition: Transition.rightToLeftWithFade);
//                   },
//                 ),
//                 _buildDrawerItem(
//                   icon: FontAwesomeIcons.envelope, // Contact Us Icon
//                   title: 'Contact Us',
//                   onTap: () {
//                     scaffoldKey.currentState!.closeEndDrawer();
//                     Get.to(() => ContactUsScreen(), transition: Transition.rightToLeftWithFade);
//                   },
//                 ),
//                 _buildDrawerItem(
//                   icon: FontAwesomeIcons.star, // Rate Us Icon
//                   title: 'Rate Us',
//                   onTap: () {
//                     scaffoldKey.currentState!.closeEndDrawer();
//                     Get.to(() => RateUsScreen(), transition: Transition.rightToLeftWithFade);
//                   },
//                 ),
//                 _buildLogoutItem(
//                   icon: FontAwesomeIcons.signOut, // Rate Us Icon
//                   title: 'Logout',
//                   onTap: ()async {
//                     await ProfileScreenController().logout();
//
//                   },
//                 ),
//               ],
//             ),
//           ),
//
//           // Logout Option
//           // InkWell(
//           //   onTap: () async {
//           //     await ProfileScreenController().logout();
//           //   },
//           //   child: Container(
//           //     margin: EdgeInsets.only(bottom: 15, right: 10, left: 10),
//           //     width: w,
//           //     height: 45,
//           //     decoration: BoxDecoration(
//           //       boxShadow: [
//           //         BoxShadow(
//           //           color: plumGrey.withOpacity(0.5),
//           //           offset: Offset(1, 2),
//           //           spreadRadius: 1,
//           //           blurRadius: 3,
//           //         ),
//           //       ],
//           //       borderRadius: BorderRadius.circular(50),
//           //       gradient: LinearGradient(
//           //         begin: Alignment.topCenter,
//           //         end: Alignment.bottomCenter,
//           //         colors: [
//           //           red.withOpacity(0.6),
//           //           red.withOpacity(0.8),
//           //           red,
//           //         ],
//           //       ),
//           //     ),
//           //     child: Center(
//           //       child: MyText(
//           //         title: 'Logout',
//           //         fontWeight: w700,
//           //         size: size16,
//           //         color: Colors.white,
//           //       ),
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDrawerItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: plumGrey.withOpacity(0.5), width: 0.4)),
//       ),
//       child: ListTile(
//         leading: FaIcon(icon, color: plumGrey,size: icon == CupertinoIcons.home?size26:size24,), // Font Awesome Icon
//         title: MyText(
//           textAlign: TextAlign.left,
//           title: title,
//           fontWeight: w600,
//           size: size17,
//           color: plumGrey,
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
//   Widget _buildLogoutItem({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border(bottom: BorderSide(color: plumGrey.withOpacity(0.5), width: 0.4)),
//       ),
//       child: ListTile(
//         leading: FaIcon(icon, color: red), // Font Awesome Icon
//         title: MyText(
//           textAlign: TextAlign.left,
//           title: title,
//           fontWeight: w600,
//           size: size17,
//           color: red,
//         ),
//         onTap: onTap,
//       ),
//     );
//   }
// }
