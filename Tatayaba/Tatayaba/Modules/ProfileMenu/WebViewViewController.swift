//
//  WebViewViewController.swift
//  Tatayaba
//
//  Created by Maheep on 16/09/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    var url: URL!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let WebURL = UserDefaults.standard.value(forKey: "Privacy") as! String
        
        if WebURL == "Privacy"{
        
             self.url = URL (string: "https://tatayab.com/privacy-policy")
        }else{
              self.url = URL (string: "https://tatayab.com/terms")
        }
        
    
        let requestObj = URLRequest(url: self.url!)
        webView.loadRequest(requestObj)
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
