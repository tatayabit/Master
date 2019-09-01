//
//  CategoriesBlockCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CategoriesBlockCollectionViewCell: UICollectionViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var categoryImageView: UIImageView!

    let iconPlaceholder = "category_Icon_placeholder"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(category: Category) {
        nameLabel.text = category.name
        print("icon: \(category.imageUrl)")
        if !category.imageUrl.isEmpty {
            categoryImageView.sd_setImage(with: URL(string: category.imageUrl), placeholderImage: UIImage(named: iconPlaceholder), options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
        }
    }

}
