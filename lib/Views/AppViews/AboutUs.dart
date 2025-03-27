import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Widgets/Text.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../../Constants/fontWeights.dart';

class AboutUsScreen extends StatelessWidget {
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
          title: 'About Us',
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
                    // Section 1: Our Story
                    MyText(
                      title: 'Our Story',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'We started with a vision to provide top-quality services that empower people and enhance their everyday lives. Our journey began with a small team and a big idea.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 2: Our Mission
                    MyText(
                      title: 'Our Mission',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'Our mission is to continuously innovate and provide exceptional services that exceed the expectations of our customers. We aim to create long-lasting relationships built on trust and satisfaction.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 3: Our Vision
                    MyText(
                      title: 'Our Vision',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'We envision a world where technology and services work together seamlessly to improve daily life. We aim to become a leader in the industry, known for our dedication to excellence and customer satisfaction.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 4: Our Values
                    MyText(
                      title: 'Our Values',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'Integrity, transparency, and customer-centricity are at the core of everything we do. We strive to maintain the highest standards of ethical conduct and business practices.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 5: Our Team
                    MyText(
                      title: 'Our Team',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'Our team is made up of passionate and dedicated professionals who work tirelessly to bring our vision to life. We are committed to growth, collaboration, and the pursuit of excellence.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 6: Contact Us
                    MyText(
                      title: 'Contact Us',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'If you have any questions or would like to know more about our story, mission, or services, feel free to contact us. We are always here to help.',
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
