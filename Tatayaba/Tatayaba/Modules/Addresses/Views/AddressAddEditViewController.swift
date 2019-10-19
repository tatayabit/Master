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
    private var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerValidator()
        setupUI()
    }

    //MARK:- setupUI
    func setupUI() {
        NavigationBarWithBackButton()
        if Customer.shared.loggedin {
            if let currentUser = Customer.shared.user {
                fullNameTextField.text = currentUser.firstname
                addressLine1TextField.text = currentUser.shippingAddress
                cityTextField.text = currentUser.shippingCity
                countryTextField.text = currentUser.shippingCountry
                phoneNumberTextField.text = currentUser.shippingPhone
                user = currentUser
            }
        }
    }

    //MARK:- Swift Validator
    func registerValidator() {
        validator.registerField(fullNameTextField, rules: [RequiredRule(message: "Full Name is required!")])
        validator.registerField(addressLine1TextField, rules: [RequiredRule(message: "Address is required!")])
        validator.registerField(cityTextField, rules: [RequiredRule(message: "City is required!")])
        validator.registerField(countryTextField, rules: [RequiredRule(message: "Country is required!")])
        validator.registerField(phoneNumberTextField, rules: [RequiredRule(message: "Phone is required!")])
        fullNameTextField.becomeFirstResponder()
    }

    //MARK:- Validation Delegate
    func validationSuccessful() {
        print("Validation Success!")
        user?.shippingAddress = addressLine1TextField.text ?? ""
        user?.shippingCity = cityTextField.text ?? ""
        user?.shippingCountry = countryTextField.text ?? ""
        user?.shippingPhone = phoneNumberTextField.text ?? ""
        if let user = user {
            Customer.shared.setUser(user)
            navigationController?.popViewController(animated: true)
        } else {
            Customer.shared.setUser(user ?? User(email: "", firstname: fullNameTextField.text ?? "", password: "",shippingCity: cityTextField.text ?? "",shippingCountry: countryTextField.text ?? "",shippingPhone: phoneNumberTextField.text ?? "",shippingAddress: addressLine1TextField.text ?? ""))
            navigationController?.popViewController(animated: true)
        }
    }

    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        print("Validation FAILED!")
        for error in errors {
            print("errors:::: \(String(describing: error.1.errorMessage))")
            showErrorAlerr(title: Constants.Common.error, message: "\(String(describing: error.1.errorMessage))", handler: nil)
        }

    }
    //MARK:- IBActions
    @IBAction func saveContinueAction(_ sender: UIButton) {
        validator.validate(self)
    }

}
