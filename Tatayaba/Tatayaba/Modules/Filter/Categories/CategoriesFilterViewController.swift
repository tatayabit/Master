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
        self.categoriesTableView.register(FilterSelectionTableViewCell.nib, forCellReuseIdentifier: FilterSelectionTableViewCell.identifier)
        self.viewModel?.notifyViewLoaded()
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
