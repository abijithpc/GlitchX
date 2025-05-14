import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Pages/category_page.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/choice_chips.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/homescreen_titleandsectioncard.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/newly_released_card.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/popular_game_card.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profile_event.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profilebloc.dart';
import 'package:google_fonts/google_fonts.dart';

class GreetingCard extends StatefulWidget {
  const GreetingCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.userPic,
    required this.greetingMessage,
    required this.username,
    required this.isTablet,
    required this.currentDate,
  });

  final double screenWidth;
  final double screenHeight;
  final String userPic;
  final String greetingMessage;
  final String username;
  final bool isTablet;
  final String currentDate;

  @override
  State<GreetingCard> createState() => _GreetingCardState();
}

class _GreetingCardState extends State<GreetingCard> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> sections = [
      _buildGreetingCard(),

      const SizedBox(height: 20),
      buildSectionCard(
        widget.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                sectionTitle("Categories", widget.isTablet, Colors.white),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CategoryPage()),
                    );
                  },
                  child: sectionTitle("See All", widget.isTablet, Colors.blue),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const RotatingCategorySelectorListWheel(),
          ],
        ),
      ),
      const SizedBox(height: 24),
      buildSectionCard(widget.screenWidth, child: PopularGameCard()),
      SizedBox(height: 20),
      buildSectionCard(
        widget.screenWidth,
        child: Container(
          width: widget.screenWidth * 0.010,
          height: widget.screenHeight * 0.30,
          decoration: BoxDecoration(
            color: Colors.transparent.withAlpha(10),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Newly Released",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  NewlyReleasedCard(),
                ],
              ),
            ),
          ),
        ),
      ),
    ];

    return AnimationLimiter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(sections.length, (int index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: sections[index]),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildGreetingCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.04),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: widget.screenWidth * 0.01,
              vertical: 16,
            ),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withAlpha(26),
                  Colors.white.withAlpha(13),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withAlpha(51), width: 1.5),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF4D4D), Color(0xFFFF9F4D)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: widget.isTablet ? 28 : 22,
                    backgroundColor: Colors.black,
                    child: CircleAvatar(
                      radius: widget.isTablet ? 25 : 20,
                      backgroundImage:
                          widget.userPic.isNotEmpty
                              ? NetworkImage(widget.userPic)
                              : const AssetImage(
                                    'Assets/Auth_Icon/icon-5359554_1280.png',
                                  )
                                  as ImageProvider,
                    ),
                  ),
                ),
                SizedBox(width: widget.screenWidth * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.greetingMessage}, ${widget.username}",
                        style: GoogleFonts.poppins(
                          fontSize: widget.isTablet ? 24 : 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.currentDate,
                        style: GoogleFonts.poppins(
                          fontSize: widget.isTablet ? 16 : 14,
                          color: Colors.white.withAlpha(179),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
