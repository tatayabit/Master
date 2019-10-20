//
//  PaymentWebViewController.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/20/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import WebKit

class PaymentWebViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate {

    var webView: WKWebView!
    
    let checkoutCompletedSegue = "checkout_completed_segue"
    var viewModel: PaymentWebViewModel?
    
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sendRequest()
    }
    
    
    // MARK: - Load Url
     private func sendRequest() {
        guard let viewModel = viewModel else { return }
        let paymentUrl = viewModel.orderResult.redirectUrl
        let myURL = URL(string: paymentUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
     }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url {
            print("new url: ")
            print(url.absoluteString) // It will give the selected link URL
            guard let viewModel = viewModel else { return }
            if viewModel.isPaymentSuccess(with: url) {
                paymentSuccess()
            }
            if viewModel.isPaymentFailed(with: url) {
                paymentFailed()
            }
        }
        decisionHandler(.allow)
    }
    
    // MARK: - Success Flow
    func paymentSuccess() {
        performSegue(withIdentifier: checkoutCompletedSegue, sender: nil)
        self.webView.uiDelegate = nil
        self.webView.navigationDelegate = nil
    }
    
    // MARK: - Failure Flow
    func paymentFailed() {
        self.webView.uiDelegate = nil
        self.webView.navigationDelegate = nil
        showErrorAlerr(title: "Error", message: "Payment Failed. Try again later.") { action in
            self.navigationController?.popViewController(animated: true)
            
        }
    }
}
