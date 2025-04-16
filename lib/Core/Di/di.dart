import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Data Layer
import 'package:glitchxscndprjt/features/Auth/Data/DataSource/firebase_auth_remote_datasource.dart';
import 'package:glitchxscndprjt/features/Auth/Data/Repository/auth_repository_impl.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/Repository/auth_repository.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/UseCase/google_signin_usecase.dart';

// Domain Layer - UseCases
import 'package:glitchxscndprjt/features/Auth/Domain/UseCase/signup_usecase.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/UseCase/login_usecase.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/UseCase/resetpassword_usecase.dart';
import 'package:glitchxscndprjt/features/Auth/Domain/UseCase/emailverification_usecase.dart';

// Presentation Layer - Bloc
import 'package:glitchxscndprjt/features/Auth/presentation/Bloc/auth_bloc.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Data/DataSource/profile_remote_datasource.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Data/Repository/profile_repository_imp.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Domain/Repository/profile_auth_repository.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Domain/UseCase/getprofile_usecase.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Domain/UseCase/updateuserprofileusecase.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profilebloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // 🔥 Firebase core dependencies
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // 🌐 Data Source
  sl.registerLazySingleton<FirebaseAuthRemoteDataSource>(
    () => FirebaseAuthRemoteDataSource(auth: sl(), firestore: sl()),
  );
  sl.registerLazySingleton(() => ProfileRemoteDatasource(sl(), sl()));

  // 📦 Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProfileAuthRepository>(
    () => ProfileAuthRepositoryImp(sl()),
  );

  // ✅ UseCases
  sl.registerLazySingleton(() => SignupUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => ResetpasswordUsecase(sl()));
  sl.registerLazySingleton(() => EmailverificationUsecase(sl()));
  sl.registerLazySingleton(() => GetprofileUsecase(sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => Updateuserprofileusecase(sl()));

  // 🔁 Bloc
  sl.registerFactory(
    () => AuthBloc(
      signupUsecase: sl(),
      loginUsecase: sl(),
      resetPasswordUsecase: sl(),
      emailVerificationUsecase: sl(),
      authRepository: sl(),
      signInWithGoogleUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ProfileBloc(getprofileUsecase: sl(), updateuserProfileUsecase: sl()),
  );
}
