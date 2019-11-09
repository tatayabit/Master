//
//  PaymentWebViewController.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/20/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import WebKit

class PaymentWebViewController: BaseViewController, WKUIDelegate, WKNavigationDelegate, UIScrollViewDelegate, CountrySettingsDelegate {

    var webView: WKWebView!
    let checkoutCompletedSegue = "checkout_completed_segue"
    var viewModel: PaymentWebViewModel?
    
    override func loadView() {
        super.loadView()
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences.javaScriptEnabled = true

        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.delegate = self
        webView.scrollView.minimumZoomScale = 1.0;
        webView.scrollView.maximumZoomScale = 1.0;
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CountrySettings.shared.addDelegate(delegate: self)
        sendRequest()
    }
    
    deinit {
        // Without this, it'll crash when your MyClass instance is deinit'd
        webView.scrollView.delegate = nil
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
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
       scrollView.pinchGestureRecognizer?.isEnabled = false
    }
    
    // MARK:- CountrySettingsDelegate
      func countryDidChange(to country: Country) {
          print("country changes!!!")
          print("PaymentWebViewController")
          self.navigationController?.popToRootViewController(animated: false)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == checkoutCompletedSegue {
            let completedCheckoutVC = segue.destination as! CheckoutCompletedViewController
            guard let viewModel = viewModel else { return }
            completedCheckoutVC.viewModel = viewModel.checkoutCompletedViewModel()
        }
    }
}
