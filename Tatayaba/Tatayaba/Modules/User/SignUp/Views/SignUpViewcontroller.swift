//
//  SignUpViewcontroller.swift
//  Tatayaba
//
//  Created by Admin on 01/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit


class SignUpViewcontroller: UIViewController {

    @IBOutlet var btn_Submit: UIButton!
    
    @IBOutlet var text_FullName: UITextField!
    @IBOutlet var text_EmailID: UITextField!
    @IBOutlet var text_Password: UITextField!
    @IBOutlet var text_Phonenumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let logo = kLogoColor()
        btn_Submit.layer.borderWidth = 1.5
        btn_Submit.layer.cornerRadius = 20
        btn_Submit.layer.borderColor = logo.cgColor
        
   
        
        

       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
