import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:getrightmealnew/Constants/Colors.dart';

import '../../../Constants/Sizes.dart';
import '../../../Constants/fontWeights.dart';
import '../../../Widgets/Text.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
   WebViewScreen({super.key, required this.url});
  final WebviewScreenController webviewScreenController = Get.put(WebviewScreenController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: white,
        appBar: CupertinoNavigationBar(
          leading: InkWell(
              onTap: (){
                  // bool isEnabled = FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled;
                  // print('isEnabled: $isEnabled');
                  // try {
                  //   throw Exception("Something went wrong!");
                  // } catch (e, stackTrace) {
                  //   // 🔥 Firebase Crashlytics mein report karna
                  //   FirebaseCrashlytics.instance.recordError(e, stackTrace);
                  // }

                  // Navigator.pop(context);
                  Get.back();
                },
              child: Icon(Icons.arrow_back_ios_rounded, color: dustyRose, size: size20)),
          backgroundColor: white,

        ),
        body:
        SafeArea(
          child:Stack(
            children: [
              InAppWebView(

                initialUrlRequest: URLRequest(url: WebUri(url)),
                onLoadStart: (controller, url) async {
                  webviewScreenController.isLoading.value = true;
                },
                onLoadStop: (controller, url) async {
                  webviewScreenController.isLoading.value = false;
                },
                initialSettings: InAppWebViewSettings(
                  supportZoom: false,
                  userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36',
                  useHybridComposition: true,
                ),

              ),
              Obx(()=>
                webviewScreenController.isLoading.value?
                    Center(child: CupertinoActivityIndicator()):Container()
                      ),

            ],
          )
    )
    );
  }
}


class WebviewScreenController extends GetxController{
  RxBool isLoading = false.obs;


}