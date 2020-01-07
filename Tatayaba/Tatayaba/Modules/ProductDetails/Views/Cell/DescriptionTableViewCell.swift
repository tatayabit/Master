//
//  DescriptionTableViewCell.swift
//  Tatayaba
//
//  Created by new on 12/17/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol ProductDeatailsTableViewCellDelegate: class {
    func didIncreaseQuantity()
    func didDecreaseQuantity()
}

class DescriptionTableViewCell: UITableViewCell {
    @IBOutlet weak var tittleLabel: UILabel!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var delegate: ProductDeatailsTableViewCellDelegate?
    var viewModel: ProductDeatailsTableViewCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(productVM: ProductDeatailsTableViewCellViewModel) {
        tittleLabel.text = "OverView".localized()
        self.viewModel = productVM
        if (productVM.description.count > 0) {
                   self.descriptionLabel.text = productVM.description.stripOutHtml()

               }else{
                   self.descriptionLabel.text = "\(productVM.name) \(productVM.supplierName)"

               }
               self.quantityLabel.text = String(productVM.selectedQuantity)
    }
    
    //MARK:- IBActions
    @IBAction func increaseQuantity(_ sender: UIButton) {
        guard let viewModel = viewModel else {return }
        viewModel.increase()
        quantityLabel.text = String(viewModel.selectedQuantity)
        if let delegate = delegate {
            delegate.didIncreaseQuantity()
        }
    }
    
    @IBAction func decreaseQuantity(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        viewModel.decrease()
        quantityLabel.text = String(viewModel.selectedQuantity)
        if let delegate = delegate {
            delegate.didDecreaseQuantity()
        }
    }

}
