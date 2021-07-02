//
//  ViewController.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/5/12.
//

import UIKit
import Flutter
import LanguageManager_iOS

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var lbCenter: UILabel!
    @IBOutlet weak var sgAppreance: UISegmentedControl!
    @IBOutlet weak var swRealtime: UISwitch!
    @IBOutlet weak var tfLanguage: UITextField!
    
    private var aryLanguages = ["English", "简体中文", "繁體中文", "System"]
    private let app = (UIApplication.shared.delegate as! AppDelegate)
    private var tempLanguageSelectValue:String = "System"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.pushWebView))
        lbCenter.isUserInteractionEnabled = true
        lbCenter.addGestureRecognizer(tap)
        sgAppreance.addTarget(self, action: #selector(onAppearanceSelected(sender:)), for:.valueChanged)
        swRealtime.addTarget(self, action: #selector(self.switchRealtimeQuot(sender:)), for: .valueChanged)
        
        tfLanguage.text = app.selectedLanguage!.l10n()
        tfLanguage.delegate = self
        createPickerView()
        dismissPickerView()
    }
    
    @objc func showFlutter(){
        let flutterEngine = app.flutterEngine
        let flutterViewController =
            FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        present(flutterViewController, animated: true, completion: nil)
    }
    
    @objc func pushWebView(){
        performSegue(withIdentifier: "SettingsToWebView", sender: "https://www.google.com")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as? WebViewController
        destVC?.initUrl = sender as! String
    }
    
    @objc func onAppearanceSelected(sender: UISegmentedControl) {
        if #available(iOS 13.0, *) {
            let index = sender.selectedSegmentIndex
            
            switch(index){
            case 0:do { //Light
                view.window?.overrideUserInterfaceStyle = .light
                break
            }
            case 1:do { //dark
                view.window?.overrideUserInterfaceStyle = .dark
                break
            }
            default:do { //system
                view.window?.overrideUserInterfaceStyle = .unspecified
                break
            }
            }
        }
    }
    
    @objc func switchRealtimeQuot(sender:UISwitch!)
    {
        app.isRealtimeQuot = sender.isOn
    }
    
    // returns the number of 'columns' to display.
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return aryLanguages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return aryLanguages[row].l10n()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        tempLanguageSelectValue = aryLanguages[row]
        tfLanguage.text = tempLanguageSelectValue.l10n()
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        let row:Int = aryLanguages.firstIndex(of: app.selectedLanguage!) ?? 0
        pickerView.selectRow(row, inComponent: 0, animated: false)
        tfLanguage.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.onLanguageSelected))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        tfLanguage.inputAccessoryView = toolBar
    }
    
    @objc func onLanguageSelected() {
        view.endEditing(true)
        
        app.selectedLanguage = tempLanguageSelectValue
        
        let selectedLanguage: Languages = app.stringToLanguage(langStr: app.selectedLanguage!)
        
        // change the language
        LanguageManager.shared.setLanguage(language: selectedLanguage)
        { title -> UIViewController in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // the view controller that you want to show after changing the language
            let main: MainTabBarController = storyboard.instantiateViewController(identifier: "\(MainTabBarController.self)") as! MainTabBarController
            return main.navTo(page:2)
            //            return storyboard.instantiateInitialViewController()!
        }
        //        animation: { view in
        // do custom animation
        //            view.transform = CGAffineTransform(scaleX: 2, y: 2)
        //            view.alpha = 0
        //        }
    }
    
}

