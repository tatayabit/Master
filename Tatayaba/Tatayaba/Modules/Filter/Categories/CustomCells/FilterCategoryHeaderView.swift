//
//  FilterCategoryHeaderView.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 1/17/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//

import UIKit

protocol FilterCategoryHeaderViewDelegate: class {
    func didSelectHeader(at section: Int)
}

class FilterCategoryHeaderView: UITableViewHeaderFooterView, UIGestureRecognizerDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    var section = 0
    weak var delegate: FilterCategoryHeaderViewDelegate?

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(category: Category, selected: Bool, section: Int) {
        self.section = section
        self.nameLabel.text = category.name
        let imageIcon = selected ? "selected_icon" : "unselected_icon"
        self.checkMarkImageView.image = UIImage(named: imageIcon)
    }
    
    //MARK: - Actions
    @IBAction func didTabHeaderAction(_ sender: UIButton) {
        delegate?.didSelectHeader(at: section)
    }
}
