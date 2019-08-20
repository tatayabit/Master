//
//  CategoryCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import SDWebImage

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var categoryImageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configure(category: Category) {
        nameLabel.text = category.name
        if !category.imageUrl.isEmpty {
            categoryImageView.sd_setImage(with: URL(string: category.imageUrl), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
        }
    }


}
