//
//  OptionsHeader.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol OptionsHeaderDelegate: class {
    func toggleSection(section: Int)
}

class OptionsHeader: UITableViewHeaderFooterView {

    var item: HeaderItem?
    
    var section = 0
    
    weak var delegate: OptionsHeaderDelegate?
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var arrowImageView: UIImageView!
    @IBOutlet weak private var selectedImageView: UIImageView!

    //MARK:- Initialize
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapHeader)))
    }
    
    func configure(titleObj: String?, itemObj: HeaderItem, sectionObj: Int, required: Bool, selected: Bool) {
        
//        titleLabel.text = titleObj?.uppercased()
        titleLabel.attributedText = getTitle(title: titleObj ?? "", required: required)
        
        section = sectionObj
        item = itemObj
        
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        selectedImageView.isHidden = !selected
    }
    
    fileprivate func getTitle(title: String, required: Bool) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: title.uppercased() + " ")
        if required {
            let priceAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.red]
            attributedString.append(NSMutableAttributedString(string: "*", attributes: priceAttributes))
        }
        return attributedString
    }

    //MARK: - Actions
    @objc private func didTapHeader() {
        delegate?.toggleSection(section: section)
    }
    
    func callTapAction() {
        self.didTapHeader()
    }
}

