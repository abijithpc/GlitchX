import 'dart:io';
// import 'package:latlong2/latlong.dart' as latLng;
import 'package:glitchxscndprjt/features/Profile_Page/Data/Models/user_model.dart';

abstract class ProfileEvent {}

class LoadUserProfile extends ProfileEvent {}

class SubmitProfileUpdateEvent extends ProfileEvent {
  final File? imageFile;
  final UserModel user;
  SubmitProfileUpdateEvent(this.user, {this.imageFile});
}

class UpdateLocationEvent extends ProfileEvent {
  final String address;

  UpdateLocationEvent(this.address);
}

abstract class ProductDetailsEvent {}

class LoadProductDetails extends ProductDetailsEvent {
  final String productId;

  LoadProductDetails(this.productId);
}
