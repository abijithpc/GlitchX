import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getProductsByCategory(String category);

  Future<ProductModel> getProductById(String id);

  Future<List<ProductModel>> searchProducts(String query);

  Future<List<ProductModel>> getNewlyReleasedGames();
}
