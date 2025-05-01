import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/HomePage/Domain/UseCase/getusercategories_usecase.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/categories_state.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/category_event.dart';

class UserCategoryBloc extends Bloc<UserCategoryEvent, UserCategoryState> {
  final GetusercategoriesUsecase getusercategories;

  UserCategoryBloc(this.getusercategories) : super(UserCategoryInitial()) {
    on<LoadUserCategories>((event, emit) async {
      emit(UserCategoryLoading());
      try {
        final categories = await getusercategories();
        print("Categories loaded: $categories"); 
        emit(UserCategoryLoaded(categories));
      } catch (e) {
        print("Error loading categories: $e"); 
        emit(UserCategoryError("Failed to load categories"));
      }
    });
  }
}
