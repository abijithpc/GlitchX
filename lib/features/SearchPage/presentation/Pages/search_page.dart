import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_event.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_state.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/categories_state.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/category_bloc.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/category_event.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  String selectedCategory = 'All';
  String selectedSort = 'Name';

  final List<String> sortOptions = ['Name', 'Price Asc', 'Price Desc'];
  List<String> categories = ['All'];
  int? minPrice;
  int? maxPrice;

  void _showFilterSortDialog() async {
    String tempCategory = selectedCategory;
    String tempSort = selectedSort;
    TextEditingController tempMinController = TextEditingController(
      text: minPrice?.toString() ?? '',
    );
    TextEditingController tempMaxController = TextEditingController(
      text: maxPrice?.toString() ?? '',
    );

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter & Sort'),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Category'),
                      value: tempCategory,
                      items:
                          categories
                              .map(
                                (cat) => DropdownMenuItem(
                                  value: cat,
                                  child: Text(cat),
                                ),
                              )
                              .toList(),
                      onChanged:
                          (val) => setState(() => tempCategory = val ?? 'All'),
                    ),
                    SizedBox(height: 15),
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(labelText: 'Sort By'),
                      value: tempSort,
                      items:
                          sortOptions
                              .map(
                                (sort) => DropdownMenuItem(
                                  value: sort,
                                  child: Text(sort),
                                ),
                              )
                              .toList(),
                      onChanged:
                          (val) => setState(() => tempSort = val ?? 'Name'),
                    ),
                    SizedBox(height: 15),
                    TextField(
                      controller: tempMinController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Min Price'),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: tempMaxController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'Max Price'),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'category': tempCategory,
                  'sortBy': tempSort,
                  'minPrice': double.tryParse(tempMinController.text),
                  'maxPrice': double.tryParse(tempMaxController.text),
                });
              },
              child: Text('Apply'),
            ),
          ],
        );
      },
    );

    if (result != null) {
      setState(() {
        selectedCategory = result['category'];
        selectedSort = result['sortBy'];
        minPrice = result['minPrice'];
        maxPrice = result['maxPrice'];
      });

      context.read<ProductBloc>().add(
        SearchFilterSortProductsEvent(
          query: searchController.text,
          category: selectedCategory,
          minPrice: minPrice,
          maxPrice: maxPrice,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<UserCategoryBloc>().add(LoadUserCategories());
    context.read<ProductBloc>().add(
      SearchFilterSortProductsEvent(
        query: '',
        category: selectedCategory,
        minPrice: minPrice,
        maxPrice: maxPrice,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Games", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            onPressed: _showFilterSortDialog,
          ),
        ],
      ),
      body: ScreenBackGround(
        screenHeight: screen.height,
        screenWidth: screen.width,
        alignment: Alignment.topCenter,
        widget: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search Bar in body
              Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(12),
                child: TextField(
                  controller: searchController,
                  onChanged: (query) {
                    context.read<ProductBloc>().add(
                      SearchFilterSortProductsEvent(
                        query: query,
                        category: selectedCategory,
                        minPrice: minPrice,
                        maxPrice: maxPrice,
                      ),
                    );
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search products...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Listen for categories
              BlocListener<UserCategoryBloc, UserCategoryState>(
                listener: (context, state) {
                  if (state is UserCategoryLoaded) {
                    setState(() {
                      categories = [
                        'All',
                        ...state.categories.map((e) => e.name),
                      ];
                    });
                  }
                },
                child: SizedBox.shrink(),
              ),

              // Product List
              Expanded(
                child: BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is ProductLoaded) {
                      if (state.products.isEmpty) {
                        return Center(child: Text('No products found.'));
                      }
                      return ListView.separated(
                        itemCount: state.products.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final product = state.products[index];
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(12),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  product.imageUrls.first,
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) =>
                                          Icon(Icons.image_not_supported),
                                ),
                              ),
                              title: Text(
                                product.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(product.category),
                              trailing: Text(
                                '\₹${product.price}',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is ProductError) {
                      return Center(child: Text(state.message));
                    }
                    return Center(child: Text('Search for products'));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
