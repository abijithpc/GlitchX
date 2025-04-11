import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glitchxscndprjt/features/HomePage/Cubit/navigation_cubit.dart';
import 'package:glitchxscndprjt/features/HomePage/Widget/bottomnavigation_bar.dart';
import 'package:glitchxscndprjt/features/HomePage/presentation/Pages/homepage.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Pages/loginpage.dart';
import 'package:glitchxscndprjt/features/Auth/presentation/Pages/signuppage.dart';
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
        BlocProvider(create: (context) => BottomNavigationCubit()),
        BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
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
                '/bottomNav' : (_)=> PersistentBottomNavigationBar()
              },
            ),
      ),
    );
  }
}
