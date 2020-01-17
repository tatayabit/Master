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
            self.minValueTXT.placeholder = String(0.0)
            self.maxValueTXT.placeholder = String(10000.0)
        }else{
            self.minValueTXT.placeholder = String(self.minValue)
            self.maxValueTXT.placeholder = String(self.maxValue)
        }
        self.applyBTN.setTitle("apply".localized(), for: .normal)
        minView.addBottomBorder()
        maxView.addBottomBorder()
    }

    @IBAction func applyPriceAction(_ sender: Any) {
        let language = minValueTXT.textInputMode?.primaryLanguage
        if(language == "ar"){
            self.minValue = Double(self.minValueTXT.text?.arToEnDigits ?? "0.00") ?? 0.00
            self.maxValue = Double(self.maxValueTXT.text?.arToEnDigits ?? "10000.00") ?? 10000.00
        }else{
            self.minValue = Double(self.minValueTXT.text ?? "0.00") ?? 0.00
            self.maxValue = Double(self.maxValueTXT.text ?? "10000.00") ?? 10000.00
        }
       
        if (minValue > maxValue){
            self.showErrorAlerr(title: "Error".localized(), message: "min>max".localized(), handler: nil)
        }else{
            priceView?.didUpdatePriceFromPrice(newMinimumPrice: minValue, newMaximumPrice: maxValue)
            self.navigationController?.popViewController(animated: true)
        }
       
    }
}

extension String {
    public var arToEnDigits : String {
        let arabicNumbers = ["٠": "0","١": "1","٢": "2","٣": "3","٤": "4","٥": "5","٦": "6","٧": "7","٨": "8","٩": "9"]
        var txt = self
        arabicNumbers.map { txt = txt.replacingOccurrences(of: $0, with: $1)}
        return txt
    }
}
