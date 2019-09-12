//
//  ConciergeSubView.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol ConciergeSubViewDelegate: class {
    func didSelectUplaodConcierge()
}

class ConciergeSubView: UIView {

    @IBOutlet weak var bannerImageView: UIImageView!
    weak var delegate: ConciergeSubViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()

        bannerImageView.sd_setImage(with: URL(string: "https://tatayab.com/images/companies/1/inside%20page%20english.jpg"), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
    }

    @IBAction func uploadAction(_ sender: Any) {
        if let delegate = delegate {
            delegate.didSelectUplaodConcierge()
        }
    }

    @IBAction func countryAction(_ sender: Any) {
    }

    @IBAction func submitAction(_ sender: Any) {
    }
}
