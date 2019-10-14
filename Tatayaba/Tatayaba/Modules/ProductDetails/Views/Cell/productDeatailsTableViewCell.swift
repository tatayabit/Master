//
//  productDeatailsTableViewCell.swift
//  Tatayaba
//
//  Created by Maheep on 17/09/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProductDeatailsTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var viewModel:
    
    
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
    
    func configure(product: Product) {
        
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
    
    //MARK:- IBActions
    @IBAction func increaseQuantity(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        viewModel.increase()
        quantityLabel.text = String(viewModel.selectedQuantity)
    }
    
    @IBAction func decreaseQuantity(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        viewModel.decrease()
        quantityLabel.text = String(viewModel.selectedQuantity)
    }
}
