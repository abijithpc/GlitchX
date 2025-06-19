import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Data/DataSource/dialogflow_remote_data_source.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Data/DataSource/gemini_api.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Data/RepositoryImpl/chatbot_repositoryimpl.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Data/RepositoryImpl/gemini_repositoryimpl.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Domain/Repository/chatbot_repository.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Domain/Repository/gemini_repository.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Domain/UseCase/chatbot_usecase.dart';
import 'package:glitchxscndprjt/features/Ai_Page/Domain/UseCase/gemini_usecase.dart';
import 'package:glitchxscndprjt/features/Ai_Page/presentation/Bloc/Gemini/gemini_bloc.dart';
import 'package:glitchxscndprjt/features/Ai_Page/presentation/Bloc/chatbot_bloc.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Domain/UseCase/clear_cart_usecase.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/Models/product_model.dart';
import 'package:glitchxscndprjt/features/Home_Page/Data/DataSource/igdn_remote_datasource.dart';
import 'package:glitchxscndprjt/features/Home_Page/Data/Igdb_Auth/igdb_auth.dart';
import 'package:glitchxscndprjt/features/Home_Page/Data/Repository/igdb_repositoryimpl.dart';
import 'package:glitchxscndprjt/features/Home_Page/Domain/Repository/igdb_repository.dart';
import 'package:glitchxscndprjt/features/Home_Page/Domain/UseCase/getupcomingtrailer_usecase.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/Igdb/igdb_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/DataSource/order_remotedatasource.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/DataSource/wallet_remotesource.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Repository/order_repositoryimpl.dart';
import 'package:glitchxscndprjt/features/Order_page/Data/Repository/wallet_repositoryimpl.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/order_repository.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/Repository/wallet_repository.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/cancelorder_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/delete_address_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/getorder_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/getwallet_transactionusecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/placeorder_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/Domain/UseCase/wallet_usecase.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/WalletBloc/wallet_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_bloc.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/DataSource/privacy_remotedatasource.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/Repository/privacy_repositoryimpl.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/Repository/privacy_repository.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/privacy_usecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/termscondition_usecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/PrivacyBloc/privacy_bloc.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/TermsAndCondition/terms_bloc.dart';
import 'package:http/http.dart' as http;

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
import 'package:glitchxscndprjt/features/Cart_Page/Data/DataSource/cartdata_remotesource.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Data/Repository/cart_repository_impl.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Domain/Repository/cart_repository.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Domain/UseCase/add_to_cart_usecase.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Domain/UseCase/get_cart_item_usecase.dart';
import 'package:glitchxscndprjt/features/Cart_Page/Domain/UseCase/removeproductcart_usecase.dart';
import 'package:glitchxscndprjt/features/Cart_Page/presentation/Bloc/cart_bloc.dart';
import 'package:glitchxscndprjt/features/Category_Page/Data/DataSource/product_remote_datasource.dart';
import 'package:glitchxscndprjt/features/Category_Page/Data/Repository/product_repo_impl.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/Repository/product_repository.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/UseCase/get_newlyreleased_gameusecase.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/UseCase/getproduct_usecase.dart';
import 'package:glitchxscndprjt/features/Category_Page/Domain/UseCase/getproductid_usecase.dart';
import 'package:glitchxscndprjt/features/Category_Page/presentation/Bloc/product_bloc.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Data/DataSource/wishlist_remotedatasource.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Data/Repository/wishlist_reposiotryimpl.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Domain/Repository/wishlist_reposiotry.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Domain/UseCase/addtowishlist_usecase.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Domain/UseCase/deletewishlist_usecase.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/Domain/UseCase/getwishlist_usecase.dart';
import 'package:glitchxscndprjt/features/Favourite_Page/presentation/Bloc/wishlist_bloc.dart';
import 'package:glitchxscndprjt/features/Home_Page/Data/DataSource/user_category_remotedatasource.dart';
import 'package:glitchxscndprjt/features/Home_Page/Data/Repository/user_category_repositoryimpl.dart';
import 'package:glitchxscndprjt/features/Home_Page/Domain/Repository/user_categoryrepository.dart';
import 'package:glitchxscndprjt/features/Home_Page/Domain/UseCase/getusercategories_usecase.dart';
import 'package:glitchxscndprjt/features/Home_Page/presentation/Bloc/category_bloc.dart';
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
import 'package:glitchxscndprjt/features/Profile_Page/Data/DataSource/profile_remote_datasource.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/DataSource/theme_remotedatasource.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/Repository/profile_repository_imp.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Data/Repository/theme_reposiotryimpl.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/Repository/profile_auth_repository.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/Repository/theme_repository.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/get_theme_usecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/getprofile_usecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/settheme_usecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/updateprofileimage_usecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/Domain/UseCase/updateuserprofileusecase.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/Theme/theme_bloc.dart';
import 'package:glitchxscndprjt/features/Profile_Page/presentation/Bloc/profilebloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final auth = TwitchAuthService(
    clientId: 'y9u368dpjt2xfqrublireqhsr9vh0i',
    clientSecret: 'l6ltmivs9z7us5tbwh69lwhlrgka66',
  );
  final token = await auth.getAccessToken();

  // 🔥 Firebase core dependencies
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Register HTTP client (used for IGDB REST calls)
  sl.registerLazySingleton(() => http.Client());

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
  sl.registerLazySingleton<WishlistRemotedatasource>(
    () => WishlistRemotedatasource(sl()),
  );
  sl.registerLazySingleton<ThemeRemoteDataSourceImpl>(
    () => ThemeRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<IgdbRemoteDatasource>(
    () => IgdbRemoteDatasource(
      clientId: 'y9u368dpjt2xfqrublireqhsr9vh0i',
      accessToken: token!,
    ),
  );
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSource(firestore: sl()),
  );
  sl.registerLazySingleton<DialogflowRemoteDataSource>(
    () => DialogflowRemoteDataSource('glitchxapp00711'),
  );

  sl.registerLazySingleton<PrivacyPolicyLocalDataSource>(
    () => PrivacyPolicyLocalDataSource(),
  );

  sl.registerLazySingleton<WalletRemotesource>(
    () => WalletRemotesource(firestore: sl()),
  );
  sl.registerLazySingleton<GeminiRemoteDataSource>(
    () => GeminiRemoteDataSource(client: sl(), apiKey: sl()),
  );

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
  sl.registerLazySingleton<WishlistReposiotry>(
    () => WishlistReposiotryimpl(sl()),
  );
  sl.registerLazySingleton<ThemeRepository>(() => ThemeReposiotryimpl(sl()));
  sl.registerLazySingleton<IgdbRepository>(() => IgdbRepositoryimpl(sl()));
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));
  sl.registerLazySingleton<ChatbotRepository>(
    () => ChatbotRepositoryimpl(sl()),
  );
  sl.registerLazySingleton<PrivacyPolicyRepository>(
    () => PrivacyPolicyRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryimpl(remotesource: sl()),
  );
  sl.registerLazySingleton<GeminiRepository>(() => GeminiRepositoryimpl(sl()));

  // ✅ UseCases
  sl.registerLazySingleton(() => SignupUsecase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => ResetpasswordUsecase(sl()));
  sl.registerLazySingleton(() => EmailverificationUsecase(sl()));
  sl.registerLazySingleton(() => GetprofileUsecase(sl()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl()));
  sl.registerLazySingleton(() => Updateuserprofileusecase(sl()));
  sl.registerLazySingleton(() => UpdateprofileimageUsecase(sl()));
  sl.registerLazySingleton(() => GetusercategoriesUsecase(sl()));
  sl.registerLazySingleton(() => GetproductUsecase(sl()));
  sl.registerLazySingleton(() => GetproductidUsecase(sl()));
  sl.registerLazySingleton(() => AddToCartUseCase(sl()));
  sl.registerLazySingleton(() => GetCartItemsUseCase(sl()));
  sl.registerLazySingleton(() => RemoveproductcartUsecase(sl()));
  sl.registerLazySingleton(() => AddaddressUsecase(sl()));
  sl.registerLazySingleton(() => GetAddressesUseCase(sl()));
  sl.registerLazySingleton(() => DeleteAddressUseCase(sl()));
  sl.registerLazySingleton(() => SetDefaultAddressUseCase(sl()));
  sl.registerLazySingleton(() => InitialpaymentUsecase(sl()));
  sl.registerLazySingleton(() => GetNewlyreleasedGameusecase(sl()));
  sl.registerLazySingleton(() => AddtowishlistUsecase(sl()));
  sl.registerLazySingleton(() => GetWishlistUsecase(sl()));
  sl.registerLazySingleton(() => DeleteFromWishlistUsecase(sl()));
  sl.registerLazySingleton(() => GetThemeUsecase(sl()));
  sl.registerLazySingleton(() => SetThemeUsecase(sl()));
  sl.registerLazySingleton(() => GetupcomingtrailerUsecase(sl()));
  sl.registerLazySingleton(() => PlaceOrderUsecase(sl()));
  sl.registerLazySingleton(() => ClearCartUsecase(sl()));
  sl.registerLazySingleton(() => GetUserOrdersUseCase(sl()));
  sl.registerLazySingleton(() => SendMessageUseCase(sl()));
  sl.registerLazySingleton(() => PrivacyPolicyUsecase(sl()));
  sl.registerLazySingleton(() => TermsconditionUsecase(sl()));
  sl.registerLazySingleton(() => CancelorderUsecase(sl()));
  sl.registerLazySingleton(() => GetWalletUsecase(sl()));
  sl.registerLazySingleton(() => GetWalletTransactionsUseCase(sl()));
  sl.registerLazySingleton(() => SendPromptUsecase(sl()));

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
  sl.registerFactory(() => ProductBloc(sl(), sl(), sl()));

  sl.registerFactory(
    () => CartBloc(
      addToCartUseCase: sl(),
      getCartItemsUseCase: sl(),
      removeproductcartUsecase: sl(),
      clearCartUsecase: sl(),
    ),
  );

  sl.registerFactory(
    () => AddressBloc(
      addAddressUseCase: sl(),
      getAddressesUseCase: sl(),
      setDefaultAddressUseCase: sl(),
      deleteAddressUseCase: sl(),
    ),
  );

  sl.registerLazySingleton<List<ProductModel>>(() => []);

  sl.registerFactory(() => PaymentBloc(razorpayDatasource: sl()));
  sl.registerFactory(() => WishlistBloc(sl(), sl(), sl()));
  sl.registerFactory(() => ThemeBloc(sl(), sl()));
  sl.registerFactory(() => IgdbBloc(sl()));
  sl.registerFactory(() => OrderBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => ChatbotBloc(sl()));
  sl.registerFactory(() => PrivacyBloc(sl()));
  sl.registerFactory(() => TermsBloc(sl()));
  sl.registerFactory(() => WalletBloc(sl(), sl()));
  sl.registerFactory(() => GeminiBloc(sl()));
}
