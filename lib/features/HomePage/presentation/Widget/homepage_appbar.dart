import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/shimmer_clipoval.dart';

AppBar HomePage_AppBar(String locationText) {
  return AppBar(
    backgroundColor: Colors.black,
    leading: Padding(
      padding: const EdgeInsets.all(7.0),
      child: ShimmerClipOval(
        logoPath: 'Assets/Logo/Untitled_design-removebg-preview.png',
      ),
    ),
    actions: [
      Center(
        child: Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.red),
                  SizedBox(
                    width: 120.0,
                    child: Text(
                      locationText,
                      style: TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
