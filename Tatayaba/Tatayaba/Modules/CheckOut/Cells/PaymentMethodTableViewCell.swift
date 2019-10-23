//
//  PaymentMethodTableViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var selectionImageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(payment: PaymentMethod) {
        nameLabel.text = payment.payment
        selectionImageView.isHidden = payment.paymentId != Cart.shared.paymentMethod?.paymentId
//        iconImageView.sd_setImage(with: URL(string: payment.image.icon.httpsImagePath), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)

    }
}
