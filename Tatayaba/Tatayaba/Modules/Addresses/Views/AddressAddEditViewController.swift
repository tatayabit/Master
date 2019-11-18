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
    @IBOutlet var blockTextField: SkyFloatingLabelTextField!
    @IBOutlet var cityTextField: SkyFloatingLabelTextField!
    @IBOutlet var stateTextField: SkyFloatingLabelTextField!
    @IBOutlet var zipCodeTextField: SkyFloatingLabelTextField!
    @IBOutlet var countryTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var guestCompletDataView: UIView!
    @IBOutlet weak private var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak private var passwordTextField: SkyFloatingLabelTextField!

    @IBOutlet var phoneNumberTextField: SkyFloatingLabelTextField!

    private let viewModel = UpdateProfileViewModel()
    private let guestViewModel = GuestSignUpViewModel()
    
    private let validator = Validator()
    private var user: User?
    private var country: Country?
    override func viewDidLoad() {
        super.viewDidLoad()
        registerValidator()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        countryTextField.text = CountrySettings.shared.currentCountry?.name

    }

    //MARK:- setupUI
    func setupUI() {
        NavigationBarWithBackButton()
        if Customer.shared.loggedin {
            if let currentUser = Customer.shared.user {
                fullNameTextField.text = currentUser.firstname
                addressLine1TextField.text = currentUser.billingAddress
                cityTextField.text = currentUser.billingCity
//                countryTextField.text = currentUser.shippingCountry
                phoneNumberTextField.text = currentUser.billingPhone
                stateTextField.text = currentUser.state
                zipCodeTextField.text = currentUser.zipCode
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
            validator.registerField(passwordTextField, rules: [RequiredRule(message: "Password is required!"), PasswordRule(regex: "^.{6,20}$", message: "Invalid password")])
//            "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,20}$"
        }
        fullNameTextField.becomeFirstResponder()
    }

    //MARK:- Validation Delegate
    func validationSuccessful() {
        print("Validation Success!")
        user?.billingAddress = addressLine1TextField.text ?? ""
        user?.billingCity = cityTextField.text ?? ""
        user?.billingCountry = countryTextField.text ?? ""
        user?.billingPhone = phoneNumberTextField.text ?? ""
        user?.state = stateTextField.text ?? ""
        user?.zipCode = zipCodeTextField.text ?? ""
        if let user = user {
            showLoadingIndicator(to: self.view)
            viewModel.updateProfile(user: user) { result in
                self.hideLoadingIndicator(from: self.view)
                switch result {
                case .success(let updateProfileResult):
                    if let user = updateProfileResult {
                        print(user)
                        Customer.shared.setUser(user)
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    print("the error \(error)")
                    do {
                        if let errorMessage = try error.response?.mapString(atKeyPath: "message") {
                            self.showErrorAlerr(title: "AcceessDenied".localized(), message: errorMessage, handler: nil)
                        }
                    }
                    catch{
                    }
                }
            }
        } else {
            showLoadingIndicator(to: self.view)
            guard let email = emailTextField.text else { return }
            guard let password = passwordTextField.text else { return }
            guard let firstname = fullNameTextField.text else { return }
            guard let billingAddress = addressLine1TextField.text else { return }
            guard let billingCity = cityTextField.text else { return }
            guard let billingCountry = countryTextField.text else { return }
            guard let billingPhone = phoneNumberTextField.text else { return }
            guard let state = stateTextField.text else { return }
            guard let zipCode = zipCodeTextField.text else { return }
            
            let user = User(email: email, firstname: firstname, lastname: firstname, password: password, billingAddress: billingAddress,billingCity: billingCity,billingCountry: billingCountry,billingPhone: billingPhone,state: state,zipCode: zipCode)
            
            guestViewModel.guestSignUp(user: user) { result in
                self.hideLoadingIndicator(from: self.view)
                switch result {
                case .success(let guestSignUpResult):
                    if let user = guestSignUpResult {
                        print(user)
                         Customer.shared.setUser(user)
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    print("the error \(error)")
                    do {
                        if let errorMessage = try error.response?.mapString(atKeyPath: "message") {
                            self.showErrorAlerr(title: "AcceessDenied".localized(), message: errorMessage, handler: nil)
                        }
                    }
                    catch{
                    }
                }
            }
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
