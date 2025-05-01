import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Pages/category_page.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/categories_state.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/category_bloc.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/category_event.dart';

class CatergoryChoiceChips extends StatefulWidget {
  const CatergoryChoiceChips({super.key});

  @override
  _CatergoryChoiceChipsState createState() => _CatergoryChoiceChipsState();
}

class _CatergoryChoiceChipsState extends State<CatergoryChoiceChips> {
  String? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    context.read<UserCategoryBloc>().add(LoadUserCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<UserCategoryBloc, UserCategoryState>(
          builder: (context, state) {
            if (state is UserCategoryLoading) {
              return const Center(
                child: CupertinoActivityIndicator(radius: 20),
              );
            } else if (state is UserCategoryLoaded) {
              final categories = state.categories;
              if (categories.isEmpty) {
                return const Text(
                  'No Categories Available',
                  style: TextStyle(color: Colors.red),
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          categories.length > 5 ? 5 : categories.length,
                          (index) {
                            final category = categories[index];
                            final isSelected =
                                selectedCategoryId == category.id;

                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedCategoryId = category.id;
                                  });

                                  // 🚀 Emit event to fetch games under this category
                                  // context.read<GameBloc>().add(
                                  //   LoadGamesByCategory(
                                  //     categoryId: category.id,
                                  //   ),
                                  // );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: isSelected ? 16 : 10,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient:
                                        isSelected
                                            ? const LinearGradient(
                                              colors: [
                                                Color(0xFF6D0EB5),
                                                Color(0xFF4059F1),
                                              ],
                                            )
                                            : const LinearGradient(
                                              colors: [
                                                Color(0xFFE0E0E0),
                                                Color(0xFFFAFAFA),
                                              ],
                                            ),
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 4,
                                        offset: const Offset(1, 2),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    category.name,
                                    style: TextStyle(
                                      fontSize: isSelected ? 14 : 12,
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.black87,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const ChoiceChipsArrow(),
                ],
              );
            } else if (state is UserCategoryError) {
              return Text(state.message);
            }
            return const SizedBox.shrink();
          },
        ),

        const SizedBox(height: 10),
      ],
    );
  }
}

class ChoiceChipsArrow extends StatelessWidget {
  const ChoiceChipsArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        iconColor: WidgetStateProperty.all<Color?>(Colors.white),
      ),
      icon: const Icon(Icons.arrow_forward_ios),
      onPressed: () {
        Navigator.of(
          context,
          rootNavigator: true,
        ).push(MaterialPageRoute(builder: (context) => CategoryPage()));
      },
    );
  }
}
