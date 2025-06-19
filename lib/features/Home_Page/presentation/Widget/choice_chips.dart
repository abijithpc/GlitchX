import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Pages/product_list_page.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/categories_state.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/category_bloc.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/category_event.dart';

class RotatingCategorySelectorListWheel extends StatefulWidget {
  const RotatingCategorySelectorListWheel({super.key});

  @override
  State<RotatingCategorySelectorListWheel> createState() =>
      _RotatingCategorySelectorListWheelState();
}

class _RotatingCategorySelectorListWheelState
    extends State<RotatingCategorySelectorListWheel> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<UserCategoryBloc>().add(LoadUserCategories());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCategoryBloc, UserCategoryState>(
      builder: (context, state) {
        if (state is UserCategoryLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserCategoryLoaded) {
          final categories = state.categories;
          if (categories.isEmpty) {
            return const Center(
              child: Text(
                'No categories available',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          return Column(
            children: [
              SizedBox(
                height: 200,
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 60,
                  perspective: 0.003,
                  diameterRatio: 2.0,
                  physics: const FixedExtentScrollPhysics(),
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      if (index < 0 || index >= categories.length) return null;
                      final category = categories[index];
                      final isSelected = index == _selectedIndex;

                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context, rootNavigator: true).push(
                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                      ProductListPage(category: category.name),
                            ),
                          );
                        },
                        child: Card(
                          elevation: isSelected ? 6 : 2,
                          color:
                              isSelected
                                  ? Colors.deepPurpleAccent
                                  : Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              category.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isSelected ? 18 : 14,
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          );
        } else if (state is UserCategoryError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
