import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Pages/reset_password.dart';
import 'package:glitchxscndprjt/features/CartPage/presentation/Bloc/cart_bloc.dart';
import 'package:glitchxscndprjt/features/CategoryPage/presentation/Bloc/product_bloc.dart';
import 'package:glitchxscndprjt/features/FavouritePage/presentation/Bloc/wishlist_bloc.dart';
import 'package:glitchxscndprjt/features/HomePage/Cubit/navigation_cubit.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/Igdb/igdb_bloc.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Widget/bottomnavigation_bar.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Bloc/category_bloc.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Pages/homepage.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Pages/loginpage.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Pages/signuppage.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/address_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/order_bloc/order_bloc.dart';
import 'package:glitchxscndprjt/features/Order_page/presentation/Bloc/payment_bloc.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/Theme/theme_bloc.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Bloc/profilebloc.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Pages/edit_profile.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Pages/profile_detailspage.dart';
import 'package:glitchxscndprjt/features/ProfilePage/presentation/Pages/profile_page.dart';
import 'package:glitchxscndprjt/features/Splash/Presentation/splashscreen1.dart';
import 'package:glitchxscndprjt/features/Splash/Presentation/splashscreen2.dart';
import 'Core/Di/di.dart' as di;
import 'features/Auth/presentation/Bloc/auth_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<AuthBloc>()),
        BlocProvider(create: (context) => BottomNavigationCubit()),
        BlocProvider(create: (context) => di.sl<ProfileBloc>()),
        BlocProvider(create: (context) => di.sl<UserCategoryBloc>()),
        BlocProvider(create: (context) => di.sl<ProductBloc>()),
        BlocProvider(create: (context) => di.sl<CartBloc>()),
        BlocProvider(create: (context) => di.sl<AddressBloc>()),
        BlocProvider(create: (context) => di.sl<PaymentBloc>()),
        // BlocProvider(create: (context) => di.sl<ProductSearchBloc>()),
        BlocProvider(create: (context) => di.sl<WishlistBloc>()),
        BlocProvider(create: (context) => di.sl<ThemeBloc>()),
        BlocProvider(create: (context) => di.sl<IgdbBloc>()),
        BlocProvider(create: (context) => di.sl<OrderBloc>()),
      ],
      child: Builder(
        builder:
            (context) => MaterialApp(
              title: 'GlitchX Auth App',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(primarySwatch: Colors.deepPurple),
              home: Splashscreen1(),

              routes: {
                '/splash1': (_) => Splashscreen1(),
                '/splash2': (_) => Splashscreen2(),
                '/login': (_) => Loginpage(),
                '/signup': (_) => Signuppage(),
                '/homepage': (_) => Homepage(),
                '/bottomNav': (_) => PersistentBottomNavigationBar(),
                '/profilePage': (_) => ProfilePage(),
                '/resetpassword': (_) => ResetPassword(),
                '/editprofile': (_) => EditProfilePage(),
                '/profiledetails': (_) => ProfileDetailspage(),
              },
            ),
      ),
    );
  }
}
