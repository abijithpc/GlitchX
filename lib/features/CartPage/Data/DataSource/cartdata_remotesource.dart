import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/features/CartPage/Data/Models/cart_model.dart';

class CartRemoteDataSource {
  final FirebaseFirestore firestore;

  CartRemoteDataSource(this.firestore);

  Future<void> addProductToCart(CartModel cart) async {
    try {
      final docRef = firestore.collection('cart').doc(cart.userId);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        // Create a new cart with the first item
        await docRef.set({
          'cartItems': [cart.toJson()],
        });
        print('New cart created for user: ${cart.userId}');
      } else {
        // Update the cartItems array by adding the new product
        final cartData = docSnapshot.data();
        List cartItems = cartData?['cartItems'] ?? [];
        cartItems.add(cart.toJson());
        await docRef.update({'cartItems': cartItems});
        print('Product added to existing cart for user: ${cart.userId}');
      }
    } catch (e) {
      print('Error adding product to cart: $e');
      throw Exception('Failed to add product to cart: $e');
    }
  }

  Future<List<CartModel>> fetchCartItems(String userId) async {
    try {
      print('Fetching cart items for user: $userId');

      // Fetch the document for the user
      final docSnapshot = await firestore.collection('cart').doc(userId).get();

      if (!docSnapshot.exists) {
        print('No cart found for user: $userId');
        return [];
      }

      // Print the whole document data
      final cartData = docSnapshot.data();
      print('Cart data: $cartData');

      if (cartData == null || cartData['cartItems'] == null) {
        print('No cartItems found in the cart for user: $userId');
        return [];
      }

      // If cartItems exist, print them
      print('Cart items found: ${cartData['cartItems']}');

      // Map cartItems to CartModel
      List<CartModel> cartItems =
          (cartData['cartItems'] as List)
              .map((itemData) => CartModel.fromJson(itemData))
              .toList();

      print('Cart items fetched successfully for user: $userId');
      return cartItems;
    } catch (e) {
      print('Error fetching cart items: $e');
      throw Exception('Failed to fetch cart items: $e');
    }
  }
}
