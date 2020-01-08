//
//  FilterTableViewController.swift
//  Tatayaba
//
//  Created by new on 1/7/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {
    
    var delegate: isAbleToReceiveData?
    var viewType:Int = 0
    var selectedOption:String?
    var selectedFilterOption:String?
    var sortFilterOption:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FilterOptionsTableViewCell.self, forCellReuseIdentifier: "FilterOptionsTableViewCell")
        tableView.tableFooterView = UIView()
        NavigationBarWithCancelButton()

    }
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.pass(data: self.selectedOption ?? "") //call the func in the previous vc
    }
    
    var filterArray = ["Feature".localized(),"price".localized(),"Rating".localized(),"popularity".localized()]
    var sortArray = ["High to low".localized(),"Low to high".localized()]
    
}
    extension FilterTableViewController {
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                if (viewType == 0) {
                    return self.filterArray.count
                } else if (viewType == 1) {
                    return self.sortArray.count
                }else {
                    return 0
                }
            }
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
                return 70
            }
            
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cellIdentifier = "FilterOptionsTableViewCell"
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FilterOptionsTableViewCell
            if (self.viewType == 0){
                if let filteroption = selectedFilterOption {
                     cell.configure(viewType: self.viewType, optionName:
                     self.filterArray[indexPath.row], selected: true)
                }else{
                    cell.configure(viewType: self.viewType, optionName:
                    self.filterArray[indexPath.row], selected: false)
                }
                    
                    return cell
            }else if (self.viewType == 1){
                    cell.configure(viewType: self.viewType, optionName:
                        self.sortArray[indexPath.row], selected: false)
                    return cell
            }else{
                return cell
            }
        }
            
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                tableView.deselectRow(at: indexPath, animated: true)                
            if(self.viewType == 0){
                self.selectedOption = self.filterArray[indexPath.row]
                dismiss(animated: true, completion: nil)
            }else if(self.viewType == 1){
                self.selectedOption = self.sortArray[indexPath.row]
                dismiss(animated: true, completion: nil)
            }
                dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    


