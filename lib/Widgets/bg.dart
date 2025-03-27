import 'package:flutter/material.dart';
import 'dart:math';

class BgWidget extends StatelessWidget {
  BgWidget({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    // Get screen dimensions. If you already have these values defined elsewhere, feel free to use them.
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    // return Image.network('https://images.unsplash.com/photo-1700150618387-3f46b6d2cf8e?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjJ8fGRvb2RsZXMlMjBmcnVpdCUyMHZlZ2V0YWJsZXN8ZW58MHx8MHx8fDA%3D',fit: BoxFit.cover,width: w,height: h,);
    // return Image.network('https://images.unsplash.com/photo-1550497507-634bd6d81ecd?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8ZG9vZGxlcyUyMGZydWl0JTIwdmVnZXRhYmxlc3xlbnwwfHwwfHx8MA%3D%3D',fit: BoxFit.cover,width: w,height: h,);
    // return Image.network('https://plus.unsplash.com/premium_photo-1661255415300-4e7bc1397e12?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OXx8ZG9vZGxlcyUyMGZydWl0JTIwdmVnZXRhYmxlc3xlbnwwfHwwfHx8MA%3D%3D',fit: BoxFit.cover,width: w,height: h,);
    return Stack(
      children: [
        Positioned(
          bottom: h*0.25,
          right: w*0.035,
          child: Image.network('https://cdn-icons-png.flaticon.com/128/3137/3137044.png',width: 60,height: 60,),
        ),
        Positioned(
          top: h*0.14,
          right: w*0.035,
          child: Image.network('https://cdn-icons-png.flaticon.com/128/1625/1625048.png',width: 60,height: 60,),
        ),
        Positioned(
          top: h*0.5,
          left: w*0.035,
          child: Image.network('https://cdn-icons-png.flaticon.com/128/590/590685.png',width: 60,height: 60,),
        ),
        // Positioned(
        //   bottom: h*0.43,
        //   right: w*0.24,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/590/590685.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   top: h*0.64,
        //   left: w*0.5,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/3194/3194766.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   bottom: h*0.07,
        //   left: w*0.05,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/11850/11850801.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   bottom: h*0.1,
        //   right: w*0.4,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/1147/1147934.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   top: h*0.74,
        //   left: w*0.32,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/6265/6265882.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   top: h*0.4,
        //   right: w*0.07,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/3137/3137044.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   top: h*0.50,
        //   left: w*0.2,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/135/135695.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   top: h*0.5,
        //   left: w*0.4,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/2153/2153788.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   top: h*0.6,
        //   left: w*0.14,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/9862/9862079.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   top: h*0.7,
        //   left: w*0.6,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/7315/7315544.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   bottom: h*0.18,
        //   left: w*0.12,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/10632/10632405.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   top: h*0.74,
        //   left: w*0.33,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/7315/7315766.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   bottom: h*0.2,
        //   right: w*0.06,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/3137/3137044.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   bottom: h*0.13,
        //   right: w*0.1,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/1652/1652077.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   top: h*0.68,
        //   left: w*0.2,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/7389/7389986.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   top: h*0.6,
        //   right: w*0.06,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/4056/4056887.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   top: h*0.1,
        //   left: w*0.2,
        //   child: Image.network('https://cdn-icons-png.flaticon.com/128/6135/6135880.png',width: 50,height: 50,),
        // ),
        // Positioned(
        //   top: h * 0.15,
        //   left: w * 0.8,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/4310/4310157.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   top: h * 0.25,
        //   right: w * 0.1,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/17084/17084940.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   bottom: h * 0.35,
        //   left: w * 0.15,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/863/863609.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   bottom: h * 0.25,
        //   right: w * 0.2,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/2756/2756708.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   top: h * 0.05,
        //   left: w * 0.5,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/2515/2515263.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   top: h * 0.3,
        //   right: w * 0.3,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/7757/7757737.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   bottom: h * 0.15,
        //   left: w * 0.67,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/9340/9340025.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   bottom: h * 0.05,
        //   right: w * 0.5,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/706/706164.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   top: h * 0.65,
        //   left: w * 0.35,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/561/561611.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   top: h * 0.45,
        //   right: w * 0.15,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/2805/2805947.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   top: h * 0.10,
        //   left: w * 0.15,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/2392/2392042.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   top: h * 0.20,
        //   right: w * 0.25,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/9273/9273859.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   bottom: h * 0.30,
        //   left: w * 0.10,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/706/706219.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   bottom: h * 0.40,
        //   right: w * 0.20,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/7924/7924064.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   top: h * 0.35,
        //   left: w * 0.50,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/14777/14777346.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   top: h * 0.55,
        //   right: w * 0.15,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/15502/15502516.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   bottom: h * 0.08,
        //   right: w * 0.07,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/2153/2153788.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
        // Positioned(
        //   bottom: h * 0.4,
        //   right: w * 0.35,
        //   child: Image.network(
        //     'https://cdn-icons-png.flaticon.com/128/4215/4215375.png',
        //     width: 50,
        //     height: 50,
        //   ),
        // ),
      ]
    );
  }
}
