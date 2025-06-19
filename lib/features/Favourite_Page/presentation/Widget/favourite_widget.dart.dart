// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Data/Models/cart_model.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_bloc.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_event.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Pages/cartpage.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/widget/showquantity_dialog.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Data/Models/favourite_model.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/presentation/Bloc/wishlist_bloc.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/presentation/Bloc/wishlist_event.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/presentation/Pages/wishlist_page.dart';

class Favourite_Widget extends StatelessWidget {
  const Favourite_Widget({
    super.key,
    required this.screen,
    required this.item,
    required this.widget,
  });

  final Size screen;
  final FavouriteModel item;
  final WishlistPage widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Image
        Container(
          width: screen.width * 0.30,
          height: screen.height * 0.15,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(16),
            ),
            image: DecorationImage(
              image: NetworkImage(item.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),

        // Product Info + Buttons
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${item.price.toString()}',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // ignore: unnecessary_null_comparison
                if (item.category != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Category: ${item.category}',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
                const SizedBox(height: 10),
                Row(
                  children: [
                    // Add to Cart Button
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        showQuantityDialog(context, (quantity) {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user == null) return;

                          final cartItem = CartModel(
                            userId: user.uid,
                            productId: item.productId,
                            name: item.name,
                            price: item.price,
                            quantity: quantity,
                            imageUrl: item.imageUrl,
                            category: item.category,
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
                      icon: const Icon(Icons.shopping_cart, size: 16),
                      label: const Text(
                        'Add to Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Delete Button
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        context.read<WishlistBloc>().add(
                          DeleteWishListEvent(item.userId, item.productId),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
