import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/search_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/search_event.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/search_state.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Pages/product_details_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  void _onSearchChanged(String query) {
    context.read<ProductSearchBloc>().add(SearchProducts(query));
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductSearchBloc>().add(SearchProducts(''));
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: ScreenBackGround(
        alignment: Alignment.center,
        widget: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CupertinoSearchTextField(
                  controller: _searchController,
                  placeholder: 'Search categories or products...',
                  onChanged: _onSearchChanged,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  style: const TextStyle(fontSize: 16),
                  backgroundColor: CupertinoColors.systemGrey5,
                  borderRadius: BorderRadius.circular(12),
                  prefixIcon: Icon(
                    CupertinoIcons.search,
                    color: CupertinoColors.inactiveGray,
                    size: 22,
                  ),
                ),
                const SizedBox(height: 20),

                Expanded(
                  child: BlocBuilder<ProductSearchBloc, ProductSearchState>(
                    builder: (context, state) {
                      if (state is ProductSearchLoading) {
                        return const Center(
                          child: CupertinoActivityIndicator(),
                        );
                      } else if (state is ProductSearchLoaded) {
                        final List<ProductModel> results = state.results;
                        if (results.isEmpty) {
                          return const Center(child: Text('No Results Found'));
                        }

                        return ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final product = results[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context, rootNavigator: true).push(
                                  CupertinoPageRoute(
                                    builder:
                                        (_) => ProductDetailsPage(
                                          productId: product.id!,
                                        ),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        bottomLeft: Radius.circular(12),
                                      ),
                                      child: Image.network(
                                        product.imageUrls.first,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (_, __, ___) => const Icon(
                                              CupertinoIcons.photo,
                                            ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0,
                                          vertical: 8.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              product.description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        CupertinoIcons.chevron_forward,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is ProductSearchError) {
                        return Center(child: Text('Error: ${state.message}'));
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        screenHeight: screen.height,
        screenWidth: screen.width,
      ),
    );
  }
}
