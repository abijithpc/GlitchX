import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/CartPage/Domain/UseCase/add_to_cart_usecase.dart';
import 'package:glitchxscndprjt/features/CartPage/Domain/UseCase/get_cart_item_usecase.dart';
import 'package:glitchxscndprjt/features/CartPage/Domain/UseCase/removeproductcart_usecase.dart';
import 'package:glitchxscndprjt/features/CartPage/presentation/Bloc/cart_event.dart';
import 'package:glitchxscndprjt/features/CartPage/presentation/Bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCartUseCase addToCartUseCase;
  final GetCartItemsUseCase getCartItemsUseCase;
  final RemoveproductcartUsecase removeproductcartUsecase;

  CartBloc({
    required this.addToCartUseCase,
    required this.getCartItemsUseCase,
    required this.removeproductcartUsecase,
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
  }
}
