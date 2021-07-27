# add_to_app

This directory contains Android, iOS, Flutter app projects that import and use the same Flutter module. <br/>
The Native host and the Flutter module communicate through MethodChannel. <br/>
The Flutter host and the Flutter module communicate through Cubit.<br/>
Flutter projects use flutter_bloc as state management lib.

## Samples Listing

 - [flutter_module](https://github.com/Snoy-Kuo/app-to-app/tree/main/flutter_module) — A Flutter module project, a home screen module used by the other three app projects.
 - [android_app](https://github.com/Snoy-Kuo/app-to-app/tree/main/android_app) — An Android app project, where home screen uses Flutter module.
 - [ios_app](https://github.com/Snoy-Kuo/app-to-app/tree/main/ios_app) — An iOS app project, where home screen uses Flutter module.
 - [flutter_app](https://github.com/Snoy-Kuo/app-to-app/tree/main/flutter_app) — An Flutter app project, where home screen uses Flutter module.

## Dev env

 - macOS 11.4 (Big Sur) x64
 - Flutter 2.2.3
 - Dart 2.13.4
 - Android Studio 4.2.2
 - Dart Plugin 202.8531
 - Flutter Plugin 58.0.1
 - Android SDK version 30.0.3
 - Xcode 12.5.1
 - CocoaPods 1.10.1

 ## References

 - [Add Flutter to existing app](https://flutter.dev/docs/development/add-to-app).
 - [Add-to-App Samples](https://github.com/flutter/samples/tree/master/add_to_app).
