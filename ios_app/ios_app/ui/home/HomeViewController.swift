import UIKit

class HomeViewController: UIViewController {
        private lazy var subFlutterVC: MyFlutterViewController = MyFlutterViewController(withEntrypoint: nil)
        
        override func viewDidLoad() {
            addChild(subFlutterVC)
            let safeFrame = self.view.safeAreaLayoutGuide.layoutFrame
            subFlutterVC.view.frame = safeFrame
            self.view.addSubview(subFlutterVC.view)
            subFlutterVC.didMove(toParent: self)
        }
    
    func pushWebView(url:String){
        performSegue(withIdentifier: "HomeToWebView", sender: url)
    }
    
    func pushNewsDetail(dictArgs:[String:Any]){
        performSegue(withIdentifier: "HomeToNewsDetail", sender: dictArgs)
    }
    
    func pushQuotDetail(dictArgs:[String:Any]){
        performSegue(withIdentifier: "HomeToQuotDetail", sender: dictArgs)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "HomeToWebView"){
            let destVC = segue.destination as? WebViewController
            destVC?.initUrl = sender as! String
        } else if (segue.identifier == "HomeToNewsDetail"){
            let destVC = segue.destination as? NewsDetailViewController
            let dictArgs = sender as! [String:Any]
            destVC?.setNews(id: dictArgs["id"] as! Int, title: dictArgs["title"] as! String)
        } else if (segue.identifier == "HomeToQuotDetail"){
            let destVC = segue.destination as? QuotDetailViewController
            let dictArgs = sender as! [String:Any]
            destVC?.setQuot(id: dictArgs["id"] as! String, name: dictArgs["name"] as! String)
        }
    }
}
