/*
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
    apiKey: 'AIzaSyCPMtvqCRH4e-Ij0jaH7x-zMHDsQqVVe4k',
    appId: '1:829090300601:web:58bdb0c870c50ddf7c5168',
    messagingSenderId: '829090300601',
    projectId: 'chat-app-2fc40',
    authDomain: 'chat-app-2fc40.firebaseapp.com',
    storageBucket: 'chat-app-2fc40.appspot.com',
    measurementId: 'G-GFZYVC56MT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDhKPtbb9J3H4keXQbNpc-WDiaKlbs1-XQ',
    appId: '1:829090300601:android:e51801b4979f03887c5168',
    messagingSenderId: '829090300601',
    projectId: 'chat-app-2fc40',
    storageBucket: 'chat-app-2fc40.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC97jzj5oWBLGiWBV7UwCQHeHVr2rsaknY',
    appId: '1:829090300601:ios:654645c823981cf07c5168',
    messagingSenderId: '829090300601',
    projectId: 'chat-app-2fc40',
    storageBucket: 'chat-app-2fc40.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC97jzj5oWBLGiWBV7UwCQHeHVr2rsaknY',
    appId: '1:829090300601:ios:654645c823981cf07c5168',
    messagingSenderId: '829090300601',
    projectId: 'chat-app-2fc40',
    storageBucket: 'chat-app-2fc40.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCPMtvqCRH4e-Ij0jaH7x-zMHDsQqVVe4k',
    appId: '1:829090300601:web:0064e327a099adf67c5168',
    messagingSenderId: '829090300601',
    projectId: 'chat-app-2fc40',
    authDomain: 'chat-app-2fc40.firebaseapp.com',
    storageBucket: 'chat-app-2fc40.appspot.com',
    measurementId: 'G-GNY8FBGN0K',
  );
}
*/
