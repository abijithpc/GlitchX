import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/Core/screenbackground.dart';
import 'package:glitchxscndprjt/features/CartPage/Data/Models/cart_model.dart';
import 'package:glitchxscndprjt/features/CartPage/presentation/Bloc/cart_bloc.dart';
import 'package:glitchxscndprjt/features/CartPage/presentation/Bloc/cart_event.dart';
import 'package:glitchxscndprjt/features/CartPage/presentation/Pages/cartpage.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_state.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/widget/showquantity_dialog.dart';

class ProductDetailsPageCard extends StatefulWidget {
  const ProductDetailsPageCard({super.key, required this.product});

  final ProductModel product;

  @override
  State<ProductDetailsPageCard> createState() => _ProductDetailsPageCardState();
}

class _ProductDetailsPageCardState extends State<ProductDetailsPageCard> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final screenWidth = screen.width;
    final screenHeight = screen.height;

    List<String> imageList = _getImageList(widget.product.imageUrls);

    return Scaffold(
      body: ScreenBackGround(
        alignment: Alignment.center,
        screenHeight: screenHeight,
        screenWidth: screenWidth,
        widget: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(screenWidth * 0.02), // Reduced padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: screenHeight * 0.3,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentImageIndex = index;
                          });
                        },
                      ),
                      items:
                          imageList.map((url) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(
                                url,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            );
                          }).toList(),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Center(
                      child: Text(
                        widget.product.name,
                        style: TextStyle(
                          fontSize: screenWidth * 0.08, // Adjusted font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015), // Reduced gap
                    // Full-width Description
                    _buildInfoTile(
                      Icons.description,
                      "Description",
                      widget.product.description,
                      fontSize: screenWidth * 0.04, // Dynamic font size
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),

                    // Row 1: Category & Disk Count
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoTile(
                            Icons.category,
                            "Category",
                            widget.product.category,
                            fontSize: screenWidth * 0.04, // Dynamic font size
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03), // Reduced gap
                        Expanded(
                          child: _buildInfoTile(
                            Icons.album,
                            "Disk Count",
                            widget.product.diskCount.toString(),
                            fontSize: screenWidth * 0.04, // Dynamic font size
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                          ),
                        ),
                      ],
                    ),

                    // Row 2: Price & Stock
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoTile(
                            Icons.attach_money,
                            "Price",
                            "₹${widget.product.price}",
                            textColor: Colors.green,
                            fontSize: screenWidth * 0.04, // Dynamic font size
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03), // Reduced gap
                        Expanded(
                          child: _buildInfoTile(
                            Icons.inventory,
                            "Stock",
                            "${widget.product.stock} in stock",
                            textColor:
                                widget.product.stock > 0
                                    ? Colors.green
                                    : Colors.red,
                            fontSize: screenWidth * 0.04, // Dynamic font size
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                          ),
                        ),
                      ],
                    ),

                    // Row 3: Release Date
                    _buildInfoTile(
                      Icons.calendar_today,
                      "Release Date",
                      "${widget.product.releaseDate.toLocal()}",
                      fontSize: screenWidth * 0.04, // Dynamic font size
                      screenHeight: screenHeight,
                      screenWidth: screenWidth,
                    ),

                    // Row 4: Min & Rec Specs
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoTile(
                            Icons.settings_input_component,
                            "Minimum Specs",
                            widget.product.minSpecs,
                            fontSize: screenWidth * 0.04, // Dynamic font size
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03), // Reduced gap
                        Expanded(
                          child: _buildInfoTile(
                            Icons.settings,
                            "Recommended Specs",
                            widget.product.recSpecs,
                            fontSize: screenWidth * 0.04, // Dynamic font size
                            screenHeight: screenHeight,
                            screenWidth: screenWidth,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Action Buttons
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.03), // Adjusted padding
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        showQuantityDialog(context, (quantity) {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) return;

                          final cartItem = CartModel(
                            userId: user.uid,
                            productId: widget.product.id!,
                            name: widget.product.name,
                            price: widget.product.price,
                            quantity: quantity,
                            imageUrl: widget.product.imageUrls.first,
                            category: widget.product.category,
                          );
                          context.read<CartBloc>().add(
                            AddProductToCartEvent(cartItem),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                children: [
                                  Text(
                                    "Item added Successfully",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CartPage(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Go To Cart",
                                      style: TextStyle(
                                        color: Colors.yellow[700],
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          );
                        });
                      },
                      icon: Icon(Icons.shopping_cart_outlined),
                      label: Text("Add to Cart"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          vertical:
                              screenHeight * 0.015, // Reduced vertical padding
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03), // Reduced gap
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.payment),
                      label: Text("Buy Now"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(
                          vertical:
                              screenHeight * 0.015, // Reduced vertical padding
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    IconData icon,
    String label,
    String value, {
    Color? textColor,
    double? fontSize,
    required double screenWidth,
    required double screenHeight,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: screenHeight * 0.01,
      ), // Reduced vertical margin
      padding: EdgeInsets.all(
        screenWidth * 0.03,
      ), // Adjusted padding based on screen width
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: 24),
          SizedBox(width: screenWidth * 0.03), // Adjusted gap
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize:
                        fontSize ??
                        screenWidth * 0.04, // Default font size if not provided
                  ),
                ),
                SizedBox(height: screenHeight * 0.005), // Reduced gap
                Text(
                  value,
                  style: TextStyle(
                    color: textColor ?? Colors.grey[300],
                    fontSize:
                        fontSize ?? screenWidth * 0.04, // Default font size
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> _getImageList(dynamic imageUrl) {
    if (imageUrl is List<String>) return imageUrl;
    if (imageUrl is String && imageUrl.isNotEmpty) return [imageUrl];
    return [];
  }
}
