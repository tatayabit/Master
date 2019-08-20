//
//  ProductOptionsView.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/18/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProductOptionsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var optionsCollectionView: UICollectionView!

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
        optionsCollectionView.register(OptionCollectionViewCell.nib, forCellWithReuseIdentifier: OptionCollectionViewCell.identifier)
        optionsCollectionView.dataSource = self
        optionsCollectionView.delegate = self
    }

    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        //        guard let viewModel = viewModel else { return 0 }
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.identifier, for: indexPath) as! OptionCollectionViewCell
        //        guard let viewModel = viewModel else { return cell }
        cell.configure(imageName: "")//(imageName: imagesArray[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 80, height: 80)
    }

}
