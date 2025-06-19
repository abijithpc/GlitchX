import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScreenBackGround extends StatelessWidget {
  ScreenBackGround({
    required this.widget,
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.alignment,
  });

  final double screenHeight;
  final double screenWidth;
  Widget widget;
  Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF2A2D3E), Color(0xFF1C1F2A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Align(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: widget,
        ),
      ),
    );
  }
}
      //  colors: [
      //       Color(0xFF00FFFF), 
      //       Color(0xFF008080), 
      //       Color(0xFF000000), 
      //     ],
      //     stops: [0.0, 0.7, 1.0],
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,

        // colors: [
        //     Color(0xFF090A0F), // Blackened Space
        //     Color(0xFF1D2B53), // Pixel Navy
        //     Color(0xFF6C5CE7), // Arcane Violet
        //     Color(0xFF00CED1), // Synthetic Cyan
        //   ],
        //   begin: Alignment.topRight,
        //   end: Alignment.bottomLeft,
        // ),

        //  colors: [
        //     Color(0xFF0E0B16), // Abyssal Black
        //     Color(0xFF4717F6), // Toxic Purple
        //     Color(0xFF8F00FF), // Neural Violet
        //     Color(0xFF2DE1C2), // Venom Cyan
        //   ],
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,

        // colors: [
        //     Color(0xFF000000), // Death Black
        //     Color(0xFF1A1A2E), // Shadow Core
        //     Color(0xFF16213E), // Terminal Blue
        //     Color(0xFFE94560), // Blood Alert
        //   ],
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,