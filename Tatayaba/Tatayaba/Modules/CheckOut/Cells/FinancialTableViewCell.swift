//
//  FinancialTableViewCell.swift
//  Tatayaba
//
//  Created by new on 12/9/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class FinancialTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
     var viewModal = CheckOutViewModel()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(number: Int) {
        if (number == 0){
            keyLabel.text = "Payment surcharge".localized()
            getSurchargeValue { surChargeValue in
                self.valueLabel.text = "\(surChargeValue)"//viewModal.cart.paymentMethod?.fSurcharge
            }
        }else if (number == 1){
            keyLabel.text = "Total".localized()
            getSurchargeValue { surChargeValue in
                let value = surChargeValue + self.viewModal.cart.totalPriceValueRounded
                self.valueLabel.text = String(value).formattedPrice
            }
        }else{
            print("Error in FinancialTableViewCell ")
        }
        
    }
    
    func getSurchargeValue(completion:((Float) -> ())?) {
        let objCurrency = CurrencySettings.shared.kuwaitiDinarCurrency
        let currencyCode = objCurrency?.currencyCode
        
        var surchargeFinal = 0.00
        
        if let  payment = Cart.shared.paymentMethod {
            if (currencyCode != "KD") {
                if let surcharge = payment.fSurcharge,let surchargeValue = Double(surcharge) {
                         
                    if (surchargeValue > 0) {
                        viewModal.getConvertedPricesWithUpdatedCurrency(value: surchargeValue){result in
                                              
                            switch result {
                            case .success(let convertedPricesResult):
                                                 
                                if let convertedPrices = convertedPricesResult {
                                    surchargeFinal = (convertedPrices.shippingCharge as NSString).doubleValue
                                }
                            case .failure(let error):
                                print("the error \(error)")
                            }
                            if let completion = completion {
                                completion(Float(surchargeFinal))
                            }
                        }
                    } else {
                        if let completion = completion {
                            completion(Float(surchargeFinal))
                        }
                    }
                } else {
                    if let completion = completion {
                        completion(Float(surchargeFinal))
                    }
                }
            }else {

               if let surcharge = payment.fSurcharge,let surchargeValue = Double(surcharge) {
                   if (surchargeValue > 0) {
                        surchargeFinal = surchargeValue
                   }
               }
                
                if let completion = completion {
                    completion(Float(surchargeFinal))
                }
            }
        } else {
            if let completion = completion {
                completion(Float(surchargeFinal))
            }
        }
    }
}
