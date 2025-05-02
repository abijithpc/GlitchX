import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/widget/screenbackground.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/widget/category_card.dart';
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
