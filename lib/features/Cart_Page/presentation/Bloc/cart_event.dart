import 'package:glitchxscndprjt/features/Cart_Page/Data/Models/cart_model.dart';

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
  final String userId;

  RemoveCartItemEvent(this.productId, this.userId);
}

class LoadCartItemsEvent extends CartEvent {
  final String userId;

  LoadCartItemsEvent(this.userId);
}

class ClearCartEvent extends CartEvent {
  final String userId;

  ClearCartEvent(this.userId);
}
