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

class AddressAddEditViewController: BaseViewController, ValidationDelegate, CountryViewDelegate {
    @IBOutlet var fullNameTextField: SkyFloatingLabelTextField!
    @IBOutlet var addressLine1TextField: SkyFloatingLabelTextField!
    @IBOutlet var addressLine2TextField: SkyFloatingLabelTextField!
    @IBOutlet var cityTextField: SkyFloatingLabelTextField!
    @IBOutlet var stateTextField: SkyFloatingLabelTextField!
    @IBOutlet var zipCodeTextField: SkyFloatingLabelTextField!
    @IBOutlet var countryTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var guestCompletDataView: UIView!
    @IBOutlet weak private var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak private var passwordTextField: SkyFloatingLabelTextField!

    @IBOutlet var phoneNumberTextField: SkyFloatingLabelTextField!

    private let validator = Validator()
    private var user: User?
    private var country: Country?
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
                guestCompletDataView.isHidden = true
            }
        } else if Customer.shared.user?.identifier == "" || Customer.shared.user?.identifier == nil {
            guestCompletDataView.isHidden = false
        }
    }

    //MARK:- Swift Validator
    func registerValidator() {
        validator.registerField(fullNameTextField, rules: [RequiredRule(message: "Full Name is required!")])
        validator.registerField(addressLine1TextField, rules: [RequiredRule(message: "Address is required!")])
        validator.registerField(cityTextField, rules: [RequiredRule(message: "City is required!")])
        validator.registerField(countryTextField, rules: [RequiredRule(message: "Country is required!")])
        validator.registerField(phoneNumberTextField, rules: [RequiredRule(message: "Phone is required!")])
        if Customer.shared.user?.identifier == "" || Customer.shared.user?.identifier == nil {
            validator.registerField(emailTextField, rules: [RequiredRule(message: "Email is required!"), EmailRule(message: "Invalid email")])
            validator.registerField(passwordTextField, rules: [RequiredRule(message: "Password is required!"), PasswordRule(regex: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,20}$", message: "Invalid password")])
        }
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
            Customer.shared.setUser(user ?? User(email: emailTextField.text ?? "", firstname: fullNameTextField.text ?? "", password: passwordTextField.text ?? "",shippingCity: cityTextField.text ?? "",shippingCountry: countryTextField.text ?? "",shippingPhone: phoneNumberTextField.text ?? "",shippingAddress: addressLine1TextField.text ?? ""))
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func selectCountryBtnClicked(_ sender: Any) {
        let controller = UIStoryboard(name: "Country", bundle: Bundle.main).instantiateViewController(withIdentifier: "CountryViewController") as! CountryViewController
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: false)
    }
    
    func countrySelected(selectedCountry: Country) {
        country = selectedCountry
        countryTextField.text = country?.name
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
