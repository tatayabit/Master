//
//  ConciergeSubView.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol ConciergeSubViewDelegate: class {
    func didSelectUplaodConcierge()
    func didSelectCounty()
    func didSelectSubmitConcierge(concierge: Concierge)
}

class ConciergeSubView: UIView {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var perfumeNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var commentTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var customerNameTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var countryButton: UIButton!

    var country: Country?
    weak var delegate: ConciergeSubViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        bannerImageView.sd_setImage(with: URL(string: "https://tatayab.com/images/companies/1/inside%20page%20english.jpg"), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
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

    // MARK:- IBActions
    @IBAction func uploadAction(_ sender: Any) {
        if let delegate = delegate {
            delegate.didSelectUplaodConcierge()
        }
    }

    @IBAction func countryAction(_ sender: Any) {
       
        if let delegate = delegate {
            delegate.didSelectCounty()
        }

        
    }

    @IBAction func submitAction(_ sender: Any) {
        if let delegate = delegate {
            delegate.didSelectSubmitConcierge(concierge: createConcierge())
        }
    }
}
