import Flutter
import Foundation

class HomeViewController: FlutterViewController {

  init(withEntrypoint entryPoint: String?) {
    let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
    super.init(engine: flutterEngine, nibName: nil, bundle: nil)
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
