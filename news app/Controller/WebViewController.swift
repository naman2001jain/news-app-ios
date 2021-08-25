//
//  WebViewController.swift
//  news app
//
//  Created by Naman Jain on 26/08/21.
//

import UIKit
import WebKit
class WebViewController: UIViewController,WKNavigationDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = NSURL(string: "https://www.google.com") else {
            return
        }
        
        //create WebView and Back button
        createWebView()
        backButton()
        
        
        prefButton()
        
        
        
    }
    
    
    func prefButton() {
        let image = UIImage(named: "icon-pref128") as UIImage?
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        button.frame = CGRect(x: screenWidth * 0.85, y: screenHeight * 0.90, width: 56, height: 56) // (X, Y, Height, Width)
        button.setImage(image, for: [])
        button.addTarget(self, action: Selector(("buttonClicked:")), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func backButton() {
        let image = UIImage(named: "icon-back") as UIImage?
        let button = UIButton(type: UIButton.ButtonType.custom) as UIButton
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        button.frame = CGRect(x: screenWidth * 0.85, y: screenHeight * 0.90, width: 56, height: 56) // (X, Y, Height, Width)
        button.setImage(image, for: [])
        button.addTarget(self, action: Selector("customGoBack:"), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    func customGoBack(sender: UIButton) {
        if self.webView.canGoBack {
            print("Can go back")
            self.webView.goBack()
            self.webView.reload()
        } else {
            print("Can't go back")
        }
    }
    
    func buttonClicked(sender: UIButton) {
        UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
    }
    
    
    private func createWebView() {
        let frame  = UIScreen.main.bounds // or different frame created using CGRectMake(x,y,width,height)
        self.webView = WKWebView(frame: frame)
        self.webView.navigationDelegate = self
        self.view.addSubview(self.webView)
    }
    
    func addBackButton(text: String, action: Selector) {
        //this function will add Button on your navigation bar e
        
        let rightButton = UIBarButtonItem(title: text, style: .plain, target: self, action: action)
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
}




