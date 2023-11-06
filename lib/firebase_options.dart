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
    apiKey: 'AIzaSyA5mhoNrOnuFDp5oD0ISoPSL2k-YnyHV8o',
    appId: '1:515575566707:web:881014fba2418be1f57506',
    messagingSenderId: '515575566707',
    projectId: 'shopapp-1e616',
    authDomain: 'shopapp-1e616.firebaseapp.com',
    storageBucket: 'shopapp-1e616.appspot.com',
    measurementId: 'G-Z8QSQSLDW4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyADLxmX9CZEBhtBQWEV3XiNmlOH-ZXh82g',
    appId: '1:515575566707:android:fc4ce553b6153c5ef57506',
    messagingSenderId: '515575566707',
    projectId: 'shopapp-1e616',
    storageBucket: 'shopapp-1e616.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAayE0lGjZvHyV6CjPJnLwIWtOl4T4djv8',
    appId: '1:515575566707:ios:d2a1c1988beabe59f57506',
    messagingSenderId: '515575566707',
    projectId: 'shopapp-1e616',
    storageBucket: 'shopapp-1e616.appspot.com',
    iosBundleId: 'com.example.shopapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAayE0lGjZvHyV6CjPJnLwIWtOl4T4djv8',
    appId: '1:515575566707:ios:91c101518a52f98af57506',
    messagingSenderId: '515575566707',
    projectId: 'shopapp-1e616',
    storageBucket: 'shopapp-1e616.appspot.com',
    iosBundleId: 'com.example.shopapp.RunnerTests',
  );
}