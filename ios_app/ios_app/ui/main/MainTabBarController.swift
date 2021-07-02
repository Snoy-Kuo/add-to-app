//
//  MainTabViewController.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/5/24.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self //set TabBarViewController as UITabBarControllerDelegate
        self.selectedIndex = 0
        
    }
    
    // UITabBarControllerDelegate
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard viewController is InfoViewController else {
            return
        }
        
        //... code here ...
        let infoVC = viewController as! InfoViewController
        infoVC.setSubIndex(value:0)
    }
    
    func navTo(page:Int) -> UIViewController{
        
        if (page < 0 || page > 2){
            return self
        }
        self.selectedIndex = page
        return self
    }
}
