import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/UseCase/get_newlyreleased_gameusecase.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/UseCase/getproduct_usecase.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/UseCase/getproductid_usecase.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Bloc/product_event.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetproductUsecase getproductUsecase;
  final GetproductidUsecase getproductidUsecase;
  final GetNewlyreleasedGameusecase getNewlyreleasedGame;

  ProductBloc(
    this.getproductUsecase,
    this.getproductidUsecase,
    this.getNewlyreleasedGame,
  ) : super(ProductInitial()) {
    on<LoadProductByCategoryEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getproductUsecase(event.category);
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Failed to load products'));
      }
    });

    on<FetchProductDetails>((event, emit) async {
      emit(ProductLoading());
      try {
        final product = await getproductidUsecase(event.productId);
        emit(ProductDetailsLoaded(product)); // Make sure this matches state
      } catch (e) {
        emit(ProductError("Failed to load product details"));
      }
    });

    on<FetchNewlyReleasedGame>((event, emit) async {
      emit(ProductLoading());
      try {
        final games = await getNewlyreleasedGame();
        emit(ProductLoaded(games));
      } catch (e) {
        emit(
          ProductError("Failed to load newly released Games : ${e.toString()}"),
        );
      }
    });
    // product_bloc.dart
    on<SearchFilterSortProductsEvent>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getproductUsecase.searchFilterSortProducts(
          query: event.query,
          category: event.category,
          minPrice: event.minPrice,
          maxPrice: event.maxPrice,
          sortAscending: event.sortAscending,
        );
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Failed to load products'));
      }
    });
  }
}
