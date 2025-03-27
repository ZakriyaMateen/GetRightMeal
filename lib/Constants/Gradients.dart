import 'package:flutter/material.dart';

import 'Colors.dart';

const blueGradient = LinearGradient(colors: [
  lightRed,
  red
], begin: Alignment.centerLeft, end: Alignment.centerRight);

var blueGradientLight = LinearGradient(colors: [
  lightBlue.withOpacity(0.6),
  darkBlue.withOpacity(0.6)
], begin: Alignment.centerLeft, end: Alignment.centerRight);

const purpleGradient = LinearGradient(
  colors: [
    lightPurple,
    darkPurple,
  ],
    begin: Alignment.centerLeft, end: Alignment.centerRight);

const noGradient = LinearGradient(
    colors: [
      white,
      white
    ],
);