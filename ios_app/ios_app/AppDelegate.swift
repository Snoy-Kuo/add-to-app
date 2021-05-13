//
//  AppDelegate.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/5/12.
//

import UIKit
import FlutterPluginRegistrant

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {

    lazy var flutterEngine = FlutterEngine(name: "home_module")

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Runs the default Dart entrypoint with a default Flutter route.
      flutterEngine.run();
      // Used to connect plugins (only if you have plugins with iOS platform code).
      GeneratedPluginRegistrant.register(with: self.flutterEngine);
      return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }


}

