import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String? title ;
  final double? size ;
  final Color? color ;
  final int? maxline ;
  final TextAlign? textAlign ;
  final FontWeight? fontWeight ;
  const MyText({
    super.key,this.title,this.maxline,this.size,this.color,this.fontWeight,this.textAlign
  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,maxLines: maxline??1,style:
    GoogleFonts.roboto(textStyle: TextStyle(fontSize:size ?? 25,fontWeight: fontWeight??FontWeight.w500,color:color?? Colors.black),),
      textAlign:textAlign?? TextAlign.center,overflow: TextOverflow.ellipsis,);
  }
}


class MyTextOverflow extends StatelessWidget {
  final String? title ;
  final double? size ;
  final Color? color ;
  final int? maxline ;
  final TextAlign? textAlign ;
  final FontWeight? fontWeight ;
  const MyTextOverflow({
    super.key,this.title,this.maxline,this.size,this.color,this.fontWeight,this.textAlign
  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,maxLines: maxline??4,style:
    GoogleFonts.roboto(
      textStyle: TextStyle(fontSize:size ?? 25,fontWeight: fontWeight??FontWeight.w500,color:color?? Colors.black)
    ),
      textAlign:textAlign?? TextAlign.left,overflow: TextOverflow.visible,
    );
  }
}


class MyTextUnderline extends StatelessWidget {
  final String? title ;
  final double? size ;
  final Color? color ;
  final int? maxline ;
  final TextAlign? textAlign ;
  final FontWeight? fontWeight ;
  const MyTextUnderline({
    super.key,this.title,this.maxline,this.size,this.color,this.fontWeight,this.textAlign
  });

  @override
  Widget build(BuildContext context) {
    return Text(title!,maxLines: maxline??4,style:  GoogleFonts.roboto(textStyle: TextStyle(
        decoration: TextDecoration.underline, // Apply underline
        decorationColor: color!,
        fontSize:size ?? 25,fontWeight: fontWeight??FontWeight.w500,color:color?? Colors.black)),textAlign:textAlign?? TextAlign.left,overflow: TextOverflow.visible,);
  }
}
