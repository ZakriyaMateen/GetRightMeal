// import 'package:fancy_drawer/fancy_drawer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:get/get.dart';
// import 'package:getrightmealnew/Views/AppViews/HomeScreen.dart';
//
// import '../../Constants/Colors.dart';
// import '../../Constants/Sizes.dart';
// import '../../Constants/fontWeights.dart';
// import '../../Controllers/ProfileScreenController.dart';
// import '../../Widgets/Text.dart';
// import '../../main.dart';
// import 'ContactUsScreen.dart';
// import 'CustomNavBar.dart';
// import 'EditProfileScreen.dart';
// import 'PrivacyPolicy.dart';
// import 'RateUsScreen.dart';
// import 'TermsAndConditions.dart';
//
//
//
// class CustomAnimatedDrawer extends StatefulWidget {
//   CustomAnimatedDrawer({Key? key}) : super(key: key);
//
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<CustomAnimatedDrawer>
//     with SingleTickerProviderStateMixin {
//   late FancyDrawerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = FancyDrawerController(
//         vsync: this, duration: Duration(milliseconds: 250))
//       ..addListener(() {
//         setState(() {});
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FancyDrawerWrapper(
//       backgroundColor: Colors.white,
//       controller: _controller,
//       drawerItems: <Widget>[
//         // Drawer Header with Logo, App Name, and Tagline
//         SizedBox(
//           height: 230,
//           child: DrawerHeader(
//             padding: EdgeInsets.all(0),
//             decoration: BoxDecoration(
//               color: red.withOpacity(0.1),
//             ),
//             child: Container(
//               width: w,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/logo.png',
//                     height: 70,
//                     width: 160,
//                     fit: BoxFit.cover,
//                   ),
//                   const SizedBox(height: 5),
//                   MyText(
//                     title: 'Get Right Meal',
//                     fontWeight: w700,
//                     size: size20,
//                     color: black,
//                   ),
//                   const SizedBox(height: 0),
//                   MyText(
//                     title: 'Meals That Matter',
//                     size: size16,
//                     color: dustyRose,
//                     fontWeight: w500,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//
//         // Menu Options
//         Flexible(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               _buildDrawerItem(
//                 icon: CupertinoIcons.home, // Home Icon
//                 title: 'Home',
//                 onTap: () {
//                   final CustomNavBarController navBarController = Get.find<CustomNavBarController>();
//                   navBarController.setPageIndex(0);
//                   scaffoldKey.currentState!.closeEndDrawer();
//                 },
//               ),
//               _buildDrawerItem(
//                 icon: FontAwesomeIcons.user, // Profile Icon
//                 title: 'Profile',
//                 onTap: () {
//                   final CustomNavBarController navBarController = Get.find<CustomNavBarController>();
//                   navBarController.setPageIndex(1);
//                   scaffoldKey.currentState!.closeEndDrawer();
//                 },
//               ),
//               _buildDrawerItem(
//                 icon: FontAwesomeIcons.penToSquare, // Edit Profile Icon
//                 title: 'Edit Profile',
//                 onTap: () {
//                   scaffoldKey.currentState!.closeEndDrawer();
//                   Get.to(() => EditProfileScreen(), transition: Transition.rightToLeftWithFade);
//                 },
//               ),
//               _buildDrawerItem(
//                 icon: FontAwesomeIcons.shieldAlt, // Privacy Policy Icon
//                 title: 'Privacy Policy',
//                 onTap: () {
//                   scaffoldKey.currentState!.closeEndDrawer();
//                   Get.to(() => PrivacyPolicyScreen(), transition: Transition.rightToLeftWithFade);
//                 },
//               ),
//               _buildDrawerItem(
//                 icon: FontAwesomeIcons.fileLines, // Terms and Conditions Icon
//                 title: 'Terms and Conditions',
//                 onTap: () {
//                   scaffoldKey.currentState!.closeEndDrawer();
//                   Get.to(() => TermsAndConditionsScreen(), transition: Transition.rightToLeftWithFade);
//                 },
//               ),
//               _buildDrawerItem(
//                 icon: FontAwesomeIcons.envelope, // Contact Us Icon
//                 title: 'Contact Us',
//                 onTap: () {
//                   scaffoldKey.currentState!.closeEndDrawer();
//                   Get.to(() => ContactUsScreen(), transition: Transition.rightToLeftWithFade);
//                 },
//               ),
//               _buildDrawerItem(
//                 icon: FontAwesomeIcons.star, // Rate Us Icon
//                 title: 'Rate Us',
//                 onTap: () {
//                   scaffoldKey.currentState!.closeEndDrawer();
//                   Get.to(() => RateUsScreen(), transition: Transition.rightToLeftWithFade);
//                 },
//               ),
//               _buildLogoutItem(
//                 icon: FontAwesomeIcons.signOut, // Rate Us Icon
//                 title: 'Logout',
//                 onTap: ()async {
//                   await ProfileScreenController().logout();
//
//                 },
//               ),
//             ],
//           ),
//         ),
//
//
//       ],
//       child:HomeScreen()
//     );
//   }
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