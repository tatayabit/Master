//
//  PriceViewController.swift
//  Tatayaba
//
//  Created by new on 1/15/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//

import UIKit

protocol PriceProtocol: class {
    func didUpdatePriceFromPrice(newMinimumPrice: Double, newMaximumPrice: Double)
}

class PriceViewController: BaseViewController {
    @IBOutlet weak var minView: UIView!
    @IBOutlet weak var maxView: UIView!
    @IBOutlet weak var minValueTXT: UITextField!
    @IBOutlet weak var maxValueTXT: UITextField!
    @IBOutlet weak var minLBL: UILabel!
    @IBOutlet weak var maxLBL: UILabel!
    @IBOutlet weak var applyBTN: UIButton!
    
    weak var priceView: PriceProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NavigationBarWithBackButton()
        setView()
        // Do any additional setup after loading the view.
    }
    
    func setView(){
        self.minLBL.text = "Min".localized()
        self.maxLBL.text = "Max".localized()
        self.applyBTN.setTitle("apply".localized(), for: .normal)
        minView.addBottomBorder()
        maxView.addBottomBorder()
    }

    @IBAction func applyPriceAction(_ sender: Any) {
        let minPrice = self.minValueTXT.text ?? "0.00"
        let maxPrice = self.maxValueTXT.text ?? "10000.00"
        priceView?.didUpdatePriceFromPrice(newMinimumPrice: Double(minPrice)!, newMaximumPrice: Double(maxPrice)!)
        self.navigationController?.popViewController(animated: true)
    }
}
