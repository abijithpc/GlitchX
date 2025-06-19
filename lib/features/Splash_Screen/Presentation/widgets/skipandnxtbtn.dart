import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class nxtskipbtn extends StatelessWidget {
  const nxtskipbtn({super.key, required this.controller});

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.black.withAlpha(10)),
      padding: EdgeInsets.symmetric(horizontal: 4),
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed:
                () => controller.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                ),
            child: Text("Next"),
          ),
          Center(child: SmoothPageIndicator(controller: controller, count: 3)),
          TextButton(
            onPressed: () => controller.jumpToPage(2),
            child: Text("Skip"),
          ),
        ],
      ),
    );
  }
}
