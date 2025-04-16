import 'package:glitchxscndprjt/features/ProfilePage/Data/DataSource/profile_remote_datasource.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Data/Models/user_model.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Domain/Repository/profile_auth_repository.dart';

class ProfileAuthRepositoryImp implements ProfileAuthRepository {
  final ProfileRemoteDatasource remoteDatasource;

  ProfileAuthRepositoryImp(this.remoteDatasource);

  @override
  Future<UserModel> getUserProfile() {
    return remoteDatasource.getUserProfile();
  }

  @override
  Future<void> updateUserProfile(UserModel user) {
    return remoteDatasource.updateUserProfile(user);
  }
}
