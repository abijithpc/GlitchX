import 'package:glitchxscndprjt/features/CategoryPage/Domain/Models/product_model.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/Repository/product_repository.dart';

class GetNewlyreleasedGameusecase {
  final ProductRepository repository;

  GetNewlyreleasedGameusecase(this.repository);

  Future<List<ProductModel>> call() async {
    return await repository.getNewlyReleasedGames();
  }
}
