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

    let viewModel = SignUpViewModel()

    
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
    

    //MARK:- IBActions
    @IBAction func signUpAction(_ sender: UIButton) {
        guard let email = text_EmailID.text else { return }
        guard let password = text_Password.text else { return }
        guard let firstname = text_FullName.text else { return }

        print("values: \(email), \(password)")
        let user = User(email: email, firstname: firstname, lastname: firstname, password: password)
        viewModel.signUp(user: user) { result in
            switch result {
            case .success(let loginResult):
                print(loginResult!)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

}
