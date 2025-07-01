import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/constant.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/widget/category_card.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/categories_state.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/category_bloc.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/category_event.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
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
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: ScreenBackGround(
        alignment: Alignment.center,
        screenHeight: screen.height,
        screenWidth: screen.width,
        widget: BlocBuilder<UserCategoryBloc, UserCategoryState>(
          builder: (context, state) {
            if (state is UserCategoryLoading) {
              return buildShimmerLoading();
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

              return CategoryCard(categories: categories);
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
