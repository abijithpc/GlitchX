import 'package:flutter/material.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/widget/screenbackground.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProductDetailsPageCard extends StatelessWidget {
  const ProductDetailsPageCard({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    List<String> imageList = _getImageList(product.imageUrls);

    return Scaffold(
      body: ScreenBackGround(
        widget: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Carousel for images (single or multiple images)
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 250, // Adjust carousel height
                        enlargeCenterPage: true,
                        autoPlay: true,
                        viewportFraction: 1.0,
                      ),
                      items:
                          imageList.map((url) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                url,
                                fit: BoxFit.contain,
                                width: double.infinity,
                              ),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: 16),

                    // Display a set of thumbnail images if there are multiple images
                    if (imageList.length > 1)
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // On thumbnail click, update main image (implement logic if needed)
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    imageList[index],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'No additional images available',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    SizedBox(height: 16),

                    // Product name with a header
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),

                    // Product description
                    _buildSectionHeader('Description'),
                    Text(
                      product.description,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    SizedBox(height: 12),

                    // Category Section
                    _buildSectionHeader('Category'),
                    Text(
                      product.category,
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    SizedBox(height: 12),

                    // Disk Count
                    _buildSectionHeader('Disk Count'),
                    Text(
                      '${product.diskCount}',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    SizedBox(height: 12),

                    // Price
                    _buildSectionHeader('Price'),
                    Text(
                      '₹${product.price}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),

                    // Stock Info
                    _buildSectionHeader('Stock'),
                    Text(
                      '${product.stock} in stock',
                      style: TextStyle(
                        color: product.stock > 0 ? Colors.green : Colors.red,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 12),

                    // Release Date
                    _buildSectionHeader('Release Date'),
                    Text(
                      "${product.releaseDate.toLocal()}",
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    SizedBox(height: 12),

                    // Minimum Specs
                    _buildSectionHeader('Minimum Specs'),
                    Text(
                      product.minSpecs,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    SizedBox(height: 12),

                    // Recommended Specs
                    _buildSectionHeader('Recommended Specs'),
                    Text(
                      product.recSpecs,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    SizedBox(height: 120), // Space for buttons
                  ],
                ),
              ),
            ),

            // Buttons at the bottom
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement the "Buy Now" functionality
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Add to Cart"),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Implement the "Add to Cart" functionality
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text("Buy Now"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        screenHeight: screen.height,
        screenWidth: screen.width,
      ),
    );
  }

  // Helper function to create section headers
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  // Helper function to safely convert imageUrl into a List<String>
  List<String> _getImageList(dynamic imageUrl) {
    if (imageUrl is List<String>) {
      return imageUrl;
    }

    if (imageUrl is String && imageUrl.isNotEmpty) {
      return [imageUrl];
    }

    return [];
  }
}
