import 'dart:io';
// import 'package:latlong2/latlong.dart' as latLng;
import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/user_model.dart';

abstract class ProfileAuthRepository {
  Future<UserModel> getUserProfile();

  Future<void> updateUserProfile(UserModel user);

  Future<String?> uploadProfileImage(File imageFile);

  // Future<void> updateUserLocation(latLng.LatLng location, String address);
}
