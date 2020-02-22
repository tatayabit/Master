//
//  TermsTableViewCell.swift
//  Tatayaba
//
//  Created by new on 2/20/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//

import UIKit
import Foundation

protocol TermsProtocol: class {
    func clickTerms()
}

class TermsTableViewCell: UITableViewCell {
    @IBOutlet weak var termsLBL: UILabel!
    var termsProtocol : TermsProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
//        termsLBL.text = "Terms".localized()
        termsLBL.lineBreakMode = .byWordWrapping
        termsLBL.numberOfLines = 0
        termsLBL.sizeToFit()
        termsLBL.isUserInteractionEnabled = true
        
        
//        let attributedString = NSMutableAttributedString(string: "Terms".localized())
//        var foundRange = attributedString.mutableString.range(of: "Terms of use") //mention the parts of the attributed text you want to tap and get an custom action
//        foundRange = attributedString.mutableString.range(of: "Privacy policy")
//        termsLBL.attributedText = attributedString
        
        let attributedString = NSMutableAttributedString(string:"Terms".localized())
        let linkWasSet = attributedString.setAsLink(textToFind: "terms and conditions", linkURL: "http://stackoverflow.com")
        termsLBL.attributedText = attributedString

        if linkWasSet {
            // adjust more attributedString properties
            print("Push view")
        }
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelAction))
        termsLBL.addGestureRecognizer(tap)
        tap.delegate = self
        
    }

   @objc func labelAction(gr:UITapGestureRecognizer)
    {
        let searchlbl:UILabel = (gr.view as! UILabel) // Type cast it with the class for which you have added gesture
        print(searchlbl.text)
        
        termsProtocol?.clickTerms()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension NSMutableAttributedString {

   public func setAsLink(textToFind:String, linkURL:String) -> Bool {

    let foundRange = self.mutableString.range(of: textToFind)
       if foundRange.location != NSNotFound {
        self.addAttribute(NSAttributedString.Key.link, value: linkURL, range: foundRange)
           return true
       }
       return false
   }
}
