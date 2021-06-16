//
//  ViewController.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/5/12.
//

import UIKit
import Flutter

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var lbCenter: UILabel!
    @IBOutlet weak var sgAppreance: UISegmentedControl!
    @IBOutlet weak var swRealtime: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.pushWebView))
        lbCenter.isUserInteractionEnabled = true
        lbCenter.addGestureRecognizer(tap)
        sgAppreance.addTarget(self, action: #selector(onAppearanceSelected(sender:)), for:.valueChanged)
        swRealtime.addTarget(self, action: #selector(self.switchRealtimeQuot(sender:)), for: .valueChanged)
    }
    
    @objc func showFlutter(){
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
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
        let app = (UIApplication.shared.delegate as! AppDelegate)
        app.isRealtimeQuot = sender.isOn
    }
}

