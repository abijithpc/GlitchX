import 'package:glitchxscndprjt/features/HomePage/Domain/Models/category_model.dart';

abstract class UserCategoryrepository {
  Future<List<CategoryModel>> getCategories();
}
