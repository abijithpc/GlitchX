import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/choice_chips.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/homepage_appbar.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/popular_game_card.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profile_state.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profilebloc.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final screenHeight = media.size.height;
    final screenWidth = media.size.width;
    final isTablet = screenWidth > 600;

    final profile = context.watch<ProfileBloc>().state;
    String location = '';
    if (profile is ProfileLoaded) {
      location = profile.user.location ?? 'Location not available';
    }

    return Scaffold(
      appBar: HomePage_AppBar(location),
      body: ScreenBackGround(
        alignment: Alignment.topCenter,
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        widget: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: screenWidth * 0.08,
            bottom: screenHeight * 0.02,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionCard(
                screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Categories", isTablet),
                    const SizedBox(height: 10),
                    const CatergoryChoiceChips(),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _buildSectionCard(
                screenWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle("Popular Games", isTablet),
                    const SizedBox(height: 10),
                    const PopularGameCard(),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title, bool isTablet) {
    return Text(
      title,
      style: TextStyle(
        fontSize: isTablet ? 26 : 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSectionCard(double screenWidth, {required Widget child}) {
    return Container(
      width: screenWidth,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}
