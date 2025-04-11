import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/CartPage/presentation/Pages/cartPage.dart';
import 'package:glitchxscndprjt/features/HomePage/Cubit/navigation_cubit.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Pages/homepage.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Pages/profile_page.dart';
import 'package:glitchxscndprjt/features/SearchPage/presentation/Pages/search_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class PersistentBottomNavigationBar extends StatelessWidget {
  PersistentBottomNavigationBar({super.key});

  final PersistentTabController _controller = PersistentTabController();

  final List<Widget> _pages = [
    Homepage(),
    SearchPage(),
    Cartpage(),
    ProfilePage(),
  ];

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Colors.white, // <-- White for visibility
        activeColorSecondary: Colors.blueAccent, // optional ripple/outline
        inactiveColorPrimary: Colors.grey,
        textStyle: TextStyle(color: Colors.white), // also helpful
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
