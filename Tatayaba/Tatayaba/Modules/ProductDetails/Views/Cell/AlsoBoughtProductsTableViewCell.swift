//
//  AlsoBoughtProductsTableViewCell.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/29/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol AlsoBoughtProductsTableViewCellDelegate: class {
    func didSelectProduct(at indexPath: IndexPath)
    func didAddToCart(product: Product)
    func didSelectOneClick(product: Product)
}

class AlsoBoughtProductsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProductsBlockCollectionViewCellDelegate {

    @IBOutlet weak var bannersCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!

    var block: Block?

    weak var delegate: AlsoBoughtProductsTableViewCellDelegate?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setupUI() {
        bannersCollectionView.register(ProductsBlockCollectionViewCell.nib, forCellWithReuseIdentifier: ProductsBlockCollectionViewCell.identifier)
        bannersCollectionView.dataSource = self
        bannersCollectionView.delegate = self
    }

    //MARK:- Load Data
    func configure(with blockObj: Block?) {
        guard let block = blockObj else { return }
        self.block = block
        setupUI()
        titleLabel.text = block.name
    }

    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let block = block else { return 0 }
        return block.products.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsBlockCollectionViewCell.identifier, for: indexPath) as! ProductsBlockCollectionViewCell

        guard let block = block else { return cell }
        cell.configure(block.products[indexPath.row].fullDetails, indexPath: indexPath)
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width / 2.4, height: 204)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.didSelectProduct(at: indexPath)
        }
    }

    // MARK:- ProductsBlockCollectionViewCellDelegate
    func didSelectAddToCartCell(indexPath: IndexPath) {
        if let delegate = delegate {
            guard let block = block else { return }
            let product = block.products[indexPath.row].fullDetails
            if product.hasOptions {
                delegate.didSelectProduct(at: indexPath)
            } else {
                delegate.didAddToCart(product: product)
            }
        }
    }
    
    func didSelectOneClickBuy(indexPath: IndexPath) {
        if let delegate = delegate {
            guard let block = block else { return }
            let product = block.products[indexPath.row].fullDetails
            if product.hasOptions {
                delegate.didSelectProduct(at: indexPath)
            } else {
                delegate.didSelectOneClick(product: product)
            }
        }
    }
    
    
}
