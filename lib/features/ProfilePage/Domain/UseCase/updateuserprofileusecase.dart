import 'package:glitchxscndprjt/features/ProfilePage/Data/Models/user_model.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Domain/Repository/profile_auth_repository.dart';

class Updateuserprofileusecase {
  final ProfileAuthRepository repository;

  Updateuserprofileusecase(this.repository);

  Future<void> call(UserModel user) async{
    await repository.updateUserProfile(user);
  }
}