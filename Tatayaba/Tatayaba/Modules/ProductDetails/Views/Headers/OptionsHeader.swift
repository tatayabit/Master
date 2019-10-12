//
//  OptionsHeader.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol OptionsHeaderDelegate: class {
    func toggleSection(header: OptionsHeader, section: Int)
}

class OptionsHeader: UITableViewHeaderFooterView {

    var item: HeaderItem?
    
    var section = 0
    
    weak var delegate: OptionsHeaderDelegate?
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var arrowImageView: UIImageView!
    
    //MARK:- Initialize
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    func configure(titleObj: String?, itemObj: HeaderItem, sectionObj: Int) {
        titleLabel.text = titleObj?.uppercased()
        section = sectionObj
        item = itemObj
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    //MARK: - Actions
    @objc private func didTapHeader() {
        delegate?.toggleSection(header: self, section: section)
    }
}

