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
    apiKey: 'AIzaSyCPSQOEYYlmys2gZOFAUDOv53ZxFzaKcto',
    appId: '1:1019513601164:web:173198591ac291c7574fa9',
    messagingSenderId: '1019513601164',
    projectId: 'ebookchatapp',
    authDomain: 'ebookchatapp.firebaseapp.com',
    databaseURL: 'https://ebookchatapp-default-rtdb.firebaseio.com',
    storageBucket: 'ebookchatapp.appspot.com',
    measurementId: 'G-04DR2GG6ZM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDyROg7fJ3cOkzdeiS1AhJxyfyjVO6JfMU',
    appId: '1:1019513601164:android:f82f11070dfbc189574fa9',
    messagingSenderId: '1019513601164',
    projectId: 'ebookchatapp',
    databaseURL: 'https://ebookchatapp-default-rtdb.firebaseio.com',
    storageBucket: 'ebookchatapp.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA5K5Rxu02RE-9cZTOeF1Z78r1760ZsUao',
    appId: '1:1019513601164:ios:e72eb62a9b33da07574fa9',
    messagingSenderId: '1019513601164',
    projectId: 'ebookchatapp',
    databaseURL: 'https://ebookchatapp-default-rtdb.firebaseio.com',
    storageBucket: 'ebookchatapp.appspot.com',
    iosClientId: '1019513601164-mqg1gost5b7rr8m1uljlahq8398vn0ha.apps.googleusercontent.com',
    iosBundleId: 'com.example.ebookApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA5K5Rxu02RE-9cZTOeF1Z78r1760ZsUao',
    appId: '1:1019513601164:ios:e72eb62a9b33da07574fa9',
    messagingSenderId: '1019513601164',
    projectId: 'ebookchatapp',
    databaseURL: 'https://ebookchatapp-default-rtdb.firebaseio.com',
    storageBucket: 'ebookchatapp.appspot.com',
    iosClientId: '1019513601164-mqg1gost5b7rr8m1uljlahq8398vn0ha.apps.googleusercontent.com',
    iosBundleId: 'com.example.ebookApp',
  );
}