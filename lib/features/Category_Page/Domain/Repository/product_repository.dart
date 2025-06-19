import 'package:glitchxscndprjt/features/Category_Page/Domain/Models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProductsByCategory(String category);

  Future<ProductModel> getProductById(String id);

  Future<List<ProductModel>> searchProducts({
    required String query,
    required String category,
    int? minPrice,
    int? maxPrice,
    required bool sortAscending,
  });

  Future<List<ProductModel>> getNewlyReleasedGames();
}
