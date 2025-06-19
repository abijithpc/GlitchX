import 'package:glitchxscndprjt/features/Home_Page/Domain/Models/category_model.dart';

abstract class UserCategoryState {}

class UserCategoryInitial extends UserCategoryState {}

class UserCategoryLoading extends UserCategoryState {}

class UserCategoryLoaded extends UserCategoryState {
  final List<CategoryModel> categories;

  UserCategoryLoaded(this.categories);
}

class UserCategoryError extends UserCategoryState {
  final String message;

  UserCategoryError(this.message);
}
