import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Domain/UseCase/getprofile_usecase.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Domain/UseCase/updateuserprofileusecase.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profile_event.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetprofileUsecase getprofileUsecase;
  final Updateuserprofileusecase updateuserProfileUsecase;

  ProfileBloc({
    required this.getprofileUsecase,
    required this.updateuserProfileUsecase,
  }) : super(ProfileIntial()) {
    on<LoadUserProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = await getprofileUsecase();
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError("Failed to Load User Profile"));
      }
    });
    on<SubmitProfileUpdateEvent>((event, emit) async {
      emit(ProfileLoading());
      try {
        await updateuserProfileUsecase(event.user);
        final updatedUser = await getprofileUsecase();
        emit(ProfileLoaded(updatedUser));
      } catch (e) {
        emit(ProfileError("Failed to Update user Profile"));
      }
    });
  }
}
