//
//  GuestSignUpViewController.swift
//  Tatayaba
//
//  Created by Elsman on 9/10/19.
//  Copyright Elsman. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

class GuestSignUpViewcontroller: BaseViewController, ValidationDelegate {
    
    @IBOutlet var btn_Submit: UIButton!
    
    @IBOutlet var firstNameTextField: SkyFloatingLabelTextField!
    @IBOutlet var lastNameTextField: SkyFloatingLabelTextField!
    @IBOutlet var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet var phoneNumberTextField: SkyFloatingLabelTextField!
    
    private let viewModel = GuestSignUpViewModel()
    private let validator = Validator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerValidator()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        self.tabBarController?.tabBar.isHidden = true
        NavigationBarWithBackButton()
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
        firstNameTextField.becomeFirstResponder()
    }
    
    //MARK:- Validation Delegate
    func validationSuccessful() {
        print("Validation Success!")
        guard let firstname = firstNameTextField.text else { return }
        guard let lastname = lastNameTextField.text else { return }
        guard let email = emailTextField.text else { return }
        
        let user = User(email: email, firstname: firstname, lastname: lastname, password: "")
        
        viewModel.guestSignUp(user: user) { result in
            switch result {
            case .success(let loginResult):
                print(loginResult!)
                let controller = UIStoryboard(name: "Cart", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewCartViewController") as! CartViewController
                controller.buyingWayType = 1
                self.navigationController?.pushViewController(controller, animated: false)
            case .failure(let error):
                print("the error \(error)")
                // should show error alert
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
    
    @IBAction func signInAction(_ sender: UIButton) {
        let controller = UIStoryboard(name: "User", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.pushViewController(controller, animated: false)
        tabBarController?.tabBar.isHidden = true
    }
    
}
