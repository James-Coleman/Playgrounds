//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
import WebKit

class MyViewController : UIViewController {
    
    var webView: WKWebView!
    var myURL: URL!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myURL = URL(string: "https://www.doubango.org/sipml5/call.htm?svn=250")!
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        injectValues()
    }
    
    func injectValues() {
        let javascriptString = """
        document.getElementById('txtPrivateIdentity').value = '401990102';
        document.getElementById('txtPublicIdentity').value = 'sip:401990102@4019901.hq.appello.care';
        document.getElementById('txtPassword').value = 'App3ll0';
        document.getElementById('txtRealm').value = '4019901.hq.appello.care';

        document.getElementById('txtPhoneNumber').value = 'sip:401990102@4019901.hq.appello.care';
        """
        
        webView.evaluateJavaScript(javascriptString) { (resultOfScriptEvaluation, error) in
            if let error = error {
                print("Javascript error:", error)
            } else if let result = resultOfScriptEvaluation {
                print("Javascript success:", result)
            }
        }
    }
    
}

extension MyViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if webView.url == myURL {
            injectValues()
        }
    }
}

extension MyViewController: WKUIDelegate {
    
}

// Present the view controller in the Live View window
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = MyViewController()
