import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/constant.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Bloc/product_bloc.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Bloc/product_event.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/categories_state.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/category_bloc.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/category_event.dart';
import 'package:glitchxscndprjt/features/Search_Page/presentation/Widget/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController searchController = TextEditingController();
  String selectedCategory = 'All';
  String selectedSort = 'Name';
  int? minPrice;
  int? maxPrice;

  final List<String> sortOptions = ['Name', 'Price Asc', 'Price Desc'];
  List<String> categories = ['All'];

  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();

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

  void _applyFilters() {
    setState(() {
      minPrice = int.tryParse(minPriceController.text);
      maxPrice = int.tryParse(maxPriceController.text);
    });

    context.read<ProductBloc>().add(
      SearchFilterSortProductsEvent(
        query: searchController.text,
        category: selectedCategory,
        minPrice: minPrice,
        maxPrice: maxPrice,
      ),
    );
    Navigator.pop(context); // close drawer
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _buildFilterSortDrawer(context),
      appBar: AppBar(
        title: Text("Search Games", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.filter_alt_outlined),
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer();
            },
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
              // Search Bar
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

              // Load categories into dropdown
              BlocListener<UserCategoryBloc, UserCategoryState>(
                listener: (context, state) {
                  if (state is UserCategoryLoaded) {
                    categories = [
                      'All',
                      ...state.categories.map((e) => e.name),
                    ];
                  }
                },
                child: SizedBox.shrink(),
              ),

              // Product List
              ProductDetails(),
            ],
          ),
        ),
      ),
    );
  }

  Drawer _buildFilterSortDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: kBlack,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with title and close button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter & Sort',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: kWhite,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, size: 28),
                    onPressed: () => Navigator.of(context).pop(),
                    tooltip: 'Close',
                    color: kWhite,
                  ),
                ],
              ),
              Divider(height: 30, thickness: 1),

              // Category Dropdown
              InputDecorator(
                decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: TextStyle(color: kWhite),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: kBlack,
                    value: selectedCategory,
                    isExpanded: true,
                    items:
                        categories
                            .map(
                              (cat) => DropdownMenuItem(
                                value: cat,
                                child: Text(
                                  cat,
                                  style: TextStyle(color: kWhite),
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => selectedCategory = val);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Sort Dropdown
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: minPriceController,
                      cursorColor: kWhite,
                      style: TextStyle(color: kWhite),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Min Price',
                        labelStyle: TextStyle(color: kWhite),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: '0',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: kWhite),
                      controller: maxPriceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Max Price',
                        labelStyle: TextStyle(color: kWhite),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: '1000',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              //Price Sort
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: Icon(Icons.clear),
                      label: Text('Clear', style: TextStyle(color: kWhite)),
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'All';
                          selectedSort = sortOptions.first;
                          minPriceController.clear();
                          maxPriceController.clear();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.check),
                      label: Text('Apply'),
                      onPressed: _applyFilters,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
