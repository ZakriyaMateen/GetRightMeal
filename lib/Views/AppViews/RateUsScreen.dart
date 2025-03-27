// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
//
// import '../../Constants/Colors.dart';
// import '../../Constants/Sizes.dart';
// import '../../Constants/fontWeights.dart';
// import '../../Widgets/Text.dart';
//
// class RateUsScreen extends StatelessWidget {
//   final TextEditingController messageController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundGrey,
//       appBar: CupertinoNavigationBar(
//         leading: InkWell(
//           onTap: () { Navigator.pop(context); },
//           child: Icon(Icons.arrow_back_ios_rounded, color: dustyRose, size: size20),
//         ),
//         backgroundColor: backgroundGrey,
//         middle: MyText(
//           title: 'Rate Us',
//           fontWeight: w700,
//           size: size18,
//           color: black,
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Title Section
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20.0),
//               child: MyText(
//                 title: 'We value your feedback!',
//                 fontWeight: w700,
//                 size: size22,
//                 color: black,
//               ),
//             ),
//             // Rating Section
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20.0),
//               child: RatingBar.builder(
//                 initialRating: 0,
//                 minRating: 1,
//                 direction: Axis.horizontal,
//                 allowHalfRating: true,
//                 itemCount: 5,
//                 itemSize: 40,
//                 itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
//                 itemBuilder: (context, _) => Icon(
//                   Icons.star,
//                   color: Colors.orange,
//                 ),
//                 onRatingUpdate: (rating) {
//                   print("Rating: $rating");
//                   // You can add your logic here to handle rating feedback
//                 },
//               ),
//             ),
//             // Message Section
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CupertinoTextField(
//                       controller: messageController,
//                       placeholder: 'Your Message (optional)',
//                       padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
//                       maxLines: 5,
//                       decoration: BoxDecoration(
//                         color: CupertinoColors.white,
//                         borderRadius: BorderRadius.circular(8.0),
//                         border: Border.all(color: CupertinoColors.inactiveGray),
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     CupertinoButton.filled(
//                       child: Text('Submit Feedback'),
//                       onPressed: () {
//                         String message = messageController.text;
//
//                         if (message.isNotEmpty) {
//                           showCupertinoDialog(
//                             context: context,
//                             builder: (context) => CupertinoAlertDialog(
//                               title: Text('Feedback Sent'),
//                               content: Text('Thank you for your feedback!'),
//                               actions: [
//                                 CupertinoDialogAction(
//                                   child: Text('OK'),
//                                   onPressed: () => Navigator.pop(context),
//                                 ),
//                               ],
//                             ),
//                           );
//                         } else {
//                           showCupertinoDialog(
//                             context: context,
//                             builder: (context) => CupertinoAlertDialog(
//                               title: Text('Error'),
//                               content: Text('Please provide your feedback message.'),
//                               actions: [
//                                 CupertinoDialogAction(
//                                   child: Text('OK'),
//                                   onPressed: () => Navigator.pop(context),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }
//                       },
//                     ),
//                     SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
