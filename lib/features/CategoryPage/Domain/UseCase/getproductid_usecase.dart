import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/Repository/product_repository.dart';

class GetproductidUsecase {
  final ProductRepository repository;

  GetproductidUsecase(this.repository);

  Future<ProductModel> call(String id){
    return repository.getProductById(id);
  }
}