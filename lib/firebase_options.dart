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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCNyCJ9uYZJdJLc0nAC8sxPuburbTEFmOQ',
    appId: '1:541107565011:android:f205b3ad6952f4b79f3f26',
    messagingSenderId: '541107565011',
    projectId: 'sample-project-591c1',
    storageBucket: 'sample-project-591c1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBSdx6g5T69y1NLm4B8hyZLg3GGUFODvvc',
    appId: '1:541107565011:ios:99ec7319954a17cd9f3f26',
    messagingSenderId: '541107565011',
    projectId: 'sample-project-591c1',
    storageBucket: 'sample-project-591c1.appspot.com',
    androidClientId: '541107565011-9p1gcsj3fj4hipkdvkb02bot2gvteqt6.apps.googleusercontent.com',
    iosClientId: '541107565011-1513jehi0vn5iq3mdo09fet74g20d1vl.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoListApp',
  );
}
