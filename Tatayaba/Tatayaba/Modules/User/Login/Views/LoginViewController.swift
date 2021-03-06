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
    private let viewModel = LoginViewModel()
    private let validator = Validator()
    private let homeSegue = "show_home_segue"

    @IBOutlet weak private var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak private var passwordTextField: SkyFloatingLabelTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
        registerValidator()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        self.tabBarController?.tabBar.isHidden = true
        navigationController?.isNavigationBarHidden = true
    }

    //MARK:- Swift Validator
    func registerValidator() {
        validator.registerField(emailTextField, rules: [RequiredRule(message: "Email is required!"), EmailRule(message: "Invalid email")])
        validator.registerField(passwordTextField, rules: [RequiredRule(message: "Password is required!"), PasswordRule(regex: "^.{6,20}$", message: "Invalid password")])
//        old password regex "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,20}$"
        emailTextField.becomeFirstResponder()
    }

    //MARK:- Validation Delegate
    func validationSuccessful() {
        print("Validation Success!")

        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }

        let user = User(email: email, password: password)//User(email: email, firstname: firstname, lastname: firstname, password: password)
        showLoadingIndicator(to: self.view)

        viewModel.login(user: user) { result in
            self.hideLoadingIndicator(from: self.view)
            switch result {
            case .success(let loginResult):
                print(loginResult!)
                self.navigateToHome()
            case .failure(let error):
                print("the error \(error)")
                do {
                    if let errorMessage = try error.response?.mapString(atKeyPath: "message") {
                        self.showErrorAlerr(title: "LoginFailed".localized(), message: errorMessage, handler: nil)
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
    //        UserDefaults.standard.set("1", forKey: "UserID") // Need to give userid

    //        performSegue(withIdentifier: homeSegue, sender: nil)

        }
    
    @IBAction func forgetPasswordAction(_ sender: UIButton) {
        let controller = UIStoryboard(name: "User", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
        controller.tabBarController?.tabBar.isHidden = true
        self.navigationController?.pushViewController(controller, animated: true)
        }

    
    @IBAction func skipAction(_ sender: UIButton) {
//         UserDefaults.standard.set("0", forKey: "UserID")
//        performSegue(withIdentifier: homeSegue, sender: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    
}
