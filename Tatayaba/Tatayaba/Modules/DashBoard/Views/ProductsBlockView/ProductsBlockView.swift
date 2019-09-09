//
//  ProductsBlockView.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol ProductsBlockViewProtocol: class {
    func didSelectProduct(at indexPath: IndexPath)
    func didAddToCart(product: Product)
}

class ProductsBlockView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProductsBlockCollectionViewCellDelegate {

    @IBOutlet weak var bannersCollectionView: UICollectionView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewAllButton: UIButton!

    weak var delegate: ProductsBlockViewProtocol?

    var block: Block?
//    var bannerType: BannerType = .banner

    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setupUI() {
        bannersCollectionView.register(ProductsBlockCollectionViewCell.nib, forCellWithReuseIdentifier: ProductsBlockCollectionViewCell.identifier)
        bannersCollectionView.dataSource = self
        bannersCollectionView.delegate = self
    }

    //MARK:- Load Data
    func loadData() {
        guard let block = block else { return }
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
        return CGSize(width: UIScreen.main.bounds.size.width / 2.4, height: 170)
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
            delegate.didAddToCart(product: product)
        }
    }
}
