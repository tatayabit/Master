//
//  productDeatailsTableViewCell.swift
//  Tatayaba
//
//  Created by Maheep on 17/09/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol ProductDeatailsSupplierDelegate: class {
    func didSupplierClicked(supplierID : String,supplierName:String)
}

class ProductDeatailsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var outOfStockLabel: UILabel!
    @IBOutlet weak var discountPercentageLabel: UILabel!
    @IBOutlet weak var supplierName: UILabel!
    @IBOutlet weak var freeShipping: UILabel!
    
    var viewModel: ProductDeatailsTableViewCellViewModel?
    weak var viewController: ProductDetailsViewController?
    weak var delegate: ProductDeatailsSupplierDelegate?
    var supplier_id = ""
    var supplier_Name = ""
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
        self.outOfStockLabel.text = "Out of stock"
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
    }
    
    func configure(productVM: ProductDeatailsTableViewCellViewModel) {
        self.viewModel = productVM
        self.supplier_id = productVM.supplier_id
        self.supplier_Name = productVM.supplierName
        self.nameLabel.text = productVM.name
        self.outOfStockLabel.isHidden = productVM.isInStock
        self.discountPercentageLabel.text = productVM.discountPercentage + "%\nOFF"
        self.discountPercentageLabel.isHidden = !productVM.hasDiscount
        self.supplierName.text = productVM.supplierName
        self.freeShipping.text = "free Delivery".localized()
        if(productVM.is_free_delivery == "Y"){
            freeShipping.isHidden = false
        }else{
            freeShipping.isHidden = true
        }
        self.supplierName.isUserInteractionEnabled = true
        self.supplierName.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(tapLabel(gesture:))))
        let originalPriceStrikeAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.thick.rawValue]

        let originalPriceAttr = productVM.hasDiscount ? originalPriceStrikeAttributes : nil
        let attributedString = NSMutableAttributedString(string: productVM.priceBeforeDiscount, attributes: originalPriceAttr)
        attributedString.append(NSAttributedString(string: "    "))
        
        
        let priceAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.brandDarkGray]
        attributedString.append(NSMutableAttributedString(string: productVM.originalPrice, attributes: priceAttributes))
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
    
    @IBAction func tapLabel(gesture: UITapGestureRecognizer) {
      if let delegate = delegate {
        delegate.didSupplierClicked(supplierID: self.supplier_id ?? " ", supplierName: self.supplier_Name ?? "")
      }
    }
    

}
