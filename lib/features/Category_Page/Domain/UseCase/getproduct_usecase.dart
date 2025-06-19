import 'package:glitchxscndprjt/features/Category_Page/Domain/Models/product_model.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/Repository/product_repository.dart';

class GetproductUsecase {
  final ProductRepository repository;

  GetproductUsecase(this.repository);

  Future<List<ProductModel>> call(String category) {
    return repository.getProductsByCategory(category);
  }

  // get_product_usecase.dart
  Future<List<ProductModel>> searchFilterSortProducts({
    required String query,
    required String category,
    int? minPrice,
    int? maxPrice,
    required bool sortAscending,
  }) {
    return repository.searchProducts(
      query: query,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sortAscending: sortAscending,
    );
  }
}
