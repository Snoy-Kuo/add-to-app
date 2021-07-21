import Flutter
import Combine

class HomeViewController: FlutterViewController {
    
    let CHANNEL_NAME = "flutter_home_page"
    let HOST_OPEN_URL = "HOST_OPEN_URL"
    let HOST_OPEN_NEWS_TYPE = "HOST_OPEN_NEWS_TYPE"
    let HOST_OPEN_NEWS_DETAIL = "HOST_OPEN_NEWS_DETAIL"
    let HOST_OPEN_QUOT_DETAIL = "HOST_OPEN_QUOT_DETAIL"
    let CLIENT_UPDATE_QUOT = "CLIENT_UPDATE_QUOT"
    let CLIENT_GET_LANGUAGE = "CLIENT_GET_LANGUAGE"
    let CLIENT_CHANGE_LANGUAGE = "CLIENT_CHANGE_LANGUAGE"
    let CLIENT_CHANGE_USER_LV = "CLIENT_CHANGE_USER_LV"
    
    private var channel: FlutterMethodChannel?
    private let repo: RealtimeQuotRepo = MockRealtimeQuotRepo() //TODO: move to vm
    private var observableQuotIem : PassthroughSubject<QuotItem?,Never>? = nil//Observalbe
    private var cancelable: Cancellable? = nil
    private let app = (UIApplication.shared.delegate as! AppDelegate)
    
    init(withEntrypoint entryPoint: String?) {
        let flutterEngine = app.flutterEngine
        observableQuotIem = repo.observeRealtimeQuote()
        super.init(engine: flutterEngine, nibName: nil, bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        observableQuotIem = repo.observeRealtimeQuote()
        super.init(coder: aDecoder)
    }
    
    private func initQuotUpdate() {
        cancelable = observableQuotIem?.sink { item in
            self.channel?.invokeMethod(self.CLIENT_UPDATE_QUOT, arguments: item?.toJson)
        }
    }
    
    override func viewDidLoad() {
        initChannel()
        initQuotUpdate()
//        self.edgesForExtendedLayout = []
        super.viewDidLoad()
        
    }
    
    private func initChannel(){
        channel = FlutterMethodChannel(name: CHANNEL_NAME,
                                       binaryMessenger: self.binaryMessenger)
        channel!.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
            
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
            case self?.HOST_OPEN_QUOT_DETAIL:do{
                let args = call.arguments as! Dictionary<String, Any>
                self?.pushQuotDetail(dictArgs:args)
                result(nil)
                
                break
            }
            case self?.CLIENT_GET_LANGUAGE:do{
                self?.channel?.invokeMethod(self?.CLIENT_CHANGE_LANGUAGE ?? "", arguments: self?.app.selectedLanguage)
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
        } else if (segue.identifier == "HomeToQuotDetail"){
            let destVC = segue.destination as? QuotDetailViewController
            let dictArgs = sender as! [String:Any]
            destVC?.setQuot(id: dictArgs["id"] as! String, name: dictArgs["name"] as! String)
        }
    }
    
    private func naviToInfoPage(subIndex:Int){
        
        let barViewControllers = self.tabBarController?.viewControllers
        let infoVC = barViewControllers![1] as! InfoViewController
        infoVC.setSubIndex(value:subIndex)
        
        self.tabBarController?.selectedIndex = 1
    }
    
    private func pushNewsDetail(dictArgs:[String:Any]){
        performSegue(withIdentifier: "HomeToNewsDetail", sender: dictArgs)
    }
    
    private func pushQuotDetail(dictArgs:[String:Any]){
        performSegue(withIdentifier: "HomeToQuotDetail", sender: dictArgs)
    }
    
    override func viewDidAppear(_ animated:Bool){
        super.viewDidAppear(animated)
        repo.toggleRealtimeQuote(enable: app.isRealtimeQuot)
        self.channel?.invokeMethod(CLIENT_CHANGE_LANGUAGE, arguments:app.selectedLanguage)
        self.channel?.invokeMethod(CLIENT_CHANGE_USER_LV, arguments:app.isRookieUser)
    }
    
    override func viewWillDisappear(_ animated:Bool){
        repo.toggleRealtimeQuote(enable: false)
        super.viewWillDisappear(animated)
    }
}
