import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Widgets/Text.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../../Constants/fontWeights.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: CupertinoNavigationBar(
        leading: InkWell(
            onTap: (){Get.back();},
            child: Icon(Icons.arrow_back_ios_rounded,color: dustyRose,size: size20,)),
        backgroundColor: backgroundGrey,
        middle: MyText(title: 'Privacy Policy',
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
                    // Section 1: Introduction
                    MyText(
                      title: 'Introduction',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'This Privacy Policy explains how we collect, use, and protect your information when you use our services.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 2: Data Collection
                    MyText(
                      title: 'Data Collection',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'We collect personal information such as your name, email, and usage data. This information is necessary to provide a better user experience and improve our services.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 3: Data Usage
                    MyText(
                      title: 'Data Usage',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'The information we collect is used to enhance your experience, personalize the app, and communicate updates. We do not sell your personal data to third parties.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 4: Data Protection
                    MyText(
                      title: 'Data Protection',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'We take security seriously and use encryption methods to protect your data. However, please note that no data transmission over the internet can be guaranteed 100% secure.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 5: User Rights
                    MyText(
                      title: 'User Rights',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'You have the right to access, update, or delete your personal information. If you wish to do so, please contact us through the app.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 6: Changes to Privacy Policy
                    MyText(
                      title: 'Changes to Privacy Policy',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'We may update our Privacy Policy from time to time. Any changes will be posted on this page, and we will notify you if necessary.',
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
