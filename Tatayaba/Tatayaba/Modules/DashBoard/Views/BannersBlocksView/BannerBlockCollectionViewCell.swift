//
//  BannerBlockCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/24/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class BannerBlockCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(block: BlockBanner) {
        bannerImageView.sd_setImage(with: URL(string: block.bgImage.icon.imagePath), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
    }
}
