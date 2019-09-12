//
//  HProductsListView.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/18/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class HProductsListView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var listTitleLabel: UILabel!

    var viewModel: ProductDetailsViewModel?

    //MARK:- Init
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        //        setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //        setupUI()
    }

    private func setupUI() {
        productsCollectionView.register(HProductCollectionViewCell.nib, forCellWithReuseIdentifier: HProductCollectionViewCell.identifier)
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
    }

    //MARK:- Load Data
    func loadData(title: String) {
//        guard let viewModel = viewModel else { return }
        self.listTitleLabel.text = title
    }

    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        //        guard let viewModel = viewModel else { return 0 }
        return 5
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HProductCollectionViewCell.identifier, for: indexPath) as! HProductCollectionViewCell
        //        guard let viewModel = viewModel else { return cell }
//        cell.configure(imageName: "")//(imageName: imagesArray[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 80, height: 80)
    }

}
