//
//  AddressAddEditViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/9/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

class AddressAddEditViewController: BaseViewController, ValidationDelegate {

    @IBOutlet var fullNameTextField: SkyFloatingLabelTextField!
    @IBOutlet var addressLine1TextField: SkyFloatingLabelTextField!
    @IBOutlet var addressLine2TextField: SkyFloatingLabelTextField!
    @IBOutlet var cityTextField: SkyFloatingLabelTextField!
    @IBOutlet var stateTextField: SkyFloatingLabelTextField!
    @IBOutlet var zipCodeTextField: SkyFloatingLabelTextField!
    @IBOutlet var countryTextField: SkyFloatingLabelTextField!


    @IBOutlet var phoneNumberTextField: SkyFloatingLabelTextField!

    private let validator = Validator()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerValidator()
        setupUI()
    }

    //MARK:- setupUI
    func setupUI() {
        NavigationBarWithBackButton()
        if Customer.shared.loggedin {
            if let currentUser = Customer.shared.user{
                fullNameTextField.text = currentUser.firstname
                addressLine1TextField.text = currentUser.shippingAddress
                cityTextField.text = currentUser.shippingCity
                countryTextField.text = currentUser.shippingCountry
                phoneNumberTextField.text = currentUser.shippingPhone
            }
        }
    }

    //MARK:- Swift Validator
    func registerValidator() {
        validator.registerField(fullNameTextField, rules: [RequiredRule(message: "Email is required!")])
    }

    //MARK:- Validation Delegate
    func validationSuccessful() {
        print("Validation Success!")

//        guard let email = emailTextField.text else { return }
//        guard let password = passwordTextField.text else { return }
//        guard let firstname = fullNameTextField.text else { return }


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
    @IBAction func saveContinueAction(_ sender: UIButton) {
        validator.validate(self)
    }

}
