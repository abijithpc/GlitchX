import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';

abstract class ProductSearchState {}

class ProductSearchInitial extends ProductSearchState {}

class ProductSearchLoading extends ProductSearchState {}

class ProductSearchLoaded extends ProductSearchState {
  final List<ProductModel> results;
  ProductSearchLoaded(this.results);
}

class ProductSearchError extends ProductSearchState {
  final String message;
  ProductSearchError(this.message);
}
