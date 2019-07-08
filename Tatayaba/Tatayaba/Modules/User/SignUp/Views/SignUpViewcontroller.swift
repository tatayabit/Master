//
//  SignUpViewcontroller.swift
//  Tatayaba
//
//  Created by Admin on 01/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

class SignUpViewcontroller: BaseViewController, ValidationDelegate {

    @IBOutlet var btn_Submit: UIButton!
    
    @IBOutlet var fullNameTextField: SkyFloatingLabelTextField!
    @IBOutlet var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet var passwordTextField: SkyFloatingLabelTextField!
    @IBOutlet var phoneNumberTextField: SkyFloatingLabelTextField!

    private let viewModel = SignUpViewModel()
    private let validator = Validator()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerValidator()
        setupUI()
    }

    //MARK:- setupUI
    func setupUI() {
        let logo = kLogoColor()
        btn_Submit.layer.borderWidth = 1.5
        btn_Submit.layer.cornerRadius = 20
        btn_Submit.layer.borderColor = logo.cgColor
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

        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let firstname = fullNameTextField.text else { return }


        print("values: \(email), \(password)")
        let user = User(email: email, firstname: firstname, lastname: firstname, password: password)

        viewModel.signUp(user: user) { result in
            switch result {
            case .success(let loginResult):
                print(loginResult!)
                // should move to home VC
            case .failure(let error):
                print("the error \(error)")
            }
        }
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
    @IBAction func signUpAction(_ sender: UIButton) {
        validator.validate(self)
    }

}
