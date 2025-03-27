import 'package:flutter/material.dart';
import 'package:getrightmealnew/Constants/Colors.dart';
import 'package:getrightmealnew/Constants/Gradients.dart';
import 'package:getrightmealnew/Constants/fontWeights.dart';
import 'package:getrightmealnew/Widgets/Text.dart';
import 'package:getrightmealnew/main.dart';

import '../Constants/Sizes.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: w*0.5,
      padding: EdgeInsets.only(top: size10,bottom: size10),
      decoration: BoxDecoration(
        // color: white,
        // borderRadius: BorderRadius.circular(12),
        // boxShadow: [
        //   BoxShadow(
        //     color: grey.withOpacity(0.4),
        //     spreadRadius: 2,
        //     blurRadius: 2,
        //     offset: Offset(2, 1)
        //   )
        // ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyText(
            textAlign: TextAlign.center,
            title: 'Are you a new user?',
            fontWeight: w600,
            color: plumGrey,
            size: size19,
          ),
          SizedBox(height: size18,),
          Container(
            padding: EdgeInsets.symmetric(vertical: size10,horizontal: size15),
            decoration: BoxDecoration(
              gradient: blueGradient,
              borderRadius: BorderRadius.circular(60),
              boxShadow: [
                BoxShadow(
                  color: plumGrey,
                  offset: Offset(1, 2),
                  spreadRadius: 1,
                  blurRadius: 3
                )
              ]
            ),
            alignment: Alignment.center,
            child: MyText(
              textAlign: TextAlign.center,
              title: 'Add Profile',
              fontWeight: w600,
              color: white,
              size: size19,
            ),
          )
        ],
      ),
    );
  }
}
