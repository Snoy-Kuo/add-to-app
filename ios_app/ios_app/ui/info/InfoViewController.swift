//
//  InfoViewController.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/5/24.
//

import UIKit
import LanguageManager_iOS

class InfoViewController: UIViewController {
    
    @IBOutlet weak var lbCenter: UILabel?
    private var subIndex:Int=0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setText()
    }
    
    private func setText(){
        var subIndexText:String
        switch (subIndex) {
        case 0:
            subIndexText = "all_news".l10n()
            break
        case 1:
            subIndexText = "good_news".l10n()
            break
        case 2:
            subIndexText = "bad_news".l10n()
            break
        case 3:
            subIndexText = "flash_news".l10n()
            break
        case 4:
            subIndexText = "calendar_news".l10n()
            break
        default:
            subIndexText = "what_news".l10n()
            break
        }
        lbCenter?.text = String( format: "this-is-info-vc".l10n(), subIndexText)
        //"This is info VC,\nType=\(subIndexText)"
    }
    
    func setSubIndex(value:Int){
        subIndex = value
        setText()
    }
}

