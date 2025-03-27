import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Widgets/Text.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../../Constants/fontWeights.dart';

class HelpAndSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: CupertinoNavigationBar(
        leading: InkWell(
            onTap: (){Get.back();},
            child: Icon(Icons.arrow_back_ios_rounded,color: dustyRose,size: size20,)),
        backgroundColor: backgroundGrey,
        middle: MyText(
          title: 'Help and Support',
          fontWeight: w700,
          size: size18,
          color: black,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Title Section
            SizedBox(height: 20,),
            // Content Section
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: General Help
                    MyText(
                      title: 'General Help',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'If you are having trouble with using the app, check out our FAQs section. If you still need help, our customer support team is available to assist you.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 2: Account Issues
                    MyText(
                      title: 'Account Issues',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'For issues related to your account, such as login problems or account settings, please reach out to our support team who will assist you in resolving the matter promptly.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 3: Payment Issues
                    MyText(
                      title: 'Payment Issues',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'If you experience any issues with payments, such as failed transactions or billing concerns, please contact our support team. We are committed to resolving payment-related issues quickly.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 4: App Feedback
                    MyText(
                      title: 'App Feedback',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'We value your feedback and strive to improve our app. If you have any suggestions or comments, feel free to share them with us through the feedback form or email.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 5: Contact Support
                    MyText(
                      title: 'Contact Support',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'If you need further assistance, you can contact our support team by emailing us at support@example.com or reaching out via the in-app support chat.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 6: Support Hours
                    MyText(
                      title: 'Support Hours',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'Our customer support is available Monday to Friday from 9:00 AM to 6:00 PM. We aim to respond to your queries as quickly as possible.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // Footer Section with a button

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
