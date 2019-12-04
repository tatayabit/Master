//
//  CategoriesViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CategoriesViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CountrySettingsDelegate {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!

    private let viewModel = CategoriesViewModel()
    private let productsListSegue = "show_products_list_segue"
    private let searchSegue = "search_segue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSearchBtn()
        setupUI()
        CountrySettings.shared.addDelegate(delegate: self)
        self.categoriesCollectionView.dataSource = self
        self.categoriesCollectionView.delegate = self
        reloadData()
    }
    
    func reloadData() {
        viewModel.getAllCategories()
        viewModel.onCategoriesListLoad = {
            self.categoriesCollectionView.reloadData()
        }
    }

    func setupUI() {
        self.NavigationBarWithOutBackButton()
        categoriesCollectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
    @objc func search() {
       performSegue(withIdentifier: searchSegue, sender: nil)
    }
    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoriesCount
    }


    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as! CategoryCollectionViewCell
        cell.configure(category: viewModel.category(at: indexPath))

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: productsListSegue, sender: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
    return CGSize(width:(self.view.bounds.width - 17) / 3 , height:115)
      
    }

    // MARK:- CountrySettingsDelegate
    func countryDidChange(to country: Country) {
        print("country changes!!!")
        print("CategoriesViewController")
        reloadData()
    }
    
    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == productsListSegue {
            let productsListVC = segue.destination as! CatProductsViewController
            if let indexPath = sender as? IndexPath {
                productsListVC.viewModel = viewModel.productsListViewModel(indexPath: indexPath)
            }
        }
    }
}
