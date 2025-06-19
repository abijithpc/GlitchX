import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Home_Page/Domain/UseCase/getusercategories_usecase.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/categories_state.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/category_event.dart';

class UserCategoryBloc extends Bloc<UserCategoryEvent, UserCategoryState> {
  final GetusercategoriesUsecase getusercategories;

  UserCategoryBloc(this.getusercategories) : super(UserCategoryInitial()) {
    on<LoadUserCategories>((event, emit) async {
      emit(UserCategoryLoading());
      try {
        final categories = await getusercategories();
        emit(UserCategoryLoaded(categories));
      } catch (e) {
        emit(UserCategoryError("Failed to load categories"));
      }
    });
  }
}
