//
//  WishlistViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/11/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class WishlistViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var wishlistCollectionView: UICollectionView!

    private let viewModel = WishlistViewModel()

    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        self.NavigationBarWithOutBackButton()
    }

    fileprivate func setupCollectionView() {
        // Do any additional setup after loading the view.
        self.wishlistCollectionView.register(WishlistCollectionViewCell.nib, forCellWithReuseIdentifier: WishlistCollectionViewCell.identifier)
        self.wishlistCollectionView.delegate = self
        self.wishlistCollectionView.dataSource = self
    }

    //MARK:- CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return viewModel.wishlistCount
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishlistCollectionViewCell.identifier, for: indexPath) as! WishlistCollectionViewCell
        cell.configure(product: viewModel.wishlistProduct(at: indexPath))

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (self.view.bounds.width - 12) / 3, height: 200)
    }
}
