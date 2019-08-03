//
//  AddressesListViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/31/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class AddressesListViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(AddressTableViewCell.nib, forCellReuseIdentifier: AddressTableViewCell.identifier)
    }

    //MARK:- UItableView Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.identifier, for: indexPath) as! AddressTableViewCell
        cell.configure()
        return cell
    }
}
