import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Widgets/Text.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../../Constants/fontWeights.dart';

class TermsAndConditionsScreen extends StatelessWidget {
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
          title: 'Terms and Conditions',
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
                    // Section 1: Agreement
                    MyText(
                      title: 'Agreement',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'By using our services, you agree to the terms and conditions stated here. If you do not agree, please refrain from using the app.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 2: Usage Restrictions
                    MyText(
                      title: 'Usage Restrictions',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'You are prohibited from using the app for illegal activities or in a manner that violates any laws. You agree not to disrupt or abuse the app services.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 3: Termination of Services
                    MyText(
                      title: 'Termination of Services',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'We reserve the right to suspend or terminate your access to the app if you violate any of the terms. We are not liable for any loss of data or service.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 4: Liability Limitations
                    MyText(
                      title: 'Liability Limitations',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'Our liability is limited to the maximum extent permitted by law. We are not liable for indirect, incidental, or consequential damages arising from the use of the app.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 5: Modifications to the Terms
                    MyText(
                      title: 'Modifications to the Terms',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'We may update or change these terms from time to time. Any changes will be posted on this page, and your continued use of the app constitutes your acceptance of the revised terms.',
                      size: size16,
                      color: plumGrey,
                      maxline: 5,
                    ),
                    SizedBox(height: 20),

                    // Section 6: Contact Information
                    MyText(
                      title: 'Contact Information',
                      fontWeight: w600,
                      size: size17,
                      color: dustyRose,
                    ),
                    SizedBox(height: 10),
                    MyTextOverflow(
                      title:
                      'If you have any questions regarding these terms, feel free to contact us through the app or via our support email.',
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
