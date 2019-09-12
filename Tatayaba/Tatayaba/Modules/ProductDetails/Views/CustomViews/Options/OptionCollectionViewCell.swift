//
//  OptionCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/18/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class OptionCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var selectionView: UIView!
    @IBOutlet weak var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    private func setupUI() {
        selectionView.isHidden = true
    }

    func configure(imageName: String) {
        //        productImageView.image = UIImage(named: imageName)
    }

    func updateCount(count: Int) {
        selectionView.isHidden = count <= 0
        countLabel.text = String(count)
    }
}
