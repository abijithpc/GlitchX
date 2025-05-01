import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/widget/screenbackground.dart';
import 'package:glitchxscndprjt/features/HomePage/Widget/choice_chips.dart';
import 'package:glitchxscndprjt/features/HomePage/Widget/homepage_appbar.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profile_state.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profilebloc.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final profile = context.watch<ProfileBloc>().state;
    String location = '';
    if (profile is ProfileLoaded) {
      location = profile.user.location ?? 'Location not available';
    }
    return Scaffold(
      appBar: HomePage_AppBar(location),
      body: ScreenBackGround(
        widget: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Column(children: [CatergoryChoiceChips()]),
        ),
        screenHeight: screen.height,
        screenWidth: screen.width,
      ),
    );
  }
}
