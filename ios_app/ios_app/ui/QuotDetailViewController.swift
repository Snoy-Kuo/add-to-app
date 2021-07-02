//
//  QuotDetailViewController.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/6/11.
//

import UIKit

class QuotDetailViewController: UIViewController{
    @IBOutlet weak var lbCenter: UILabel?
    private var quotId:String=""
    private var quotTitle:String=""
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var exitItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setText()
        
        exitItem.action = #selector(exitPage)
    }
    
    private func setText(){
        navTitle?.title = quotTitle
        lbCenter?.text = String(format:"this_is_quot_detail_vc".l10n(), quotId)
    }
    
    func setQuot(id:String, name:String){
        self.quotId = id
        self.quotTitle = name
        setText()
    }
    
    @objc private func exitPage() {
        self.dismiss(animated: true, completion: nil)
    }
}
