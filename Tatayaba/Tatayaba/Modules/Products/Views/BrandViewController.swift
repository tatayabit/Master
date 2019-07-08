//
//  BrandViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController, UICollectionViewDelegate {

    @IBOutlet weak var productsCollectionView: UICollectionView!

    private let viewModel = CategoriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        viewModel.getAllCategories()

    }

//    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let searchItem = viewModel.product(at: indexPath)
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: type(of: searchItem).reuseId, for: indexPath)
//        searchItem.configure(cell: cell, eventable: nil)
//        return cell
//    }
    

}
