//
//  ConciergeSubView.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

protocol ConciergeSubViewDelegate: class {
    func callUplaodConcierge()
    func didSelectCounty()
    func didSelectSubmitConcierge(concierge: Concierge)
    func didFailConciergeValidation(errorTitle: String, errorMessage: String)
}

class ConciergeSubView: UIView, ValidationDelegate {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var perfumeNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var commentTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var customerNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var countryButton: UIButton!
//    @IBOutlet weak var bannerImageViewHeightConstraint: NSLayoutConstraint!
    
    var country: Country?
    weak var delegate: ConciergeSubViewDelegate?
    private let validator = Validator()

    override func awakeFromNib() {
        super.awakeFromNib()

//        bannerImageView.sd_setImage(with: URL(string: "https://tatayab.com/images/companies/1/inside%20page%20english.jpg"), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
        
        self.configureConciergeImage()
        self.registerValidator()
    }
    
    private func configureConciergeImage() {
        let conciergeBgImage = LanguageManager.isArabicLanguage() ? "concierge_ar" : "concierge_en"
        self.bannerImageView.image = UIImage(named: conciergeBgImage)
//        self.bannerImageViewHeightConstraint.constant = UIScreen.main.bounds.width
    }

    // MARK:- Concierge Model
    func createConcierge() -> Concierge {
        let perfumeName: String = perfumeNameTextField.text ?? ""
        let comment: String = commentTextField.text ?? ""
        let customerName: String = customerNameTextField.text ?? ""
        let phone: String = phoneTextField.text ?? ""

        let countryCode: String = country?.code ?? "kw"//perfumeNameTextField.text ?? ""

        let imageData: UIImage = bannerImageView.image ?? UIImage.init()

        let concierge = Concierge(perfumeName: perfumeName, comment: comment, customerName: customerName, phone: phone, countryCode: countryCode, imageData: imageData.toBase64())
        return concierge
    }
    
    //MARK:- Swift Validator
    func registerValidator() {
        validator.registerField(phoneTextField, rules: [RequiredRule(message: "Phone number is required!")])
        validator.registerField(customerNameTextField, rules: [RequiredRule(message: "Name is required!")])
        validator.registerField(perfumeNameTextField, rules: [RequiredRule(message: "Perfume name is required!")])
    }
    
    //MARK:- Validation Delegate
    func validationSuccessful() {
        print("Validation Success!")
        
        if let delegate = delegate {
            delegate.didSelectSubmitConcierge(concierge: createConcierge())
        }
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        print("Validation FAILED!")
        for error in errors {
            print("errors:::: \(String(describing: error.1.errorMessage))")
        }
        
        if errors.count > 0 {
            if let delegate = delegate {
                delegate.didFailConciergeValidation(errorTitle: Constants.Common.error, errorMessage: "\(String(describing: errors[0].1.errorMessage))")
            }
        }
    }

    // MARK:- IBActions
    @IBAction func uploadAction(_ sender: Any) {
        if let delegate = delegate {
            delegate.callUplaodConcierge()
        }
    }

    @IBAction func countryAction(_ sender: Any) {
        if let delegate = delegate {
            delegate.didSelectCounty()
        }
    }

    @IBAction func submitAction(_ sender: Any) {
        validator.validate(self)
    }
}
