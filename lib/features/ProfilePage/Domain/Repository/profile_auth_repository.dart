import 'package:glitchxscndprjt/features/ProfilePage/Data/Models/user_model.dart';

abstract class ProfileAuthRepository {
  Future<UserModel> getUserProfile();

  Future<void> updateUserProfile(UserModel user);
}