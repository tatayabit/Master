//
//  PaymentMethodTableViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class PaymentMethodTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var selectionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var surchargeLabel: UILabel!
    
    var viewModal = CheckOutViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(payment: PaymentMethod) {
        
        let objCurrency = CurrencySettings.shared.kuwaitiDinarCurrency
        let currencyCode = objCurrency?.currencyCode
        setTitle(payment: payment)
        if (currencyCode != "KD") {
            if let surcharge = payment.fSurcharge,let surchargeValue = Double(surcharge) {
            if (surchargeValue > 0) {
                viewModal.getConvertedPricesWithUpdatedCurrency(value: surchargeValue){result in
                    switch result {
                    case .success(let convertedPricesResult):
                        if let convertedPrices = convertedPricesResult {
                            self.surchargeLabel.text = "\(convertedPrices.shippingCharge) \(convertedPrices.currencyCode)"
                        }
                    case .failure(let error):
                        print("the error \(error)")
                    }
                }
                
            } else {
                surchargeLabel.isHidden = true
            }
            customConfigure(payment: payment)
            }
        }else {
            customConfigure(payment: payment)
            if let surcharge = payment.fSurcharge,let surchargeValue = Double(surcharge) {
                if (surchargeValue > 0) {
                    surchargeLabel.text = "\(surcharge) \(currencyCode ?? "")"
                } else {
                    surchargeLabel.isHidden = true
                }
            }
        }
    }
    
    func customConfigure(payment: PaymentMethod){
        selectionImageView.isHidden = payment.paymentId != Cart.shared.paymentMethod?.paymentId
        iconImageView.sd_setImage(with: URL(string: payment.image?.icon?.imagePath ?? ""), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
    }
    func setTitle(payment: PaymentMethod)  {
        print(payment.payment)
        switch payment.payment {
        case " K-net","كي نت":
            self.titleLabel.text = "K-net".localized()
        case "Mada","مدى":
            self.titleLabel.text = "Mada".localized()
        case "Visa, Mastercard","فيزا ,ماستركارد":
            self.titleLabel.text = "Visa".localized()
        case "Cash on delivery","الدفع عند الاستلام":
            self.titleLabel.text = "Cash on delivery".localized()
        default:
            self.titleLabel.text = "testtttt"
        }
    }
}
