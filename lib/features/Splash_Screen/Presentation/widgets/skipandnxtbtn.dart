import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NxtSkipBtn extends StatelessWidget {
  final PageController controller;
  final double screenWidth;
  final double screenHeight;

  const NxtSkipBtn({
    super.key,
    required this.controller,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    final double textFont = screenWidth * 0.02;
    final double dotSize = screenWidth * 0.010;

    return Container(
      height: screenHeight * 0.1,
      decoration: const BoxDecoration(color: Colors.black),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed:
                () => controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
            child: Text(
              "Next",
              style: TextStyle(
                fontSize: textFont,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          SmoothPageIndicator(
            controller: controller,
            count: 3,
            effect: WormEffect(
              dotHeight: dotSize,
              dotWidth: dotSize,
              activeDotColor: Colors.white,
              dotColor: Colors.white30,
            ),
          ),
          TextButton(
            onPressed: () => controller.jumpToPage(2),
            child: Text(
              "Skip",
              style: TextStyle(
                fontSize: textFont,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
