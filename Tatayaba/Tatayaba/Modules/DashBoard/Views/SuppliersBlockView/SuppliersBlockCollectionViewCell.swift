//
//  SuppliersBlockCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import SDWebImage

class SuppliersBlockCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ supplier: Supplier) {
        bannerImageView.sd_setImage(with: URL(string: (supplier.logo?.icon.url)!), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
    }
}
