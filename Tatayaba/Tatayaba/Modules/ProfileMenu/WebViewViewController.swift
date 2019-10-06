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
    var url: URL!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let WebURL = UserDefaults.standard.value(forKey: "Privacy") as! String
               navigationController?.navigationBar.backItem?.title = ""
        navigationController!.navigationBar.tintColor = UIColor.white
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
     //   self.NavigationBarWithOutBackButton()
        self.NavigationBarWithBackButton()
        if WebURL == "Privacy"{
        
            title_lbl.text = "PRIVACY POLICY"
            
            textview_txt.text = "1. The user must provide the required personal information to make a purchase. Tatayab has the right to securely store all the data provided by the user \n\n 2. Tatayab may collect and share user’s information and activities, provided that the user's identity is not disclosed. These data may include the history of purchases, social networking preferences, age, gender, nationality, and country of residency \n\n 3. Tatayab will only disclose the user's identity in the event to comply with an obligation under the law, or to obey an order from competent authorities. \n\n 4. International shipment may be subject to inspection and may require revealing the identity of the buyer, price and shipment to the relevant authorities, clearance agent, shipping company, in which case, the carrier may act as an agent of the buyer."

        }else{
            
//            let htmlString = "<h1>DELIVERY TIMINGS</h1>  Local orders (Kuwait) will be delivered with in 1 to 2 days.<p>International orders will be delivered with in 4 to 5 days.<h2>CUSTOMER CARE</h2>You can always contact us through our customer service phone number or by chat<p>call us now toll-free inside Kuwait<p>Call: +96522250074<p>9 a.m - 6 p.m +3GMT"
//            webView.loadHTMLString(htmlString, baseURL: nil)
//
       
             title_lbl.text = "DELIVERY AND RETURN POLICY"
            
            textview_txt.text = "1. Local orders Kuwait will be delivered with in 1 to 2 days.\n\n International orders will be delivered with in 4 to 5 days \n\n 2. You can always contact us through our customer service phone number or by chat,call us now toll-free inside Kuwait Call: +96522250074 9 a.m - 6 p.m +3GMT."
            
            
            
        }
        
    
        //let requestObj = URLRequest(url: self.url!)
        //webView.loadRequest(requestObj)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
