//
//  LoginViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

class LoginViewController: BaseViewController, ValidationDelegate {

    //MARK:- Properties
//    private let viewModel = LoginViewModel()
    private let validator = Validator()
    private let homeSegue = "show_home_segue"

    @IBOutlet weak private var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak private var passwordTextField: SkyFloatingLabelTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
     navigationController?.isNavigationBarHidden = true
       self.tabBarController?.tabBar.isHidden = false
        registerValidator()
    }

    //MARK:- Swift Validator
    func registerValidator() {
        validator.registerField(emailTextField, rules: [RequiredRule(message: "Email is required!"), EmailRule(message: "Invalid email")])
        validator.registerField(passwordTextField, rules: [RequiredRule(message: "Password is required!"), PasswordRule(regex: "^(?=(.*\\d){8})[a-zA-Z\\d]{8,20}$", message: "Invalid password")])
        emailTextField.becomeFirstResponder()
    }

    //MARK:- Validation Delegate
    func validationSuccessful() {
        print("Validation Success!")

//        guard let email = emailTextField.text else { return }
//        guard let password = passwordTextField.text else { return }

    }

    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        print("Validation FAILED!")
        for error in errors {
            print("errors:::: \(String(describing: error.1.errorMessage))")
        }

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        validator.validateField(textField){ error in
            if error == nil {
                // Field validation was successful
            } else {
                // Validation error occurred
                //                let textFieldX = textField as? SkyFloatingLabelTextField
                //                textFieldX?.updateColors()
            }
        }
        return true
    }

    //MARK:- IBActions
    @IBAction func loginAction(_ sender: UIButton) {
        emailTextField.updateColors()
        passwordTextField.updateColors()
        validator.validate(self)
 
//        self.pushToNextViewController(storyboardName: "Home", segueName: "HomeViewController")
        performSegue(withIdentifier: homeSegue, sender: nil)
        

 
        
        
    }
    
    
    
    
}
