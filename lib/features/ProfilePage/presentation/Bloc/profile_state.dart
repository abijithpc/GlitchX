import 'package:glitchxscndprjt/features/ProfilePage/Data/Models/user_model.dart';

abstract class ProfileState {}

class ProfileIntial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;

  ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}

class EditProfileInitial extends ProfileState {}

class EditProfileLoading extends ProfileState {}

class EditProfileSuccess extends ProfileState {}

class EditProfileFailure extends ProfileState {
  final String message;
  EditProfileFailure(this.message);
}

class ProfileLocationUpdated extends ProfileState {
  final String message;

  ProfileLocationUpdated({this.message = "Location updated successfully"});
}
