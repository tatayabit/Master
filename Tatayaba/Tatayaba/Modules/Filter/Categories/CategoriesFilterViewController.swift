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
        self.categoriesTableView.register(FilterCategoryHeaderView.nib, forHeaderFooterViewReuseIdentifier: FilterCategoryHeaderView.identifier)
        self.viewModel?.notifyViewLoaded()
    }
    
    // MARK:- IBActions
    @IBAction func applyFilterAction(_ sender: Any) {
        self.viewModel?.applyFilterActionPressed()
    }
}

extension CategoriesFilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK:- Sections
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.allCategories.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilterCategoryHeaderView.identifier) as? FilterCategoryHeaderView else { return nil }
//        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FilterCategoryHeaderView.identifier) as? FilterCategoryHeaderView {
            guard let viewModel = viewModel else { return nil }
            let (category, selected) = viewModel.categorySectionData(at: section)
            headerView.configure(category: category, selected: selected)
//        }
        
        return headerView
    }
    
    // MARK:- Rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.allCategories[section].subCategories.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterCategoryTableViewCell.identifier, for: indexPath) as! FilterCategoryTableViewCell
        guard let viewModel = viewModel else { return cell }

        let (category, selected) = viewModel.subCategoryCellData(at: indexPath)
        cell.configure(category: category, selected: selected)
        return cell
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
