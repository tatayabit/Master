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
    var minValue:Double = 0.0
    var maxValue:Double = 10000.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.NavigationBarWithBackButton()
        setView()
        // Do any additional setup after loading the view.
    }
    
    func setView(){
        self.hideKeyboardWhenTappedAround()
        self.minLBL.text = "Min".localized()
        self.maxLBL.text = "Max".localized()
        if self.minValue > 0.00 || self.maxValue < 10000.0 {
            self.minValueTXT.text = String(self.minValue)
            self.maxValueTXT.text = String(self.maxValue)
        }else{
            self.minValueTXT.placeholder = String(self.minValue)
            self.maxValueTXT.placeholder = String(self.maxValue)
        }
        self.applyBTN.setTitle("apply".localized(), for: .normal)
        minView.addBottomBorder()
        maxView.addBottomBorder()
    }

    @IBAction func applyPriceAction(_ sender: Any) {
        self.minValue = Double(self.minValueTXT.text ?? "0.00")!
        self.maxValue = Double(self.maxValueTXT.text ?? "0.00")!
        let minPrice = self.minValueTXT.text ?? "0.00"
        let maxPrice = self.maxValueTXT.text ?? "10000.00"
        if (minValue > maxValue){
            self.showErrorAlerr(title: "Error".localized(), message: "min>max".localized(), handler: nil)
        }else{
            priceView?.didUpdatePriceFromPrice(newMinimumPrice: Double(minPrice)!, newMaximumPrice: Double(maxPrice)!)
            self.navigationController?.popViewController(animated: true)
        }
       
    }
}
