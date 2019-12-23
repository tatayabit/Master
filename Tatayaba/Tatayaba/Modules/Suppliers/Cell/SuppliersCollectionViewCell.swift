//
//  SuppliersCollectionViewCell.swift
//  Tatayaba
//
//  Created by Maheep on 05/09/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class SuppliersCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(supplier: Supplier) {
        titleLabel.text = supplier.name
        imageView.sd_setImage(with: URL(string: (supplier.logo?.icon.url)!), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
    }
}
