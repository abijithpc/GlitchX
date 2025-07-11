// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCJ1GwnZSv_2sT3q5MB6pUQxEx7SS1F5aY',
    appId: '1:290026814616:web:e3749f50417a2f4d1024ed',
    messagingSenderId: '290026814616',
    projectId: 'glitchxapp00711',
    authDomain: 'glitchxapp00711.firebaseapp.com',
    storageBucket: 'glitchxapp00711.firebasestorage.app',
    measurementId: 'G-S0QZWL523H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfuGnOYOC-rHK2xxwPiWWEcMhKyiMPQPY',
    appId: '1:290026814616:android:35b453616056d9a81024ed',
    messagingSenderId: '290026814616',
    projectId: 'glitchxapp00711',
    storageBucket: 'glitchxapp00711.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDH29yjJdWoCa-xivdYRjKEk6g7dOJ1yOQ',
    appId: '1:290026814616:ios:b1a4d21a3421fce91024ed',
    messagingSenderId: '290026814616',
    projectId: 'glitchxapp00711',
    storageBucket: 'glitchxapp00711.firebasestorage.app',
    iosBundleId: 'com.glitchx.user',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDH29yjJdWoCa-xivdYRjKEk6g7dOJ1yOQ',
    appId: '1:290026814616:ios:b1a4d21a3421fce91024ed',
    messagingSenderId: '290026814616',
    projectId: 'glitchxapp00711',
    storageBucket: 'glitchxapp00711.firebasestorage.app',
    iosBundleId: 'com.glitchx.user',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCJ1GwnZSv_2sT3q5MB6pUQxEx7SS1F5aY',
    appId: '1:290026814616:web:57de1abf34bc38f81024ed',
    messagingSenderId: '290026814616',
    projectId: 'glitchxapp00711',
    authDomain: 'glitchxapp00711.firebaseapp.com',
    storageBucket: 'glitchxapp00711.firebasestorage.app',
    measurementId: 'G-LBCSS169RJ',
  );
}
