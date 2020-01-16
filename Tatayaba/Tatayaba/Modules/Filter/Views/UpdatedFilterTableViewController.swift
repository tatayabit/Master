//
//  FilterTableViewController.swift
//  Tatayaba
//
//  Created by new on 1/13/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

import UIKit

struct Headline {

    var id : Int
    var title : String
    var text : String
    var image : String

}

protocol FilterTableViewInterface: class {
    func setTableDataSource()
    func reloadListData()
    func applySelectedFilters()
    func resetFilters()
    func dismissScreen()
    
    func openSuppliersFilter()
    func openCategoriesFilter()
    func openPriceFilter()
    
    // suppliers filter interface
    func applySuppliersFilter(suppliers: [Supplier])
    func applyCategoriesFilter(categories: [Category])
}

class UpdatedFilterTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: FilterRootViewModel?
    
    let suppliersSegue = "suppliers_segue"
    let categoriesSegue = "categories_segue"
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FilterTableViewCell.nib, forCellReuseIdentifier: FilterTableViewCell.identifier)
        self.viewModel?.view = self
        self.viewModel?.notifyViewLoaded()
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.rowsCount()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as! FilterTableViewCell
        if let viewModel = viewModel {
            let (title, values) = viewModel.getCellData(at: indexPath)
            cell.configure(title: title, values: values)
        }
        
//           cell.arrowImg?.image = UIImage(named: "right_rectangle_product")
           return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        viewModel.didSelectRow(at: indexPath)
    }
    
    // MARK:- IBActions
    @IBAction func applyFilterAction(_ sender: Any) {
//        self.viewModel?.applyFilterActionPressed()
    }
    
    // MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == suppliersSegue {
            let suppliersFilterVC = segue.destination as! SupplierFilterViewController
            if let viewModel = viewModel {
                suppliersFilterVC.viewModel = viewModel.supplierFilterViewModel()
            }
            suppliersFilterVC.filterTableViewInterface = self
        }
        
        if segue.identifier == categoriesSegue {
            let categoriesFilterVC = segue.destination as! CategoriesFilterViewController
            if let viewModel = viewModel {
                categoriesFilterVC.viewModel = viewModel.categoriesFilterViewModel()
            }
            categoriesFilterVC.filterTableViewInterface = self
        }

    }
}

extension UpdatedFilterTableViewController: FilterTableViewInterface {
    
    func setTableDataSource() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func reloadListData() {
        self.tableView.reloadData()
    }
    
    func applySelectedFilters() {
        
    }
    
    func resetFilters() {
        self.viewModel?.didPressResetFilter()
    }
    
    func dismissScreen() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    
    func openSuppliersFilter() {
        self.performSegue(withIdentifier: suppliersSegue, sender: nil)
    }
    
    func openCategoriesFilter() {
        self.performSegue(withIdentifier: categoriesSegue, sender: nil)
    }
    
    func openPriceFilter() {
        
    }
    
    func applySuppliersFilter(suppliers: [Supplier]) {
        guard let viewModel = viewModel else { return }
        viewModel.didUpdateSuppliers(newSuppliers: suppliers)
    }
    
    func applyCategoriesFilter(categories: [Category]) {
        guard let viewModel = viewModel else { return }
        viewModel.didUpdateCategories(newCategories: categories)
    }
}
