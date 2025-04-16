import 'package:glitchxscndprjt/features/ProfilePage/Data/Models/user_model.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Domain/Repository/profile_auth_repository.dart';

class GetprofileUsecase {
  final ProfileAuthRepository repository;

  GetprofileUsecase(this.repository);

  Future<UserModel> call() async{
    return await repository.getUserProfile();
  }
}