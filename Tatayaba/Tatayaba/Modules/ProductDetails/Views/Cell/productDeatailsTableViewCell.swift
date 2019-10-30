//
//  productDeatailsTableViewCell.swift
//  Tatayaba
//
//  Created by Maheep on 17/09/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol ProductDeatailsTableViewCellDelegate: class {
    func didIncreaseQuantity()
    func didDecreaseQuantity()
}

class ProductDeatailsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var viewModel: ProductDeatailsTableViewCellViewModel?
    weak var delegate: ProductDeatailsTableViewCellDelegate?
    weak var viewController: ProductDetailsViewController?
    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        setupUI()
    }
    
    private func setupUI() {
        productCollectionView.register(ProductImageCarouselCollectionViewCell.nib, forCellWithReuseIdentifier: ProductImageCarouselCollectionViewCell.identifier)
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
    }
    
    func configure(productVM: ProductDeatailsTableViewCellViewModel) {
        self.viewModel = productVM
        self.nameLabel.text = productVM.name
        self.descriptionLabel.text = productVM.description.stripOutHtml()
        self.quantityLabel.text = String(productVM.selectedQuantity)
        
        let attributedString = NSMutableAttributedString(string: productVM.price + "    ")
        let priceAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.brandDarkGray]
        attributedString.append(NSMutableAttributedString(string: productVM.discountPrice, attributes: priceAttributes))
        self.priceLabel.attributedText = attributedString
    }
    
    
    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductImageCarouselCollectionViewCell.identifier, for: indexPath) as! ProductImageCarouselCollectionViewCell
        guard let viewModel = viewModel else { return cell }
        cell.configure(imageUrl: viewModel.imageUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.bounds.width, height: 255)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = UIStoryboard(name: "ProductDetails", bundle: Bundle.main).instantiateViewController(withIdentifier: "ImageZoomViewController") as! ImageZoomViewController
        controller.productImage = viewModel?.imageUrl ?? ""
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    //MARK:- IBActions
    @IBAction func increaseQuantity(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
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
