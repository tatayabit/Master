//
//  LeftSliderViewController.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class LeftSliderViewController: UIViewController {

    @IBOutlet weak var leftSliderTableView: UITableView!
    
    var rootViewDelegate: RootViewControllerDelegate?
    var sliderMenuDelegate: SliderMenuDelegate?
    var menuItems: [String] = ["HOME", "PROFILE","ÖRDERS","WISHLIST","NOTIFICATIONS","MESSAGES","ABOUT","CHAT","SETTINGS","LOGOUT"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTargets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension LeftSliderViewController {
    
    func addTargets() {
        self.leftSliderTableView.dataSource = self
        self.leftSliderTableView.delegate = self
    }
    
    
    /// Reloads the tableview in UI thread
    func reloadTable() {
        DispatchQueue.main.async {
            self.leftSliderTableView.reloadData()
        }
    }
}



// MARK: - UITableViewDataSource
extension LeftSliderViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftSliderMenuCell", for: indexPath) as! MenuTableViewCell
        cell.menuTitle.text = self.menuItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeftSliderProfileCell") as! LeftSliderProfileHeaderCell
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LeftSliderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.rootViewDelegate?.didSelectMenu(item: self.menuItems[indexPath.row])
        sliderMenuDelegate?.toggleLeftSlider()
    }
}
