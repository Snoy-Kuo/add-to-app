//
//  WebViewController.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/5/18.
//

import UIKit
import WebKit

class WebViewController: UIViewController{
    
    @IBOutlet weak var wvContent: WKWebView!
    @IBOutlet weak var exitItem: UIBarButtonItem!
    
    var initUrl: String = "https://www.apple.com"

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        exitItem.action = #selector(exitPage)
        
        let myURL = URL(string:initUrl)
        let myRequest = URLRequest(url: myURL!)
        wvContent.load(myRequest)
    }

@objc private func exitPage() {
      self.dismiss(animated: true, completion: nil)
  }
}
