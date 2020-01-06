//
//  SortingReusableCustomView.swift
//  Tatayaba
//
//  Created by new on 1/5/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

import UIKit

@IBDesignable
class SortingReusableCustomView: UIView {
    let nibName = "SortingReusableCustomView"
    var contentView:UIView?
   
    @IBOutlet weak var FreeDeliveryView: UIView!
    @IBOutlet weak var FilterView: UIView!
    @IBOutlet weak var SortView: UIView!
    
    @IBOutlet weak var freeDilveryLBL: UILabel!
    @IBOutlet weak var filterLBL: UILabel!
    @IBOutlet weak var sortLBL: UILabel!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
//        self.freeDilveryLBL.text = ""//Free Delivery".localized()
//        self.filterLBL.text = "Filter".localized()
//        self.sortLBL.text = "Sort".localized()
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    
}
