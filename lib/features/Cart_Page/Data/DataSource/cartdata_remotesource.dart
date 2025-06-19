import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Data/Models/cart_model.dart';

class CartRemoteDataSource {
  final FirebaseFirestore firestore;

  CartRemoteDataSource(this.firestore);

  Future<void> addProductToCart(CartModel cart) async {
    try {
      final docRef = firestore.collection('cart').doc(cart.userId);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        await docRef.set({
          'cartItems': [cart.toJson()],
        });
      } else {
        final cartData = docSnapshot.data();
        List cartItems = cartData?['cartItems'] ?? [];
        bool itemUpdated = false;

        for (var i = 0; i < cartItems.length; i++) {
          if (cartItems[i]['productId'] == cart.productId) {
            cartItems[i]['quantity'] =
                (cartItems[i]['quantity'] ?? 1) + cart.quantity;
            itemUpdated = true;
            break;
          }
        }
        if (!itemUpdated) {
          cartItems.add(cart.toJson());
        }
        await docRef.update({'cartItems': cartItems});
      }
    } catch (e) {
      throw Exception('Failed to add product to cart: $e');
    }
  }

  Future<List<CartModel>> fetchCartItems(String userId) async {
    try {
      final docSnapshot = await firestore.collection('cart').doc(userId).get();

      if (!docSnapshot.exists) {
        return [];
      }

      final cartData = docSnapshot.data();

      if (cartData == null || cartData['cartItems'] == null) {
        return [];
      }

      List<CartModel> cartItems =
          (cartData['cartItems'] as List)
              .map((itemData) => CartModel.fromJson(itemData))
              .toList();

      return cartItems;
    } catch (e) {
      throw Exception('Failed to fetch cart items: $e');
    }
  }

  Future<void> removeCartItems(String userId, String productId) async {
    final docRef = firestore.collection('cart').doc(userId);

    try {
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        throw Exception('Cart does not exist for user $userId');
      }

      final cartData = docSnapshot.data();
      if (cartData == null || cartData['cartItems'] == null) {
        throw Exception('No cart items found for user $userId');
      }

      List cartItems = List.from(cartData['cartItems']);

      cartItems.removeWhere((item) => item['productId'] == productId);

      await docRef.update({'cartItems': cartItems});
    } catch (e) {
      throw Exception("Error removing item from cart: $e");
    }
  }

  Future<void> clearCart(String userId) async {
    final cartRef = firestore.collection('cart').doc(userId);

    await cartRef.update({'cartItems': []});
  }
}
