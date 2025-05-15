import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Pages/category_page.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/Igdb/igdb_bloc.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/Igdb/igdb_event.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/Igdb/igdb_state.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/choice_chips.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/homescreen_titleandsectioncard.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/newly_released_card.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profile_event.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profilebloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  final Map<String, YoutubePlayerController> _controllers = {};

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadUserProfile());
    context.read<IgdbBloc>().add(LoadUpcomingTrailers());
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  YoutubePlayerController _getController(String videoId) {
    if (_controllers.containsKey(videoId)) {
      return _controllers[videoId]!;
    } else {
      final controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
        ),
      );
      _controllers[videoId] = controller;
      return controller;
    }
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
      _buildTrailerSection(),
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
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const NewlyReleasedCard(),
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
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
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

  Widget _buildTrailerSection() {
    return buildSectionCard(
      widget.screenWidth,
      child: Container(
        width: widget.screenWidth,
        padding: const EdgeInsets.all(12),
        // decoration: BoxDecoration(color: Colors.transparent.withAlpha(20)),
        child: BlocBuilder<IgdbBloc, IGDBState>(
          builder: (context, state) {
            if (state is IGDBLoading) {
              return const Center(
                child: CupertinoActivityIndicator(radius: 20),
              );
            } else if (state is IGDBLoaded) {
              if (state.trailers.isEmpty) {
                return const Text(
                  "No Upcoming trailer Found",
                  style: TextStyle(color: Colors.white),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Upcoming Game Trailer",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 250,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            state.trailers.map((trailer) {
                              if (trailer.videoId == null ||
                                  trailer.videoId!.isEmpty) {
                                return Container(
                                  width: 220,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        trailer.name,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      const Text(
                                        "No trailer available",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                );
                              }

                              final controller = _getController(
                                trailer.videoId!,
                              );

                              return Container(
                                width: 320,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withAlpha(30),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      trailer.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: YoutubePlayer(
                                          controller: controller,
                                          showVideoProgressIndicator: true,
                                          progressIndicatorColor: Colors.red,
                                          progressColors:
                                              const ProgressBarColors(
                                                playedColor: Colors.red,
                                                handleColor: Colors.redAccent,
                                              ),
                                          onReady: () {
                                            // Optional: perform additional actions when ready
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is IGDBError) {
              return Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
