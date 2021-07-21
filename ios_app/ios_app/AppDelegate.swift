//
//  AppDelegate.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/5/12.
//

import UIKit
import FlutterPluginRegistrant
import LanguageManager_iOS

@UIApplicationMain
class AppDelegate: FlutterAppDelegate {
    
    let HOME_ENGINE_NAME = "HOME_ENGINE_NAME"
    lazy var flutterEngine = FlutterEngine(name: HOME_ENGINE_NAME)
    var themeMode:UIUserInterfaceStyle = UIUserInterfaceStyle.unspecified
    var isRealtimeQuot : Bool = false
    var isRookieUser : Bool = true
    var selectedLanguage : String? {
        get {
            readLanguage()
        }
        set(newValue){
            saveLanguage(value: newValue)
        }
    }
    
    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        LanguageManager.shared.defaultLanguage = .deviceLanguage
        selectedLanguage = selectedLanguage //trigger getter and setter
        LanguageManager.shared.setLanguage(language: stringToLanguage(langStr: selectedLanguage!));
        
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run();
        // Used to connect plugins (only if you have plugins with iOS platform code).
        GeneratedPluginRegistrant.register(with: self.flutterEngine);
        return super.application(application, didFinishLaunchingWithOptions: launchOptions);
    }
    
    func languageToString(language: Languages) -> String{
        switch (language) {
        case .en:
            return "English"
        case .zhHans:
            return "简体中文"
        case .zhHant:
            return "繁體中文"
        default:
            return "System"
        }
    }
    
    private func readLanguage() -> String{
        let preferences = UserDefaults.standard
        
        let key = "language"
        let defaultValue = "System"
        
        if preferences.object(forKey: key) == nil {
            //  Doesn't exist
            return defaultValue
        } else {
            let value = preferences.string(forKey: key) ?? defaultValue
            return value
        }
    }
    
    func stringToLanguage(langStr: String) -> Languages {
        switch(langStr){
        case "English": do {
            return .en
        }
        case "简体中文": do {
            return .zhHans
        }
        case "繁體中文": do {
            return .zhHant
        }
        default: do { //System
            let deviceLang:String = Locale.preferredLanguages[0]
            if (deviceLang.starts(with: "zh")){
                if (deviceLang.contains("HK") || deviceLang.contains("TW") || deviceLang.contains("Hant")){
                    return .zhHant
                } else {
                    return .zhHans
                }
            } else {
                return .en
            }
            //            return .deviceLanguage //this is not expect fallback as flutter module.
        }
        }
    }
    
    private func saveLanguage(value:String?){
        let preferences = UserDefaults.standard
        
        let key = "language"
        let defaultValue = "System"
        
        preferences.setValue(value ?? defaultValue, forKey: key)
        
        //  Save to disk
        let didSave = preferences.synchronize()
        
        if (!didSave) {
            //  Couldn't save (I've never seen this happen in real world testing)
            print("language can't save.")
        }
    }
}

