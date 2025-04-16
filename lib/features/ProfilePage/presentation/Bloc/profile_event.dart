import 'package:glitchxscndprjt/features/ProfilePage/Data/Models/user_model.dart';

abstract class ProfileEvent {}

class LoadUserProfile extends ProfileEvent {}

class SubmitProfileUpdateEvent extends ProfileEvent {
  final UserModel user;
  SubmitProfileUpdateEvent(this.user);
}