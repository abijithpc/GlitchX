import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:shimmer/shimmer.dart';

//colors
final kWhite = Colors.white;
final kBlack = Colors.black;
final kRed = Colors.red;
final kBlue = Colors.blue;

//TextStyle
final TextKWhite = TextStyle(color: Colors.white);
final TextKBlack = TextStyle(color: Colors.black);
final TextKRed = TextStyle(color: Colors.red);
final TextKBlue = TextStyle(color: Colors.blue);

MarkdownStyleSheet MarkdownStyle() {
  return MarkdownStyleSheet(
    p: TextStyle(color: Colors.white),
    h1: TextStyle(color: Colors.blue, fontSize: 26),
    h2: TextStyle(color: Colors.blueAccent),
    em: TextStyle(color: Colors.purple), // *italic*
    strong: TextStyle(color: Colors.red), // **bold**
    a: TextStyle(color: Colors.orange),
  );
}

Widget buildShimmerLoading() {
  return Column(
    children: [
      Wrap(
        spacing: 12,
        runSpacing: 12,
        alignment: WrapAlignment.center,
        children: List.generate(10, (index) => _shimmerCard()),
      ),
      const SizedBox(height: 20),
      const Padding(
        padding: EdgeInsets.only(left: 12.0, bottom: 12),
        child: Text(
          "📈 Data is Loading",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.white,
              width: double.infinity,
              height: 200,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _shimmerCard() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(height: 28, width: 28, color: Colors.white),
            const SizedBox(height: 6),
            Container(height: 16, width: 40, color: Colors.white),
            const SizedBox(height: 6),
            Container(height: 12, width: 60, color: Colors.white),
          ],
        ),
      ),
    ),
  );
}
