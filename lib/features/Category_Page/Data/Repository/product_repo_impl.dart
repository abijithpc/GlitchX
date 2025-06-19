import 'package:glitchxscndprjt/features/Category_Page/Data/DataSource/product_remote_datasource.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/Models/product_model.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/Repository/product_repository.dart';

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
  Future<List<ProductModel>> searchProducts({
    required String query,
    required String category,
    int? minPrice,
    int? maxPrice,
    required bool sortAscending,
  }) async {
    return await remotedatasource.searchProducts(
      query: query,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
      sortAscending: sortAscending,
    );
  }

  @override
  Future<List<ProductModel>> getNewlyReleasedGames() async {
    final models = await remotedatasource.getNewlyReleasedGames();
    return models.map((e) => e.toEntity()).toList();
  }
}
