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
        setTextFieldsPlaceholder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NavigationBarWithBackButton()
        self.tabBarController?.tabBar.isHidden = true
        fullNameTextField.becomeFirstResponder()
    }
    
    // MARK:- Localization
    func setTextFieldsPlaceholder() {
        emailTextField.isLTRLanguage = !LanguageManager.isArabicLanguage()
        passwordTextField.isLTRLanguage = !LanguageManager.isArabicLanguage()
        fullNameTextField.isLTRLanguage = !LanguageManager.isArabicLanguage()
        phoneNumberTextField.isLTRLanguage = !LanguageManager.isArabicLanguage()

        emailTextField.placeholder = "Email".localized()
        passwordTextField.placeholder = "Passwrod".localized()
        fullNameTextField.placeholder = "Full name".localized()
        phoneNumberTextField.placeholder = "Phone".localized()

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
        validator.registerField(emailTextField, rules: [RequiredRule(message: "field_is_required".localized()), EmailRule(message: "valid_email".localized())])
        validator.registerField(passwordTextField, rules: [RequiredRule(message: "field_is_required".localized()), PasswordRule(regex: "^.{6,20}$", message: "valid_password".localized())])
        fullNameTextField.becomeFirstResponder()

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
            case .success(let signUpResult):
                if let user = signUpResult {
                    print(user)
                    Cart.shared.syncCart()
                    self.navigateToHome()
                }
            case .failure(let error):
                print("the error \(error)")
                do {
                    if let errorMessage = try error.response?.mapString(atKeyPath: "message") {
                        self.showErrorAlerr(title: "Login_Failed".localized(), message: "Login_Failed_message".localized(), handler: nil)
                    }
                }
                catch{
                }
            }
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        print("Validation FAILED!")
        for error in errors {
            print("errors:::: \(String(describing: error.1.errorMessage))")
        }
        
        if errors.count > 0 {
            showErrorAlerr(title: "Attention".localized(), message: "\(String(describing: errors[0].1.errorMessage))", handler: nil)
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
    
    @IBAction func signInAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
//        let controller = UIStoryboard(name: "User", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//        navigationController?.pushViewController(controller, animated: false)
//        tabBarController?.tabBar.isHidden = true
    }
    
}
