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
//    @IBOutlet weak var selectionView: UIView!
//    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!



    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    private func setupUI() {
//        selectionView.isHidden = true
    }

    func configure(option: ProductOption) {
        self.titleLabel.text = option.name
        //        productImageView.image = UIImage(named: imageName)
    }

    func updateCount(count: Int) {
//        selectionView.isHidden = count <= 0
//        countLabel.text = String(count)
    }
}
