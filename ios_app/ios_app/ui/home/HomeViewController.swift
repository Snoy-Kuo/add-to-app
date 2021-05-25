import Flutter

class HomeViewController: FlutterViewController {
    
    let CHANNEL_NAME = "flutter_home_page"
    let HOST_OPEN_URL = "HOST_OPEN_URL"
    let HOST_OPEN_NEWS_TYPE = "HOST_OPEN_NEWS_TYPE"
    let HOST_OPEN_NEWS_DETAIL = "HOST_OPEN_NEWS_DETAIL"
    
    private var channel: FlutterMethodChannel?
    
    init(withEntrypoint entryPoint: String?) {
        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
        
        super.init(engine: flutterEngine, nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        initChannel()
        super.viewDidLoad()
        
    }
    
    private func initChannel(){
        channel = FlutterMethodChannel(name: CHANNEL_NAME,
                                       binaryMessenger: self.binaryMessenger)
        channel!.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            print("[initChannel] call.method=\(call.method)")
            
            // Note: this method is invoked on the UI thread.
            switch(call.method){
            case self?.HOST_OPEN_URL:do {
                self?.pushWebView(url: call.arguments as! String)
                result(nil)
                break
            }
            case self?.HOST_OPEN_NEWS_TYPE:do {
                self?.naviToInfoPage(subIndex: (call.arguments as! Int)+1)
                result(nil)
                break
            }
            case self?.HOST_OPEN_NEWS_DETAIL:do {
                let args = call.arguments as! Dictionary<String, Any>
                self?.pushNewsDetail(dictArgs:args)
                result(nil)
                
                break
            }
            default: do{
                result(FlutterMethodNotImplemented)
                break
            }
            }
        })
        
    }
    
    func pushWebView(url:String){
        performSegue(withIdentifier: "HomeToWebView", sender: url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "HomeToWebView"){
            let destVC = segue.destination as? WebViewController
            destVC?.initUrl = sender as! String
        } else if (segue.identifier == "HomeToNewsDetail"){
            let destVC = segue.destination as? NewsDetailViewController
            let dictArgs = sender as! [String:Any]
            destVC?.setNews(id: dictArgs["id"] as! Int, title: dictArgs["title"] as! String)
        }
    }
    
    private func naviToInfoPage(subIndex:Int){
        
        let barViewControllers = self.tabBarController?.viewControllers
        let infoVC = barViewControllers![1] as! InfoViewController
        infoVC.setSubIndex(value:subIndex)
        
        self.tabBarController?.selectedIndex = 1
    }
    
    func pushNewsDetail(dictArgs:[String:Any]){
        performSegue(withIdentifier: "HomeToNewsDetail", sender: dictArgs)
    }
    
}
