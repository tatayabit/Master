//
//  FilterTableViewCell.swift
//  Tatayaba
//
//  Created by new on 1/13/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var arrowImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
