import 'package:glitchxscndprjt/features/Home_Page/Domain/Models/category_model.dart';
import 'package:glitchxscndprjt/features/Home_Page/Domain/Repository/user_categoryrepository.dart';

class GetusercategoriesUsecase {
  final UserCategoryrepository repository;

  GetusercategoriesUsecase(this.repository);

  Future<List<CategoryModel>> call() => repository.getCategories();
}
