//
//  ProductDetailsView.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/17/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProductDetailsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var productCollectionView: UICollectionView!

    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!

    let imagesArray = ["Dashboard",
                     "ADD",
                     "Dashboard",
                     "ADD"]

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
        productCollectionView.register(CarouselCollectionViewCell.nib, forCellWithReuseIdentifier: CarouselCollectionViewCell.identifier)
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
    }

    //MARK:- Load Data
    func loadData() {
        guard let viewModel = viewModel else { return }
        descriptionLabel.text = viewModel.description
        quantityLabel.text = String(viewModel.selectedQuantity)
    }

    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
//        guard let viewModel = viewModel else { return 0 }
        return 3
    }


    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as! CarouselCollectionViewCell
//        guard let viewModel = viewModel else { return cell }
        cell.configure(imageName: imagesArray[indexPath.row])

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
