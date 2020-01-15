//
//  PriceViewController.swift
//  Tatayaba
//
//  Created by new on 1/15/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//

import UIKit

class PriceViewController: BaseViewController {
    @IBOutlet weak var minView: UIView!
    @IBOutlet weak var maxView: UIView!
    @IBOutlet weak var minValueTXT: UITextField!
    @IBOutlet weak var maxValueTXT: UITextField!
    @IBOutlet weak var minLBL: UILabel!
    @IBOutlet weak var maxLBL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NavigationBarWithBackButton()
        setViewBorder()
        
        // Do any additional setup after loading the view.
    }
    
    func setViewBorder(){
        minView.addBottomBorder()
        maxView.addBottomBorder()
    }

}
