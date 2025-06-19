import 'package:glitchxscndprjt/features/Home_Page/Data/DataSource/user_category_remotedatasource.dart';
import 'package:glitchxscndprjt/features/Home_Page/Domain/Models/category_model.dart';
import 'package:glitchxscndprjt/features/Home_Page/Domain/Repository/user_categoryrepository.dart';

class UserCategoryRepositoryimpl implements UserCategoryrepository {
  final UserCategoryRemotedatasource remotedatasource;

  UserCategoryRepositoryimpl(this.remotedatasource);

  @override
  Future<List<CategoryModel>> getCategories() {
    return remotedatasource.getCategories();
  }
}
