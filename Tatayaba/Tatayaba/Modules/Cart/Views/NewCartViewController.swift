//
//  NewCartViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/10/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class NewCartViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }

    // MARK:-
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CartCellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CartTableViewCell

        return cell
    }
}
