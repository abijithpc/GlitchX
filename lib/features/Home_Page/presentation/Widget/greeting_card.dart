import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:glitchxscndprjt/Core/constant.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Pages/category_page.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/Igdb/igdb_bloc.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/Igdb/igdb_event.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/Igdb/igdb_state.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Pages/blockedscreen.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Widget/choice_chips.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Widget/homescreen_titleandsectioncard.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Widget/newly_released_card.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/profile_event.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/profilebloc.dart';
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
  late final Stream<DocumentSnapshot<Map<String, dynamic>>> _blockStream;
  YoutubePlayerController? _currentController;
  late final StreamSubscription _blockSubscription;

  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadUserProfile());
    context.read<IgdbBloc>().add(LoadUpcomingTrailers());

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    final uid = user.uid;

    _blockStream =
        FirebaseFirestore.instance.collection('users').doc(uid).snapshots();

    _blockSubscription = _blockStream.listen((snapshot) {
      final isBlocked = snapshot.data()?['isBlocked'] ?? false;
      if (isBlocked) {
        FirebaseAuth.instance.signOut();
        Navigator.of(
          context,
          rootNavigator: true,
        ).pushReplacement(MaterialPageRoute(builder: (_) => BlockedScreen()));
      }
    });
  }

  @override
  void dispose() {
    _blockSubscription.cancel();
    _currentController?.dispose();
    super.dispose();
  }

  void _initializeController(String videoId) {
    _currentController?.dispose();
    _currentController = YoutubePlayerController(
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
                sectionTitle("Categories", widget.isTablet, kWhite),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context, rootNavigator: true).push(
                      MaterialPageRoute(builder: (_) => const CategoryPage()),
                    );
                  },
                  child: sectionTitle("See All", widget.isTablet, kBlue),
                ),
              ],
            ),
            const SizedBox(height: 10),
            RotatingCategorySelectorListWheel(),
          ],
        ),
      ),
      const SizedBox(height: 24),
      _buildTrailerSection(),
      const SizedBox(height: 20),
      buildSectionCard(
        widget.screenWidth,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Newly Released",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 8),
                NewlyReleasedCard(),
              ],
            ),
          ),
        ),
      ),
    ];

    return AnimationLimiter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          sections.length,
          (int index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 500),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(child: sections[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreetingCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.screenWidth * 0.04),
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
              backgroundColor: kBlack,
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
                    color: kWhite,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.currentDate,
                  style: GoogleFonts.poppins(
                    fontSize: widget.isTablet ? 16 : 14,
                    color: kWhite.withAlpha(179),
                    fontWeight: FontWeight.w400,
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
        child: BlocBuilder<IgdbBloc, IGDBState>(
          builder: (context, state) {
            if (state is IGDBLoading) {
              return const Center(
                child: CupertinoActivityIndicator(radius: 20),
              );
            } else if (state is IGDBLoaded) {
              if (state.trailers.isEmpty) {
                return const Text(
                  "No Upcoming Trailer Found",
                  style: TextStyle(color: Colors.white),
                );
              }

              // Initialize controller if needed
              if (_currentController == null &&
                  state.trailers[_currentPage].videoId != null &&
                  state.trailers[_currentPage].videoId!.isNotEmpty) {
                _initializeController(state.trailers[_currentPage].videoId!);
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Upcoming Game Trailers",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 250,
                    child: PageView.builder(
                      itemCount: state.trailers.length,
                      controller: PageController(viewportFraction: 0.85),
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                          final videoId = state.trailers[index].videoId;
                          if (videoId != null && videoId.isNotEmpty) {
                            _initializeController(videoId);
                          } else {
                            _currentController?.dispose();
                            _currentController = null;
                          }
                        });
                      },
                      itemBuilder: (context, index) {
                        final trailer = state.trailers[index];

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: index == _currentPage ? 0 : 10,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(90),
                                blurRadius: 10,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                if (trailer.videoId != null &&
                                    trailer.videoId!.isNotEmpty &&
                                    index == _currentPage &&
                                    _currentController != null)
                                  _buildYoutubePlayer()
                                else
                                  Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'Assets/image/26691.jpg',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.black.withAlpha(160),
                                            Colors.transparent,
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                        ),
                                      ),
                                    ),
                                  ),
                                if (index != _currentPage ||
                                    _currentController == null)
                                  Positioned.fill(
                                    child: Container(
                                      color: Colors.black.withAlpha(40),
                                    ),
                                  ),
                                if (index != _currentPage ||
                                    _currentController == null)
                                  Center(
                                    child: Icon(
                                      Icons.play_circle_fill,
                                      color: Colors.white.withAlpha(80),
                                      size: 50,
                                    ),
                                  ),
                                Positioned(
                                  bottom: 16,
                                  left: 16,
                                  right: 16,
                                  child: Text(
                                    trailer.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      shadows: [
                                        Shadow(
                                          offset: Offset(0, 1),
                                          blurRadius: 4,
                                          color: Colors.black54,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is IGDBError) {
              return Center(
                child: Text(
                  "Error: ${state.message}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }

  Widget _buildYoutubePlayer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: YoutubePlayer(
        controller: _currentController!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.redAccent,
        ),
        onEnded: (metadata) {
          if (_currentPage <
              (context.read<IgdbBloc>().state as IGDBLoaded).trailers.length -
                  1) {
            setState(() {
              _currentPage += 1;
              final videoId =
                  (context.read<IgdbBloc>().state as IGDBLoaded)
                      .trailers[_currentPage]
                      .videoId;
              if (videoId != null && videoId.isNotEmpty) {
                _initializeController(videoId);
              }
            });
          }
        },
      ),
    );
  }
}
