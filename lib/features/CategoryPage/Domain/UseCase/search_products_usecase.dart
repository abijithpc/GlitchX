import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/Repository/product_repository.dart';

class SearchProductsUsecase {
  final ProductRepository repository;

  SearchProductsUsecase(this.repository);

  Future<List<ProductModel>> call(String query) {
    return repository.searchProducts(query);
  }
}
