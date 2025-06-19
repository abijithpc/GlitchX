import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Domain/UseCase/addtowishlist_usecase.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Domain/UseCase/deletewishlist_usecase.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Domain/UseCase/getwishlist_usecase.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/presentation/Bloc/wishlist_event.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/presentation/Bloc/wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final AddtowishlistUsecase addtowishlistUsecase;
  final GetWishlistUsecase getWishlistUsecase;
  final DeleteFromWishlistUsecase deleteFromWishlistUsecase;

  WishlistBloc(
    this.addtowishlistUsecase,
    this.deleteFromWishlistUsecase,
    this.getWishlistUsecase,
  ) : super(WishlistInitial()) {
    on<AddProductToWishList>((event, emit) async {
      emit(WishlistLoading());
      try {
        await addtowishlistUsecase(event.model);
        final updatedList = await getWishlistUsecase(event.model.userId);
        emit(WishlistLoaded(updatedList));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });

    on<LoadWishlistEvent>((event, emit) async {
      emit(WishlistLoading());
      try {
        final list = await getWishlistUsecase(
          event.userId,
        ); // Use event.userId directly
        emit(WishlistLoaded(list));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });

    on<DeleteWishListEvent>((event, emit) async {
   

      try {
        await deleteFromWishlistUsecase(event.userId, event.productId);
        final updatedList = await getWishlistUsecase(event.userId);
        emit(WishlistLoaded(updatedList));
      } catch (e) {
        emit(WishlistError(e.toString()));
      }
    });
  }
}
