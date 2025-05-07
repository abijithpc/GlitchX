import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  // Sample search results for categories or products
  List<String> allItems = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Product A',
    'Product B',
    'Product C',
  ];

  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();
    searchResults = allItems;
  }

  // Function to filter items based on search query
  void _filterSearchResults(String query) {
    setState(() {
      searchQuery = query;
      searchResults =
          allItems
              .where((item) => item.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Search'),
        backgroundColor: CupertinoColors.systemGrey6,
        trailing: GestureDetector(
          onTap: () {
            _searchController.clear();
            _filterSearchResults('');
          },
          child: Icon(CupertinoIcons.clear_circled, size: 28),
        ),
      ),
      child: ScreenBackGround(
        alignment: Alignment.center,
        widget: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Enhanced Search Bar (Styled like iOS)
                CupertinoSearchTextField(
                  controller: _searchController,
                  placeholder: 'Search categories or products...',
                  onChanged: _filterSearchResults,
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

                // Search Results List with custom card style
                Expanded(
                  child:
                      searchResults.isEmpty
                          ? Center(
                            child: Text(
                              'No results found for "$searchQuery"',
                              style: const TextStyle(
                                fontSize: 16,
                                color: CupertinoColors.inactiveGray,
                              ),
                            ),
                          )
                          : ListView.builder(
                            itemCount: searchResults.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // Handle item tap (navigate to details or perform actions)
                                },
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.tag_fill,
                                          color: CupertinoColors.activeBlue,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: Text(
                                            searchResults[index],
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          CupertinoIcons.right_chevron,
                                          color: CupertinoColors.systemGrey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
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
