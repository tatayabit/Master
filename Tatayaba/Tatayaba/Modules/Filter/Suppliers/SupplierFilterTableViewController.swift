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
    func applySelectedSuppliers()
}

class SupplierFilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var suppliersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let viewModel = SupplierFilterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchBar.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultSuppliers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        return cell
    }

}

extension SupplierFilterViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(with: searchText)
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
        self.suppliersTableView.reloadData()
    }
    
    func applySelectedSuppliers() {
        
    }
    
    
}
