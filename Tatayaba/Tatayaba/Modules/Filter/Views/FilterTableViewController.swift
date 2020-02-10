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
}

class FilterTableViewController: UITableViewController {
    
    var viewModel: FilterRootViewModel?
    
    let suppliersSegue = "suppliers_segue"
    let priceSegue = "price_segue"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel?.notifyViewLoaded()
        viewModel?.view = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.rowsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCell.identifier, for: indexPath) as! FilterTableViewCell
        if let viewModel = viewModel {
            let (title, values) = viewModel.getCellData(at: indexPath)
            cell.configure(title: title, values: values)
        }
        return cell
       }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel else { return }
        viewModel.didSelectRow(at: indexPath)
    }
}

extension FilterTableViewController: FilterTableViewInterface {
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
        
    }
    
    func dismissScreen() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func openSuppliersFilter() {
        self.performSegue(withIdentifier: suppliersSegue, sender: nil)
    }
    
    func openCategoriesFilter() {
        
    }
    
    func openPriceFilter() {
        self.performSegue(withIdentifier: priceSegue, sender: nil)
    }
}
