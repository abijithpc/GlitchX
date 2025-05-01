import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/widget/screenbackground.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/categories_state.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/category_bloc.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/category_event.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserCategoryBloc>().add(LoadUserCategories());
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: ScreenBackGround(
        screenHeight: screen.height,
        screenWidth: screen.width,
        widget: BlocBuilder<UserCategoryBloc, UserCategoryState>(
          builder: (context, state) {
            if (state is UserCategoryLoading) {
              return const Center(
                child: CupertinoActivityIndicator(radius: 20),
              );
            } else if (state is UserCategoryLoaded) {
              final categories = state.categories;
              if (categories.isEmpty) {
                return const Center(
                  child: Text(
                    'No Categories Available',
                    style: TextStyle(color: Colors.red),
                  ),
                );
              }

              return ListView.builder(
                itemCount: categories.length,
                padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
                itemBuilder: (context, index) {
                  final category = categories[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () {
                        debugPrint("Tapped on ${category.name}");
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.white.withOpacity(0.25),
                                  Colors.white.withOpacity(0.15),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 18,
                              horizontal: 20,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  CupertinoIcons.square_grid_2x2,
                                  color: Color(0xFF6D0EB5),
                                  size: 28,
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    category.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  CupertinoIcons.right_chevron,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is UserCategoryError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
