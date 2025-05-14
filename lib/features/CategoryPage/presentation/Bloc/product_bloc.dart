import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/UseCase/get_newlyreleased_gameusecase.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/UseCase/getproduct_usecase.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/UseCase/getproductid_usecase.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_event.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_state.dart';

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

    on<SortAndFIlterProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await getproductUsecase.call(event.category);

        List<ProductModel> filteredProducts =
            products.where((product) {
              bool matchesCategory =
                  (event.category == 'All Category' ||
                      product.category == event.category);
              bool matchesAvailability =
                  (event.availability == 'All Availability' ||
                      (event.availability == 'In Stock' && product.stock > 0) ||
                      (event.availability == 'Out of Stock' &&
                          product.stock == 0));
              bool matchesRating =
                  (event.rating == 'All Ratings' ||
                      (product.rating >=
                              double.parse(event.rating.split(' ')[0]) &&
                          product.rating <=
                              double.parse(event.rating.split(' ')[2])));
              bool matchesPrice =
                  product.price >= event.minPrice &&
                  product.price <= event.maxPrice;

              return matchesCategory &&
                  matchesAvailability &&
                  matchesRating &&
                  matchesPrice;
            }).toList();

        // Apply sorting
        if (event.sortOption == 'Price Low to High') {
          filteredProducts.sort((a, b) => a.price.compareTo(b.price));
        } else if (event.sortOption == 'Price High to Low') {
          filteredProducts.sort((a, b) => b.price.compareTo(a.price));
        } else if (event.sortOption == 'Name (A-Z)') {
          filteredProducts.sort((a, b) => a.name.compareTo(b.name));
        } else if (event.sortOption == 'Name (Z-A)') {
          filteredProducts.sort((a, b) => b.name.compareTo(a.name));
        } else if (event.sortOption == 'Rating (High to Low)') {
          filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
        } else if (event.sortOption == 'Rating (Low to High)') {
          filteredProducts.sort((a, b) => a.rating.compareTo(b.rating));
        }

        // Emit the sorted and filtered product list
        emit(
          ProductSortedAndFiltered(
            products: filteredProducts,
            selectedSort: event.sortOption,
            selectedAvailability: event.availability,
            selectedRating: event.rating,
            minPrice: event.minPrice,
            maxPrice: event.maxPrice,
          ),
        );
      } catch (e) {
        emit(ProductError('Failed to load products'));
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
  }
}
