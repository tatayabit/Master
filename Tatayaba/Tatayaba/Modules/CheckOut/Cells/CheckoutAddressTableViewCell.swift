//
//  CheckoutAddressTableViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/11/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CheckoutAddressTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func editButton_Action(_ sender: Any) {
        //AddressAddEditViewController
        
        
        
        
    }
}
