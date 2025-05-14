import 'package:glitchxscndprjt/features/CategoryPage/Data/DataSource/product_remote_datasource.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/Repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remotedatasource;

  ProductRepositoryImpl(this.remotedatasource);

  @override
  Future<List<ProductModel>> getProductsByCategory(String category) {
    return remotedatasource.getProductsByCategory(category);
  }

  @override
  Future<ProductModel> getProductById(String id) {
    return remotedatasource.getProductById(id);
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) {
    return remotedatasource.searchProducts(query);
  }

  @override
  Future<List<ProductModel>> getNewlyReleasedGames() async {
    final models = await remotedatasource.getNewlyReleasedGames();
    return models.map((e) => e.toEntity()).toList();
  }
}
