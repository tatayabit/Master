//
//  SupplierFilterTableViewController.swift
//  Tatayaba
//
//  Created by new on 1/13/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

import UIKit

protocol SupplierFilterViewInterface: class {
    func reloadListData()
    func applySelectedSuppliers(suppliers: [Supplier])
}

class SupplierFilterViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var suppliersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var applyButton: UIButton!
    
    var viewModel: SupplierFilterViewModel?
    var filterTableViewInterface: FilterTableViewInterface?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NavigationBarWithBackButton()
        self.suppliersTableView.tableFooterView = UIView()
        self.searchBar.delegate = self
        self.viewModel?.view = self
        self.suppliersTableView.register(FilterSelectionTableViewCell.nib, forCellReuseIdentifier: FilterSelectionTableViewCell.identifier)
        self.showLoadingIndicator(to: self.view)
        self.viewModel?.notifyViewLoaded()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.resultSuppliers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterSelectionTableViewCell.identifier, for: indexPath) as! FilterSelectionTableViewCell
        guard let viewModel = viewModel else { return cell }

        let (supplier, selected) = viewModel.supplierCellData(at: indexPath.row)
        cell.configure(supplier: supplier, selected: selected)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel?.didSelectRow(at: indexPath)
    }

    // MARK:- IBActions
    @IBAction func applyFilterAction(_ sender: Any) {
        self.viewModel?.applyFilterActionPressed()
    }
    
}

extension SupplierFilterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.search(with: searchText)
        searchBar.showsCancelButton = searchText.count > 0
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension SupplierFilterViewController: SupplierFilterViewInterface {
    func reloadListData() {
        DispatchQueue.main.async {
           self.suppliersTableView.reloadData()
        }
        self.hideLoadingIndicator(from: self.view)
    }
    
    func applySelectedSuppliers(suppliers: [Supplier]) {
        self.filterTableViewInterface?.applySuppliersFilter(suppliers: suppliers)
        self.navigationController?.popViewController(animated: true)
    }
}
