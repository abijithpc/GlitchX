import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/Core/constant.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Widget/shimmer_clipoval.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Pages/wallet_page.dart';

AppBar HomePage_AppBar(String locationText, BuildContext context) {
  return AppBar(
    backgroundColor: kBlack,
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
                  IconButton(
                    onPressed: () {
                      final userId = FirebaseAuth.instance.currentUser!.uid;
                      Navigator.of(context, rootNavigator: true).push(
                        MaterialPageRoute(
                          builder: (context) => WalletPage(userId: userId),
                        ),
                      );
                    },
                    icon: Icon(Icons.wallet, color: Colors.white),
                  ),
                  Icon(Icons.location_on, color: kRed),
                  SizedBox(
                    width: 120.0,
                    child: Text(
                      locationText,
                      style: TextStyle(color: kWhite),
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
