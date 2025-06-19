import 'package:glitchxscndprjt/features/Category_Page/Domain/Models/product_model.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/Repository/product_repository.dart';

class GetNewlyreleasedGameusecase {
  final ProductRepository repository;

  GetNewlyreleasedGameusecase(this.repository);

  Future<List<ProductModel>> call() async {
    return await repository.getNewlyReleasedGames();
  }
}
