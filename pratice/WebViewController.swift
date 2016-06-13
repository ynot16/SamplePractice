//
//  WebViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/3/14.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var webView: WKWebView?
    var web: UIWebView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blueColor()
        webView = WKWebView(frame: CGRectMake(0, 0, Window.SCREENWIDTH, Window.SCREENHIEGHT), configuration: WKWebViewConfiguration())
        let url = NSBundle.mainBundle().pathForResource("index", ofType: "html")
        let request = NSURLRequest(URL: NSURL(string: url!)!)
        webView?.loadRequest(request)
        webView?.UIDelegate = self
        webView?.navigationDelegate = self
//        view.addSubview(webView!)
        
        web = UIWebView(frame: CGRectMake(0, 0, Window.SCREENWIDTH, Window.SCREENHIEGHT))
        web?.loadRequest(request)
        web?.delegate = self
        view.addSubview(web!)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension WebViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        let js1: String = "function imgSizeToFit() {"
        let js2 =  "\n var imgs = document.getElementsByTagName('img') "
        let js3 = "\nfor (var i = 0; i < imgs.length; ++i) {"
        let js4 = "\nvar img = imgs[i]"
        let js5 = "\nimg.style.maxWidth = %f"
        let js6 = "\n }"
        let js7 = "\n}"
        var js = js1 + js2 + js3 + js4 + js5 + js6 + js7
        js = String(format: js, arguments: [UIScreen.mainScreen().bounds.size.width - 20])
        webView.stringByEvaluatingJavaScriptFromString(js)
        webView.stringByEvaluatingJavaScriptFromString("imgSizeToFit()")
    }
}


extension WebViewController: WKNavigationDelegate,WKUIDelegate {
    
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        let ac = UIAlertController(title: webView.title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        ac.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: { (aa) -> Void in
            completionHandler()
        }))
        self.presentViewController(ac, animated: true, completion: nil)
    }
}


