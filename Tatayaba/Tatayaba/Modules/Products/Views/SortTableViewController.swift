//
//  FilterTableViewController.swift
//  Tatayaba
//
//  Created by new on 1/7/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

import UIKit

class SortTableViewController: UITableViewController {
    
    var delegate: isAbleToReceiveData?
    /// Detect type 0 is a Filtering view, 1 is SortBy view
    var viewType:Int = 0
    var selectedOption:String?
    var sortFilterOption:String?
    var sortArray2 = ["High to low","Low to high", "Popularity"]
    var sortArray3 = ["desc","asc", "popularity"]
    var sortArray = ["High to low".localized(),"Low to high".localized(),"Popularity".localized()]
    var senderView: FilterProductsReturnViewInterface?
    var filterRequestModel: FilterRequestModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(FilterSelectionTableViewCell.nib, forCellReuseIdentifier: FilterSelectionTableViewCell.identifier)
        tableView.tableFooterView = UIView()
        NavigationBarWithCancelButton()
        setselectedOptionInit()

    }
    override func viewWillDisappear(_ animated: Bool) {

        delegate?.pass(data: self.selectedOption ?? "") //call the func in the previous vc
        self.senderView?.didApplyFilter(filterRequestModel: filterRequestModel)
    }
   
    func setselectedOptionInit(){
        self.selectedOption = self.sortFilterOption
    }
    
}
    extension SortTableViewController {
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.sortArray.count
        }
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 70
        }
            
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell  = tableView.dequeueReusableCell(withIdentifier: FilterSelectionTableViewCell.identifier, for: indexPath) as! FilterSelectionTableViewCell
                if let sortOption = sortFilterOption {
                    if (sortOption == self.sortArray2[indexPath.row]) {
                        cell.configure2(text: self.sortArray[indexPath.row], selected: true)
                    } else {
                        cell.configure2(text: self.sortArray[indexPath.row], selected: false)
                    }
                     
                }else{
                    cell.configure2(text: self.sortArray[indexPath.row], selected: false)
                }
                return cell
        }
            
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            self.selectedOption = self.sortArray2[indexPath.row]
            if filterRequestModel != nil{
                filterRequestModel?.sort_order = self.sortArray3[indexPath.row]
            }else{
                self.filterRequestModel = FilterRequestModel()
                self.filterRequestModel?.sort_order = self.sortArray3[indexPath.row]
            }
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    
    
    


