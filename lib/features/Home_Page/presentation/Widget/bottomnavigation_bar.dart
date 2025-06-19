import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Ai_Page/presentation/Pages/ai_uipage.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Pages/cartpage.dart';
import 'package:glitchxscndprjt/features/Home_Page/Cubit/navigation_cubit.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Pages/homepage.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Pages/profile_page.dart';
import 'package:glitchxscndprjt/features/Search_Page/presentation/Pages/search_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class PersistentBottomNavigationBar extends StatefulWidget {
  final int intialIndex;
  const PersistentBottomNavigationBar({super.key, this.intialIndex = 0});

  @override
  State<PersistentBottomNavigationBar> createState() =>
      _PersistentBottomNavigationBarState();
}

class _PersistentBottomNavigationBarState
    extends State<PersistentBottomNavigationBar> {
  final PersistentTabController _controller = PersistentTabController();

  final String userId = FirebaseAuth.instance.currentUser?.uid ?? '';

  List<Widget> get _pages => [
    Homepage(),
    SearchPage(),
    CartPage(),
    AiUipage(),
    ProfilePage(),
  ];

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.white,
        activeColorSecondary: Colors.blueAccent,
        inactiveColorPrimary: Colors.grey,
        textStyle: TextStyle(color: Colors.white),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: Colors.white,
        activeColorSecondary: Colors.blueAccent,
        inactiveColorPrimary: Colors.grey,
        textStyle: TextStyle(color: Colors.white),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.shopping_cart),
        title: ("Cart"),
        activeColorPrimary: Colors.white,
        activeColorSecondary: Colors.blueAccent,
        inactiveColorPrimary: Colors.grey,
        textStyle: TextStyle(color: Colors.white),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.smart_toy),
        title: ("ChatBot"),
        activeColorPrimary: Colors.white,
        activeColorSecondary: Colors.blueAccent,
        inactiveColorPrimary: Colors.grey,
        textStyle: TextStyle(color: Colors.white),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person),
        title: ("Profile"),
        activeColorPrimary: Colors.white,
        activeColorSecondary: Colors.blueAccent,
        inactiveColorPrimary: Colors.grey,
        textStyle: TextStyle(color: Colors.white),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationCubit, int>(
      builder: (context, index) {
        _controller.index = index;
        return PersistentTabView(
          backgroundColor: Colors.black,
          context,
          screens: _pages,
          controller: _controller,
          items: _navBarItems(),
          onItemSelected: (int index) {
            context.read<BottomNavigationCubit>().changeTab(index);
          },
          navBarStyle: NavBarStyle.style10,
        );
      },
    );
  }
}
