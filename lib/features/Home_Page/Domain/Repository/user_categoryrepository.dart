import 'package:glitchxscndprjt/features/Home_Page/Domain/Models/category_model.dart';

abstract class UserCategoryrepository {
  Future<List<CategoryModel>> getCategories();
}
