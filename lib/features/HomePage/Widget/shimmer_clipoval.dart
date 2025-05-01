import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerClipOval extends StatelessWidget {
  final String logoPath;

  const ShimmerClipOval({super.key, required this.logoPath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Default background color
            shape: BoxShape.circle,
          ),
          child: Stack(
            children: [
              // Background shimmer effect
              Shimmer.fromColors(
                baseColor: Colors.black,
                highlightColor: Colors.grey[100]!,
                period: Duration(seconds: 2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black, // Same background color for shimmer
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              // Your logo in the front, unaffected by shimmer
              Center(
                child: Image.asset(
                  logoPath,
                  fit: BoxFit.contain,
                  width: 100, // You can adjust this based on your logo size
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
