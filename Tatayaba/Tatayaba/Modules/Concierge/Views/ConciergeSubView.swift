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
    @IBOutlet weak var perfumeImage: UIImageView!
    @IBOutlet weak var perufumDescription: UITextView!
//    @IBOutlet weak var perfumeNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var customerNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var countryButton: UIButton!
//    @IBOutlet weak var bannerImageViewHeightConstraint: NSLayoutConstraint!
    
    var country: Country?
    weak var delegate: ConciergeSubViewDelegate?
    private let validator = Validator()

    override func awakeFromNib() {
        super.awakeFromNib()
       // bannerImageView.sd_setImage(with: URL(string: "https://tatayab.com/images/companies/1/inside%20page%20english.jpg"), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
        perufumDescription.placeholder = "Perform Description".localized()
        perufumDescription.isScrollEnabled = false
        
        if LanguageManager.isArabicLanguage() {
            customerNameTextField.isLTRLanguage = false
            phoneTextField.isLTRLanguage = false
        } else {
            customerNameTextField.isLTRLanguage = true
            phoneTextField.isLTRLanguage = true
        }

        
        
        perufumDescription.sizeToFit()
        registerValidator()
        perfumeImage.addTapGestureRecognizer {
            self.uploadAction(UIButton())
        }
    }

    // MARK:- Concierge Model
    func createConcierge() -> Concierge {
//        let perfumeName: String = perfumeNameTextField.text ?? ""
        let comment: String = perufumDescription.text ?? ""
        let customerName: String = customerNameTextField.text ?? ""
        let phone: String = phoneTextField.text ?? ""

        let countryCode: String = country?.code ?? "kw"//perfumeNameTextField.text ?? ""

        let imageData: UIImage = perfumeImage.image ?? UIImage.init()

        let concierge = Concierge(perfumeName: "", comment: comment, customerName: customerName, phone: phone, countryCode: countryCode, imageData: imageData.toBase64())
        return concierge
    }
    
    //MARK:- Swift Validator
    func registerValidator() {
        validator.registerField(phoneTextField, rules: [RequiredRule(message: "Phone number is required!")])
//        validator.registerField(customerNameTextField, rules: [RequiredRule(message: "Name is required!")])
//        validator.registerField(perfumeNameTextField, rules: [RequiredRule(message: "Perfume name is required!")])
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

        if ((perfumeImage.image?.isEqualToImage(image: #imageLiteral(resourceName: "camera-logo")))! ){
            if let delegate = delegate {
                delegate.didFailConciergeValidation(errorTitle: Constants.Common.error, errorMessage: "Perfum image is reqired")
                       }
        }else{
            validator.validate(self)
        }
        
//        if let delegate = delegate {
//            delegate.didSelectSubmitConcierge(concierge: createConcierge())
//        }

    }
    
}


extension UIImage {

    func isEqualToImage(image: UIImage) -> Bool {
        let data1: NSData = self.pngData()! as NSData
        let data2: NSData = image.pngData()! as NSData
        return data1.isEqual(data2)
    }

}
