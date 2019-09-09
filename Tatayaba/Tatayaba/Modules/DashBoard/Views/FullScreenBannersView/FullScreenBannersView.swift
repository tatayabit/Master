//
//  FullScreenBannersView.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/25/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

enum BannerType {
    case banner, product
}

protocol FullScreenBannersViewProtocol: class {
    func didSelectBanner(at indexPath: IndexPath)
}

class FullScreenBannersView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    @IBOutlet weak var bannersCollectionView: UICollectionView!

    weak var delegate: FullScreenBannersViewProtocol?

    var block: Block?
    var bannerType: BannerType = .banner


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
        bannersCollectionView.register(BannerBlockCollectionViewCell.nib, forCellWithReuseIdentifier: BannerBlockCollectionViewCell.identifier)
        bannersCollectionView.dataSource = self
        bannersCollectionView.delegate = self
    }

    //MARK:- Load Data
    func loadData() {
        guard block != nil else { return }
        setupUI()
    }

    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let block = block else { return 0 }
        if bannerType == .product {
            return block.products.count
        }
        return block.banners.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerBlockCollectionViewCell.identifier, for: indexPath) as! BannerBlockCollectionViewCell

        guard let block = block else { return cell }
        if bannerType == .product {
            cell.configure(block.products[indexPath.row].fullDetails)
        } else {
            cell.configure(block.banners[indexPath.row])
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.bounds.width, height: 150)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.didSelectBanner(at: indexPath)
        }
    }
}
