// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB-FpAPb8jizHkNszjmjRUfQSPh5bB-cHE',
    appId: '1:64609432781:web:aaca92328ebc75c4db2584',
    messagingSenderId: '64609432781',
    projectId: 'aizuchi-dotlog',
    authDomain: 'aizuchi-dotlog.firebaseapp.com',
    databaseURL: 'https://aizuchi-dotlog-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'aizuchi-dotlog.appspot.com',
    measurementId: 'G-YZ156CVE65',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPbkJJilQF0MtOEolats8tg5V7MQUXKWo',
    appId: '1:64609432781:android:5809e4a0d725a58adb2584',
    messagingSenderId: '64609432781',
    projectId: 'aizuchi-dotlog',
    databaseURL: 'https://aizuchi-dotlog-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'aizuchi-dotlog.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCmp1wpTj7EDCt7N_G0ll1zVn4JefzCgEM',
    appId: '1:64609432781:ios:fad051c734a9d4b7db2584',
    messagingSenderId: '64609432781',
    projectId: 'aizuchi-dotlog',
    databaseURL: 'https://aizuchi-dotlog-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'aizuchi-dotlog.appspot.com',
    iosClientId: '64609432781-thf5ariu7q2c1pjtf90ftfvqo2real0q.apps.googleusercontent.com',
    iosBundleId: 'com.example.aizuchiApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCmp1wpTj7EDCt7N_G0ll1zVn4JefzCgEM',
    appId: '1:64609432781:ios:1d17e184d7a6a6f7db2584',
    messagingSenderId: '64609432781',
    projectId: 'aizuchi-dotlog',
    databaseURL: 'https://aizuchi-dotlog-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'aizuchi-dotlog.appspot.com',
    iosClientId: '64609432781-hjfbtp5bfii0nvd4n2khv0eq4a9cgj2a.apps.googleusercontent.com',
    iosBundleId: 'com.example.aizuchiApp.RunnerTests',
  );
}