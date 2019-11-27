//
//  SuppliersBlockView.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol SuppliersBlockViewProtocol: class {
    func didSelectSupplier(at indexPath: IndexPath)
    func didSelectViewAllSuppliers()
}

class SuppliersBlockView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var bannersCollectionView: UICollectionView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewAllButton: UIButton!

    weak var delegate: SuppliersBlockViewProtocol?

    var suppliers: [Supplier]?

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
        bannersCollectionView.register(SuppliersBlockCollectionViewCell.nib, forCellWithReuseIdentifier: SuppliersBlockCollectionViewCell.identifier)
        bannersCollectionView.dataSource = self
        bannersCollectionView.delegate = self
    }

    //MARK:- Load Data
    func loadData() {
        setupUI()
        titleLabel.text = "Brands".localized()
    }

    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let suppliers = suppliers else { return 0 }
        return suppliers.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuppliersBlockCollectionViewCell.identifier, for: indexPath) as! SuppliersBlockCollectionViewCell

        guard let suppliers = suppliers else { return cell }
        cell.configure(suppliers[indexPath.row])

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.didSelectSupplier(at: indexPath)
        }
    }
    
    @IBAction func viewAllAction(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.didSelectViewAllSuppliers()
        }
    }
}
