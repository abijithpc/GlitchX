import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/getprofile_usecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/updateprofileimage_usecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/updateuserprofileusecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/profile_event.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetprofileUsecase getprofileUsecase;
  final Updateuserprofileusecase updateuserProfileUsecase;
  final UpdateprofileimageUsecase updateprofileimageUsecase;
  // final UpdateLocationUsecase updateLocationUsecase;

  ProfileBloc({
    required this.getprofileUsecase,
    required this.updateuserProfileUsecase,
    required this.updateprofileimageUsecase,
    // required this.updateLocationUsecase,
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
        String? imageUrl;

        if (event.imageFile != null) {
          imageUrl = await updateprofileimageUsecase.execute(event.imageFile!);
        }

        final updatedUser = event.user.copyWith(
          profilePictureUrl: imageUrl ?? event.user.profilePictureUrl,
        );
        await updateuserProfileUsecase.call(updatedUser);
        emit(ProfileLoaded(updatedUser));
      } catch (e) {
        emit(ProfileError("Failed to Update user Profile"));
      }
    });

    // on<UpdateLocationEvent>((event, emit) async {
    //   emit(ProfileLoading());
    //   try {
    //     await updateLocationUsecase.execute(event.location, event.address);
    //     emit(ProfileLocationUpdated());
    //   } catch (e) {
    //     emit(ProfileError("Failed to update location"));
    //   }
    // });
    
  }
}
