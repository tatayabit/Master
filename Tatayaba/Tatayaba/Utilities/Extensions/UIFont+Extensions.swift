//
//  UIFont+Extensions.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/11/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

extension UIFont {
    class func mediumGotham(size: CGFloat) -> UIFont {
        return UIFont(name: "GothamMedium", size: size)!
    }

    class func lightGotham(size: CGFloat) -> UIFont {
        return UIFont(name: "Gotham-Light", size: size)!
    }
    
    class func htfbookGotham(size: CGFloat) -> UIFont {
        return UIFont(name: "GothamHTF-Book", size: size)!
    }
    
    class func appRegularFontWith(name: String, size: CGFloat) -> UIFont{
        return  UIFont(name: name, size: size)!
    }
}

extension UILabel {
    @objc var substituteFontName : String {
        get { return self.font.fontName }
        set {
            if self.font.fontName.range(of:"-Bd") == nil {
                self.font = UIFont(name: newValue, size: self.font.pointSize)
            }
        }
    }
}

extension UITextField {
    @objc var substituteFontName : String {
        get { return self.font!.fontName }
        set { self.font = UIFont(name: newValue, size: (self.font?.pointSize)!) }
    }
}

extension UIButton{
    @objc dynamic var substituteFontName: String? {
        get { return self.titleLabel?.font.fontName }
        set {
            if let fontNameToTest = self.titleLabel?.font.fontName {
                let sizeOfOldFont = self.titleLabel?.font.pointSize
                var fontNameOfNewFont = ""
                if fontNameToTest.range(of: "Bold") != nil || fontNameToTest.range(of: "Heavy") != nil {
                    fontNameOfNewFont += "-Bold" ;
                } else if fontNameToTest.range(of: "Semibold") != nil || fontNameToTest.range(of: "Md") != nil{
                    fontNameOfNewFont +=  "-Light" ;
                } else if fontNameToTest.range(of: "medium") != nil || fontNameToTest.range(of: "Md") != nil{
                    fontNameOfNewFont +=  "-Light" ;
                } else if fontNameToTest.range(of: "light") != nil {
                    fontNameOfNewFont +=  "-Light" ;
                } else if fontNameToTest.range(of: "ultralight") != nil {
                    fontNameOfNewFont +=  "-Light";
                }else{
                    fontNameOfNewFont +=  "";
                }
                let font = "\(newValue ?? "GothamHTF-Book")\(fontNameOfNewFont)"
                if self.titleLabel?.font.fontName != "FontAwesome" {
                    self.titleLabel?.font = UIFont(name: font , size: sizeOfOldFont ?? 11)
                }
            }
            
        }
    }
}
