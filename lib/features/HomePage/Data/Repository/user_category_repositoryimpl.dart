import 'package:glitchxscndprjt/features/HomePage/Data/DataSource/user_category_remotedatasource.dart';
import 'package:glitchxscndprjt/features/HomePage/Domain/Models/category_model.dart';
import 'package:glitchxscndprjt/features/HomePage/Domain/Repository/user_categoryrepository.dart';

class UserCategoryRepositoryimpl implements UserCategoryrepository {
  final UserCategoryRemotedatasource remotedatasource;

  UserCategoryRepositoryimpl(this.remotedatasource);

  @override
  Future<List<CategoryModel>> getCategories() {
    return remotedatasource.getCategories();
  }
}
