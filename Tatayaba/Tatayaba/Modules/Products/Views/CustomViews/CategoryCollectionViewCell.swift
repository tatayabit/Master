//
//  CategoryCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet var nameLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configure(category: Category) {
        nameLabel.text = category.name
    }


}
