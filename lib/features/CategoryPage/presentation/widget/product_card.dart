import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/CartPage/Data/Models/cart_model.dart';
import 'package:glitchxscndprjt/features/CartPage/presentation/Bloc/cart_bloc.dart';
import 'package:glitchxscndprjt/features/CartPage/presentation/Bloc/cart_event.dart';
import 'package:glitchxscndprjt/features/CartPage/presentation/Pages/cartPage.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Pages/product_details_page.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/widget/showquantity_dialog.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600 ? 2 : 4; // Responsive grid

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.7,
      ),
      itemCount: products.length,
      itemBuilder: (_, index) {
        print('Loaded ${products.length} products');
        final product = products[index];
        print('Image URL: ${product.imageUrls}');
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) => ProductDetailsPage(
                      productId: product.id ?? 'defaultId',
                    ), // Passing the product's id
              ),
            );
          },
          child: Card(
            color: Colors.white,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Product Image
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.network(
                        // Check if product.imageUrl is a list or single URL
                        product.imageUrls.isNotEmpty
                            ? product.imageUrls[0] // For a list of URLs
                            : 'https://via.placeholder.com/150', // Fallback URL if no image URL is provided
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          // Log the error for debugging
                          print('Error loading image: $error');
                          return const Center(
                            child: Icon(Icons.broken_image),
                          ); // Show a broken image icon
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            // Image has finished loading
                            print(
                              'Image loaded successfully: ${product.imageUrls.isNotEmpty ? product.imageUrls[0] : 'No Image'}',
                            );
                            return child;
                          } else {
                            // Image is still loading
                            print(
                              'Loading image: ${product.imageUrls.isNotEmpty ? product.imageUrls[0] : 'No Image'}',
                            );
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),

                // Product Details
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 6.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '₹${product.price}',
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Favorite and Add to Cart Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () {},
                            tooltip: "Add to Wishlist",
                            visualDensity: VisualDensity.compact,
                            iconSize: 20,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                showQuantityDialog(context, (quantity) {
                                  final user =
                                      FirebaseAuth.instance.currentUser;
                                  if (user == null) return;

                                  final cartItem = CartModel(
                                    userId: user.uid,
                                    productId: product.id!,
                                    name: product.name,
                                    price: product.price,
                                    quantity: quantity,
                                    imageUrl: product.imageUrls.first,
                                    category: product.category,
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
                                                  builder:
                                                      (context) => CartPage(),
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                textStyle: const TextStyle(fontSize: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: const Text("Add to Cart"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
