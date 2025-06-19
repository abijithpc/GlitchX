import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Domain/UseCase/add_to_cart_usecase.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Domain/UseCase/clear_cart_usecase.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Domain/UseCase/get_cart_item_usecase.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Domain/UseCase/removeproductcart_usecase.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_event.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;
  final RemoveproductcartUsecase removeproductcartUsecase;
  final ClearCartUsecase clearCartUsecase;

  CartBloc({
    required this.addToCartUseCase,
    required this.getCartItemsUseCase,
    required this.removeproductcartUsecase,
    required this.clearCartUsecase,
  }) : super(CartInitial()) {
    on<AddProductToCartEvent>((event, emit) async {
      emit(CartLoading());
      try {
        await addToCartUseCase(event.cart);
        add(FetchCartItemsEvent(event.cart.userId)); // auto-refresh
      } catch (e) {
        emit(CartError("Failed to add product to cart"));
      }
    });

    on<FetchCartItemsEvent>((event, emit) async {
      emit(CartLoading());
      try {
        final cartItems = await getCartItemsUseCase(event.userId);
        emit(CartLoaded(cartItems));
      } catch (e) {
        emit(CartError("Failed to fetch cart items"));
      }
    });

    on<RemoveCartItemEvent>((event, emit) async {
      emit(CartLoading());

      try {
        await removeproductcartUsecase.call(event.userId, event.productId);

        final updatedCartItems = await getCartItemsUseCase(event.userId);

        emit(CartLoaded(updatedCartItems));
      } catch (e) {
        emit(CartError("Failed to remove product from cart"));
      }
    });

    on<ClearCartEvent>((event, emit) async {
      debugPrint(
        "🟠 CartBloc received ClearCartEvent for userId: ${event.userId}",
      );

      try {
        await clearCartUsecase(event.userId);
        emit(CartCleared()); // Optional state
      } catch (e) {
        emit(CartError("Failed to clear cart: ${e.toString()}"));
      }
    });
  }
}
