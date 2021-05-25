//
//  NewsDetailViewController.swift
//  ios_app
//
//  Created by Snoy Kuo on 2021/5/25.
//

import UIKit

class NewsDetailViewController: UIViewController{
    @IBOutlet weak var lbCenter: UILabel?
    private var newsId:Int=0
    private var newsTitle:String=""
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var exitItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setText()
        
        exitItem.action = #selector(exitPage)
    }
    
    private func setText(){
        navTitle?.title = newsTitle
        lbCenter?.text = "This is NewsDetail VC,\nid=\(newsId)"
    }
    
    func setNews(id:Int, title:String){
        self.newsId = id
        self.newsTitle = title
        setText()
    }
    
    @objc private func exitPage() {
        self.dismiss(animated: true, completion: nil)
    }
}

