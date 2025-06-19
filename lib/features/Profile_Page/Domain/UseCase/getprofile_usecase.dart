import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/user_model.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/Repository/profile_auth_repository.dart';

class GetprofileUsecase {
  final ProfileAuthRepository repository;

  GetprofileUsecase(this.repository);

  Future<UserModel> call() async{
    return await repository.getUserProfile();
  }
}