import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Controllers/ProfileScreenController.dart';
import 'package:getrightmealnew/Widgets/NoDataFoundWidget.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../../Constants/fontWeights.dart';
import '../../Helpers/EmailService.dart';
import '../../Widgets/Text.dart';

class ContactUsScreen extends StatefulWidget {
  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  final TextEditingController messageController = TextEditingController();

  final EmailService emailService = Get.put(EmailService());

  final ProfileScreenController profileScreenController = Get.put(ProfileScreenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  WidgetsBinding.instance!.addPostFrameCallback((timeStamp)async {
   await profileScreenController.fetchProfile();
  });
        }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
    emailService.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundGrey,
      appBar: CupertinoNavigationBar(
        leading: InkWell(
            onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back_ios_rounded, color: dustyRose, size: size20)),
        backgroundColor: backgroundGrey,
        middle: MyText(
          title: 'Help and Support',
          fontWeight: w700,
          size: size18,
          color: black,
        ),
      ),
      body: Obx(()=>
      profileScreenController.isLoading.value?
      Center(child: CupertinoActivityIndicator(),):
      profileScreenController.userProfileModel.value ==null ?
          Center(
            child: MyText(
              title: 'Could not use this service!',
              fontWeight: w700,
              size: size18,
              color: black,
            ),
          ):

      SafeArea(
        child: Column(
          children: [
            // Title Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: MyText(
                title: 'We\'d love to hear from you!',
                fontWeight: w700,
                size: size22,
                color: black,
              ),
            ),
            // Contact Form Section
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // CupertinoTextField(
                    //   controller: nameController,
                    //   placeholder: 'Your Name',
                    //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    //   decoration: BoxDecoration(
                    //     color: CupertinoColors.white,
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     border: Border.all(color: CupertinoColors.inactiveGray),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    // CupertinoTextField(
                    //   controller: emailController,
                    //   placeholder: 'Your Email',
                    //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    //   decoration: BoxDecoration(
                    //     color: CupertinoColors.white,
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     border: Border.all(color: CupertinoColors.inactiveGray),
                    //   ),
                    // ),
                    // SizedBox(height: 20),
                    CupertinoTextField(
                      controller: messageController,
                      placeholder: 'Your Message',
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      maxLines: 5,
                      decoration: BoxDecoration(
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: CupertinoColors.inactiveGray),
                      ),
                    ),
                    SizedBox(height: 30),
                    Obx(()=>
                    emailService.isLoading.value?
                    CupertinoActivityIndicator():
                    CupertinoButton.filled(
                      child: Text('Send Message'),
                      onPressed: ()async {
                        String? name = profileScreenController.userProfileModel.value?.name!;
                        String? email = profileScreenController.userProfileModel.value?.email!;
                        String message = messageController.text;

                        // Example: Send message logic
                        if (name!.isNotEmpty && email!.isNotEmpty && message.isNotEmpty) {

                          try{
                            await emailService.sendContactUsEmail(
                              name: name,
                              email: email,
                              message: message,
                              context: context,
                            ).then((v){
                              messageController.clear();
                            });
                          }catch(e){

                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: Text('Error'),
                                content: Text('Failed to send message. Please try again later.'),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text('OK'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                            );
                          }

                        } else {
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: Text('Error'),
                              content: Text('Please fill in all fields.'),
                              actions: [
                                CupertinoDialogAction(
                                  child: Text('OK'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
      ),
    );
  }
}
