//
//  LiveChatViewController.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/19/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import WebKit

class LiveChatViewController: BaseViewController, WKUIDelegate {

    var webView: WKWebView!
    let chatUrl = "https://go.crisp.chat/chat/embed/?website_id=2dc9b64d-89a8-414b-9ebd-24d68babfb5d"
    
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sendRequest()
    }
    
    
    // MARK: - Load Url
     private func sendRequest() {
       let myURL = URL(string: chatUrl)
       let myRequest = URLRequest(url: myURL!)
       webView.load(myRequest)
     }

}
