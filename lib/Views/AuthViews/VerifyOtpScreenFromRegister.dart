import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../Constants/Colors.dart';
import '../../Constants/Sizes.dart';
import '../../Constants/fontWeights.dart';
import '../../Controllers/AuthControllers/LoginPageController.dart';
import '../../Controllers/AuthControllers/VerifyOtpControllerFromRegister.dart';
import '../../Widgets/Text.dart';

class OtpVerificationScreen extends StatefulWidget {
  final bool isLogin;
  final String email;
  const OtpVerificationScreen({super.key, required this.email, required this.isLogin});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  TextEditingController pinController = TextEditingController();
  // ResetPasswordController controller = Get.put(ResetPasswordController());
  LoginPageController loginPageController = Get.put(LoginPageController());
  VerifyOtpScreenController controller = Get.put(VerifyOtpScreenController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontSize: 22, color: Colors.white),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: red),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: red, width: 2),
      borderRadius: BorderRadius.circular(10),
    );

    var submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: green,
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return Scaffold(
      backgroundColor: beige,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
            
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          "assets/otp.png",
                          height: 55,
                        ),
                      ),
                    ),
                  ],
                ),
            
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 5),
                  child: Text(
                    "We have sent you a verification email on ${widget.email}\nCheck & enter the OTP code",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Pinput(
                    length: 6,
                    controller: pinController,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    onCompleted: (pin) async {
                      controller.otp.value = pin;
                      controller.email.value = widget.email;
                      await controller.postData(isLogin: widget.isLogin);
                    },
                  ),
                ),
                const SizedBox(height: 60),
                Center(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(side: BorderSide(color: red)),
                      child: Obx(()=>(controller.isLoading.value || loginPageController.isLoading.value) ?
                      CupertinoActivityIndicator():
                      MyText(title: 'Verify',color: red, fontWeight: w600, size: size16,)),
                      onPressed: () async{
                        if (controller.validation()) {
                          controller.email.value = widget.email;
                          await controller.postData(isLogin: widget.isLogin);
                        }
                        // verifyOtpController.postData();
                      }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    width: Get.width * 0.72,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: red, width: 0.5)),
                    child: TextButton(
                        child:  MyText(
                          title: 'Resend OTP',
                          size: size17,
                          color: red,
                          fontWeight: w600,
                        ),
                        onPressed: () async{
                          await loginPageController.postData(fromOtpScreen: true);
                          // if (controller.validation()) {
                          //   controller.email.value = widget.email;
                          //   await controller.postData();
                          // }
                        }),
                  ),
                )              ],
            ),
          ),
        ),
      ),
    );
  }
}
