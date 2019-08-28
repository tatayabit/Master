//
//  CategoriesBlockView.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/28/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol CategoriesBlockViewProtocol: class {
    func didSelectCategory(at indexPath: IndexPath)
}

class CategoriesBlockView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {


    @IBOutlet weak var bannersCollectionView: UICollectionView!

    weak var delegate: CategoriesBlockViewProtocol?

    var categories: [Category]?


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
        bannersCollectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        bannersCollectionView.dataSource = self
        bannersCollectionView.delegate = self
    }

    //MARK:- Load Data
    func loadData() {
        guard categories != nil else { return }
        setupUI()
    }

    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let categories = categories else { return 0 }
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell

        guard let categories = categories else { return cell }
        cell.configure(category: categories[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 115)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.didSelectCategory(at: indexPath)
        }
    }
}
