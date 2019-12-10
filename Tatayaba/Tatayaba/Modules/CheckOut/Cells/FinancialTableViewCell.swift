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
            valueLabel.text = viewModal.cart.paymentMethod?.fSurcharge
        }else if (number == 1){
            keyLabel.text = "Total".localized()
            let value = (viewModal.cart.paymentMethod?.fSurcharge?.floatValue ?? 0.0) + viewModal.cart.totalPriceValueRounded
            valueLabel.text = String(value).formattedPrice
        }else{
            print("Error in FinancialTableViewCell ")
        }
        
    }
}
