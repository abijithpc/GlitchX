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
import 'package:glitchxscndprjt/features/CartPage/Data/DataSource/cartdata_remotesource.dart';
import 'package:glitchxscndprjt/features/CartPage/Data/Repository/cart_repository_impl.dart';
import 'package:glitchxscndprjt/features/CartPage/Domain/Repository/cart_repository.dart';
import 'package:glitchxscndprjt/features/CartPage/Domain/UseCase/add_to_cart_usecase.dart';
import 'package:glitchxscndprjt/features/CartPage/Domain/UseCase/get_cart_item_usecase.dart';
import 'package:glitchxscndprjt/features/CartPage/Domain/UseCase/removeproductcart_usecase.dart';
import 'package:glitchxscndprjt/features/CartPage/presentation/Bloc/cart_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Data/DataSource/product_remote_datasource.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Data/Repository/product_repo_impl.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/Repository/product_repository.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/UseCase/getproduct_usecase.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/UseCase/getproductid_usecase.dart';
import 'package:glitchxscndprjt/features/CategoryPage/Domain/UseCase/search_products_usecase.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/search_bloc.dart';
import 'package:glitchxscndprjt/features/HomePage/Data/DataSource/user_category_remotedatasource.dart';
import 'package:glitchxscndprjt/features/HomePage/Data/Repository/user_category_repositoryimpl.dart';
import 'package:glitchxscndprjt/features/HomePage/Domain/Repository/user_categoryrepository.dart';
import 'package:glitchxscndprjt/features/HomePage/Domain/UseCase/getusercategories_usecase.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/category_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/DataSource/address_remotedatasource.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/DataSource/razorpay_datasource.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Repository/address_repositoryimpl.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Repository/payment_repositoryimpl.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/address_repository.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/payment_repository.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/addaddress_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/getaddress_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/initialpayment_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/setdefaultaddress__usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/address_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_bloc.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Data/DataSource/profile_remote_datasource.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Data/Repository/profile_repository_imp.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Domain/Repository/profile_auth_repository.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Domain/UseCase/getprofile_usecase.dart';
import 'package:glitchxscndprjt/features/ProfilePage/Domain/UseCase/updateprofileimage_usecase.dart';
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

  sl.registerLazySingleton<UserCategoryRemotedatasource>(
    () => UserCategoryRemotedatasource(FirebaseFirestore.instance),
  );
  sl.registerLazySingleton<ProductRemoteDatasource>(
    () => ProductRemoteDatasource(sl()),
  );
  sl.registerLazySingleton<CartRemoteDataSource>(
    () => CartRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<AddressRemotedatasource>(
    () => AddressRemotedatasource(sl(), sl()),
  );
  sl.registerLazySingleton<RazorpayDatasource>(() => RazorpayDatasource());

  // 📦 Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<ProfileAuthRepository>(
    () => ProfileAuthRepositoryImp(sl()),
  );
  sl.registerLazySingleton<UserCategoryrepository>(
    () => UserCategoryRepositoryimpl(sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));

  sl.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryimpl(sl()),
  );
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryimpl(sl()),
  );

  // ✅ UseCases
  sl.registerLazySingleton(() => SignupUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => ResetpasswordUsecase(sl()));
  sl.registerLazySingleton(() => EmailverificationUsecase(sl()));
  sl.registerLazySingleton(() => GetprofileUsecase(sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => Updateuserprofileusecase(sl()));
  sl.registerLazySingleton(() => UpdateprofileimageUsecase(sl()));
  // sl.registerLazySingleton(() => UpdateLocationUsecase(sl()));
  sl.registerLazySingleton(() => GetusercategoriesUsecase(sl()));
  sl.registerLazySingleton(() => GetproductUsecase(sl()));
  sl.registerLazySingleton(() => GetproductidUsecase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => GetCartItemsUseCase(sl()));
  sl.registerLazySingleton(() => RemoveproductcartUsecase(sl()));
  sl.registerLazySingleton(() => AddaddressUsecase(sl()));
  sl.registerLazySingleton(() => GetAddressesUseCase(sl()));
  sl.registerLazySingleton(() => SetDefaultAddressUseCase(sl()));
  sl.registerLazySingleton(() => InitialpaymentUsecase(sl()));
  sl.registerLazySingleton(() => SearchProductsUsecase(sl()));

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
    () => ProfileBloc(
      getprofileUsecase: sl(),
      updateuserProfileUsecase: sl(),
      updateprofileimageUsecase: sl(),
      // updateLocationUsecase: sl(),
    ),
  );
  sl.registerFactory(() => UserCategoryBloc(sl()));
  sl.registerFactory(() => ProductBloc(sl(), sl()));

  sl.registerFactory(
    () => CartBloc(
      addToCartUseCase: sl(),
      getCartItemsUseCase: sl(),
      removeproductcartUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => AddressBloc(
      addAddressUseCase: sl(),
      getAddressesUseCase: sl(),
      setDefaultAddressUseCase: sl(),
    ),
  );

  sl.registerFactory(() => PaymentBloc(initialpaymentUsecase: sl()));
  sl.registerFactory(() => ProductSearchBloc(sl()));
}
