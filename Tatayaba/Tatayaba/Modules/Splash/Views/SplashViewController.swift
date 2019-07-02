//
//  SplashViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    let userSegue = "show_user_segue"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        performSegue(withIdentifier: userSegue, sender: nil)
    }

}
