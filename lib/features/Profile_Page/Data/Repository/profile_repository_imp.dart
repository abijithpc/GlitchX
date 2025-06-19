import 'dart:io';
import 'package:glitchxscndprjt/features/Profile_Page/Data/DataSource/profile_remote_datasource.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/user_model.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/Repository/profile_auth_repository.dart';

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

  @override
  Future<String?> uploadProfileImage(File imageFile) =>
      remoteDatasource.uploadImage(imageFile);

  // Future<void> updateUserLocation(
  //   latLng.LatLng location,
  //   String address,
  // ) async {
  //   return await remoteDatasource.updateUserLocation(location, address);
  // }
}
