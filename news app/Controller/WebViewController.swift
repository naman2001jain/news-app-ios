//
//  WebViewController.swift
//  news app
//
//  Created by Naman Jain on 26/08/21.
//

import UIKit
import WebKit
class WebViewController: UIViewController {
    
    private let url: URL
    
    private let webview: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        let webview = WKWebView(frame: .zero, configuration: configuration)
        return webview
    }()
    init(url: URL,title: String){
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webview)
        webview.load(URLRequest(url: url))
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webview.frame = view.bounds
    }

}
