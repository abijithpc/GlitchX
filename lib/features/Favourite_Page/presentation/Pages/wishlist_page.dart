import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/constant.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/presentation/Bloc/wishlist_bloc.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/presentation/Bloc/wishlist_event.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/presentation/Bloc/wishlist_state.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/presentation/Widget/favourite_widget.dart.dart';

class WishlistPage extends StatefulWidget {
  final String userId;

  const WishlistPage({super.key, required this.userId});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void initState() {
    super.initState();
    context.read<WishlistBloc>().add(LoadWishlistEvent(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Wishlist',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 4,
      ),
      body: ScreenBackGround(
        screenHeight: screen.height,
        screenWidth: screen.width,
        alignment: Alignment.topCenter,
        widget: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            if (state is WishlistInitial || state is WishlistLoading) {
              return buildShimmerLoading();
            } else if (state is WishlistLoaded) {
              final wishlist = state.wishlist;

              if (wishlist.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.favorite_border,
                        size: 100,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Your wishlist is empty!',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: wishlist.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                itemBuilder: (context, index) {
                  final item = wishlist[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    color: Colors.white,
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {},
                      child: Favourite_Widget(
                        screen: screen,
                        item: item,
                        widget: widget,
                      ),
                    ),
                  );
                },
              );
            } else if (state is WishlistError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
