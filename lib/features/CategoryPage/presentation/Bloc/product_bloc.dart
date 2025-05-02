import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/UseCase/getproduct_usecase.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/UseCase/getproductid_usecase.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_event.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetproductUsecase getproductUsecase;
  final GetproductidUsecase getproductidUsecase;

  ProductBloc(this.getproductUsecase, this.getproductidUsecase)
    : super(ProductInitial()) {
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
  }
}
