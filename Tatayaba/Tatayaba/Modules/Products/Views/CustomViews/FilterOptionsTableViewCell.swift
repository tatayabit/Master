//
//  FilterOptionsTableViewCell.swift
//  Tatayaba
//
//  Created by new on 1/7/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

import UIKit

class FilterOptionsTableViewCell: UITableViewCell {

    @IBOutlet weak var optionabel: UILabel!
    @IBOutlet weak var selectImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure (viewType:Int , optionName:String,selected:Bool){
        self.textLabel?.text = optionName
        self.selectImage?.isHidden = false
        if selected {
            self.selectImage?.image = #imageLiteral(resourceName: "check")
        } else {
            self.selectImage?.image = #imageLiteral(resourceName: "unCheck")
        }
        
        
    }
    

    
}
