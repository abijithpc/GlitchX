import 'package:glitchxscndprjt/features/CartPage/Data/Models/cart_model.dart';

abstract class CartEvent {}

class AddProductToCartEvent extends CartEvent {
  final CartModel cart;

  AddProductToCartEvent(this.cart);
}

class FetchCartItemsEvent extends CartEvent {
  final String userId;

  FetchCartItemsEvent(this.userId);
}

class RemoveCartItemEvent extends CartEvent {
  final String productId;

  RemoveCartItemEvent(this.productId);
}
