import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/UseCase/search_products_usecase.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/search_event.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/search_state.dart';

class ProductSearchBloc extends Bloc<ProductSearchEvent, ProductSearchState> {
  final SearchProductsUsecase searchProductsUsecase;

  ProductSearchBloc(this.searchProductsUsecase)
    : super(ProductSearchInitial()) {
    on<SearchProducts>((event, emit) async {
      emit(ProductSearchLoading());
      try {
        final result = await searchProductsUsecase(event.query);
        emit(ProductSearchLoaded(result));
      } catch (e) {
        emit(ProductSearchError("Something went Wrong: ${e.toString()}"));
      }
    });
  }
}
