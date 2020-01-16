//
//  CategoriesFilterViewController.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 1/16/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//

import UIKit

protocol CategoriesFilterViewInterface: class {
    func reloadListData()
    func applySelectedCategories(categories: [Category])
}

class CategoriesFilterViewController: UIViewController {
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var applyButton: UIButton!
    
    var viewModel: CategoriesFilterViewModel?
    var filterTableViewInterface: FilterTableViewInterface?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel?.view = self
        self.categoriesTableView.register(FilterCategoryTableViewCell.nib, forCellReuseIdentifier: FilterCategoryTableViewCell.identifier)
        self.viewModel?.notifyViewLoaded()
    }
    
    // MARK:- IBActions
    @IBAction func applyFilterAction(_ sender: Any) {
        self.viewModel?.applyFilterActionPressed()
    }
}


extension CategoriesFilterViewController: CategoriesFilterViewInterface {
    func applySelectedCategories(categories: [Category]) {
        self.filterTableViewInterface?.applyCategoriesFilter(categories: categories)
        self.navigationController?.popViewController(animated: true)
    }
    
    func reloadListData() {
        DispatchQueue.main.async {
           self.categoriesTableView.reloadData()
        }
    }
}
