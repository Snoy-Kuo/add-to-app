import Flutter
import Foundation

class HomeViewController: FlutterViewController {
    
    let CHANNEL_NAME = "flutter_home_page"
    let HOST_OPEN_URL = "HOST_OPEN_URL"
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
            guard call.method == self?.HOST_OPEN_URL else {
                result(FlutterMethodNotImplemented)
                return
            }
            self?.pushWebView(url: call.arguments as! String)
            result(nil)
        })
        
    }
    
    @objc func pushWebView(url:String){
        performSegue(withIdentifier: "HomeToWebView", sender: url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as? WebViewController
        destVC?.initUrl = sender as! String
    }
}
