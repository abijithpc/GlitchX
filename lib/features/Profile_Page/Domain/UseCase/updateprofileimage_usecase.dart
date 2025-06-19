import 'dart:io';

import 'package:glitchxscndprjt/features/Profile_Page/Domain/Repository/profile_auth_repository.dart';

class UpdateprofileimageUsecase {
  final ProfileAuthRepository repository;

  UpdateprofileimageUsecase(this.repository);

  Future<String?> execute(File imageFile) {
    return repository.uploadProfileImage(imageFile);
  }
}
