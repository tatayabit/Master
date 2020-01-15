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
        setView()
        
        // Do any additional setup after loading the view.
    }
    
    func setView(){
        self.minLBL.text = "Min".localized()
        self.maxLBL.text = "Max".localized()
        minView.addBottomBorder()
        maxView.addBottomBorder()
    }

    @IBAction func applyPriceAction(_ sender: Any) {
        let minPrice = self.minValueTXT.text
        let maxPrice = self.maxValueTXT.text
        self.navigationController?.popViewController(animated: true)
    }
}
