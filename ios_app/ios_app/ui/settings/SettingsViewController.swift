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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.pushWebView))
        lbCenter.isUserInteractionEnabled = true
        lbCenter.addGestureRecognizer(tap)
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
}

