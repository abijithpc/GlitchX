import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  ProductLoaded(this.products);
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  ProductError(this.message);
}

class ProductDetailsLoaded extends ProductState {
  final ProductModel product;

  ProductDetailsLoaded(this.product);

  @override
  List<Object> get props => [product];
}
