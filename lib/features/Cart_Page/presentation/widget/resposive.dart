import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double textMultiplier;
  static late double imageSizeMultiplier;

  static void init(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    screenWidth = screen.width;
    screenHeight = screen.height;
    textMultiplier = screenWidth / 100;
    imageSizeMultiplier = screenWidth / 100;
  }

  static double scaleText(double size) => size * textMultiplier;
  static double scaleImage(double size) => size * imageSizeMultiplier;
}
