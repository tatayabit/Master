//
//  OptionCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/18/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class OptionCollectionViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var removeIcon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    private func setupUI() {
         self.removeIcon.isHidden = true
    }

    func configure(option: ProductVariant, selected: Bool) {
        self.titleLabel.text = option.name
        updateRemoveButton(hide: !selected)
//        productImageView.image = UIImage(named: imageName)
    }
    
    func updateRemoveButton(hide: Bool) {
        self.removeIcon.isHidden = hide
    }

    func updateCount(count: Int) {
//        selectionView.isHidden = count <= 0
//        countLabel.text = String(count)
    }
}
