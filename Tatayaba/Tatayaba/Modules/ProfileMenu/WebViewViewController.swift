//
//  WebViewViewController.swift
//  Tatayaba
//
//  Created by Maheep on 16/09/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {

    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var textview_txt: UITextView!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var newWebView: UIWebView!
    var url: URL!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let WebURL = UserDefaults.standard.value(forKey: "Privacy") as! String
               navigationController?.navigationBar.backItem?.title = ""
        navigationController!.navigationBar.tintColor = UIColor.white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
     //   self.NavigationBarWithOutBackButton()
        self.NavigationBarWithBackButton()
        if WebURL == "Privacy"{
            if (LanguageManager.isArabicLanguage()){
                self.openURL(url: "https://tatayab.com/privacy-policy-mobile?sl=ar")
            }else{
                   self.openURL(url: "https://tatayab.com/privacy-policy-mobile?sl=en")
            }
            
//            title_lbl.text = "PRIVACY POLICY"
//
//            textview_txt.text = "1. The user must provide the required personal information to make a purchase. Tatayab has the right to securely store all the data provided by the user \n\n 2. Tatayab may collect and share user’s information and activities, provided that the user's identity is not disclosed. These data may include the history of purchases, social networking preferences, age, gender, nationality, and country of residency \n\n 3. Tatayab will only disclose the user's identity in the event to comply with an obligation under the law, or to obey an order from competent authorities. \n\n 4. International shipment may be subject to inspection and may require revealing the identity of the buyer, price and shipment to the relevant authorities, clearance agent, shipping company, in which case, the carrier may act as an agent of the buyer."

        }else if (WebURL == "Delivery"){
            if (LanguageManager.isArabicLanguage()){
                self.openURL(url: "https://tatayab.com/return-policy-mobile?sl=ar")
            }else{
                self.openURL(url: "https://tatayab.com/return-policy-mobile?sl=en")
            }
//             title_lbl.text = "DELIVERY AND RETURN POLICY"
//
//            textview_txt.text = "1. Local orders Kuwait will be delivered with in 1 to 2 days.\n\n International orders will be delivered with in 4 to 5 days \n\n 2. You can always contact us through our customer service phone number or by chat,call us now toll-free inside Kuwait Call: +96522250074 9 a.m - 6 p.m +3GMT."
            
        }else{
            if (LanguageManager.isArabicLanguage()){
                self.openURL(url: "https://tatayab.com/terms-and-conditions-mobile?sl=ar")
            }else{
                self.openURL(url: "https://tatayab.com/terms-and-conditions-mobile?sl=en")
            }
        }
    }
    
    func openURL(url:String){
        guard let url = URL(string: url) else {return}
        UIWebView.loadRequest(newWebView)(NSURLRequest(url: url) as URLRequest)
//        if #available(iOS 10.0, *) {
//            UIApplication.shared.open(url, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.openURL(url)
//        }
    }

}
