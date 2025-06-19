import 'package:glitchxscndprjt/features/Category_Page/Domain/Models/product_model.dart';

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

  // @override
  List<Object> get props => [product];
}

class ProductSortedAndFiltered extends ProductState {
  final List<ProductModel> products;
  final String selectedSort;
  final String selectedAvailability;
  final String selectedRating;
  final double minPrice;
  final double maxPrice;

  ProductSortedAndFiltered({
    required this.products,
    required this.selectedSort,
    required this.selectedAvailability,
    required this.selectedRating,
    required this.minPrice,
    required this.maxPrice,
  });
  ProductSortedAndFiltered copyWith({
    List<ProductModel>? products,
    String? selectedSort,
    String? selectedAvailability,
    String? selectedRating,
    double? minPrice,
    double? maxPrice,
  }) {
    return ProductSortedAndFiltered(
      products: products ?? this.products,
      selectedSort: selectedSort ?? this.selectedSort,
      selectedAvailability: selectedAvailability ?? this.selectedAvailability,
      selectedRating: selectedRating ?? this.selectedRating,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }
}
