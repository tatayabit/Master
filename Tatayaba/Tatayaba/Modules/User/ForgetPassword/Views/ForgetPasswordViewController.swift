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

class ForgetPasswordViewController: BaseViewController, ValidationDelegate {

    //MARK:- Properties
    private let viewModel = ForgetPasswordViewModel()
    private let validator = Validator()

    @IBOutlet weak private var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var sendButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerValidator()
        setTextFieldsPlaceholder()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        NavigationBarWithBackButton()
//        self.tabBarController?.tabBar.isHidden = true
//    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NavigationBarWithBackButton()
        self.tabBarController?.tabBar.isHidden = true
        emailTextField.becomeFirstResponder()
    }
    
    // MARK:- Localization
     func setTextFieldsPlaceholder() {
        emailTextField.isLTRLanguage = !LanguageManager.isArabicLanguage()
        emailTextField.placeholder = "Email".localized()
        sendButton.setTitle("Reset Password".localized(), for: .normal)
     }

    //MARK:- Swift Validator
    func registerValidator() {
        validator.registerField(emailTextField, rules: [RequiredRule(message: "Email is required!"), EmailRule(message: "Invalid email")])
    }

    //MARK:- Validation Delegate
    func validationSuccessful() {
        print("Validation Success!")
        guard let email = emailTextField.text else { return }
        showLoadingIndicator(to: self.view)

        viewModel.forgetPassword(email: email) { result in
            self.hideLoadingIndicator(from: self.view)
            switch result {
            case .success(let forgetPasswordResult):
                guard let forgetPasswordModel = forgetPasswordResult else { return }
                print(forgetPasswordModel.msg)
                if forgetPasswordModel.success == 0 {
                    self.showErrorAlerr(title: "ForgetFailed".localized(), message: forgetPasswordModel.msg, handler: nil)
                } else {
                    self.showErrorAlerr(title: "ForgetSuccess".localized(), message: forgetPasswordModel.msg, handler: nil)
                }
            case .failure(let error):
                print("the error \(error)")
                do {
                    if let errorMessage = try error.response?.mapString(atKeyPath: "message") {
                        self.showErrorAlerr(title: "ForgetFailed".localized(), message: errorMessage, handler: nil)
                    }
                }
                catch{
                }
//                self.showErrorAlerr(title: Constants.Common.error, message: "Username or password are invalid".localized(), handler: nil)
            }
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        print("Validation FAILED!")
        if errors.count > 0 {
            self.showErrorAlerr(title: Constants.Common.error, message: errors[0].1.errorMessage, handler: nil)
        }

        for error in errors {
            print("errors:::: \(String(describing: error.1.errorMessage))")
        }

    }

    //MARK:- IBActions
    @IBAction func forgetPasswordAction(_ sender: UIButton) {
            emailTextField.updateColors()
            validator.validate(self)
        }
    
}
