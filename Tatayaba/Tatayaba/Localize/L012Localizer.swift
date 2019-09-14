//
//  L333Localizer.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation
import UIKit

import ObjectiveC

extension UIApplication {
    class func isRTL() -> Bool{
        return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft
    }
}

class L333Localizer: NSObject {
    class func DoTheMagic() {
        
//        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.specialLocalizedStringForKey(_:value:table:)))
        
        
      MethodSwizzleGivenClassName(cls: UIApplication.self, originalSelector: #selector(getter: UIApplication.userInterfaceLayoutDirection), overrideSelector: #selector(getter: UIApplication.cstm_userInterfaceLayoutDirection))
        
        
        MethodSwizzleGivenClassName(cls: UITextField.self, originalSelector: #selector(UITextField.layoutSubviews), overrideSelector: #selector(UITextField.cstmlayoutSubviews))
        MethodSwizzleGivenClassName(cls: UILabel.self, originalSelector: #selector(UILabel.layoutSubviews), overrideSelector: #selector(UILabel.cstmlayoutSubviews))

        MethodSwizzleGivenClassName(cls: UIButton.self, originalSelector: #selector(UIButton.layoutSubviews), overrideSelector: #selector(UIButton.cstmlayoutSubviews))

        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector: #selector(Bundle.kd_localizedStringForKey))

        

     //   MethodSwizzleGivenClassName(cls: UIButton.self, originalSelector: #selector(UIButton.setImage), overrideSelector: #selector(UIButton.cstmsetImage))
        ///
        

    }
    
    class func switchTheLanguage(lan :String , fromrestPage:Bool) {
        if lan == "ar" {
            L333Language.setAppleLAnguageTo(lang: "ar")
            if #available(iOS 9.0, *) {
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
                
            } else {
                // Fallback on earlier versions
            }
        } else {
            L333Language.setAppleLAnguageTo(lang: "en")
            if #available(iOS 9.0, *) {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            } else {
                // Fallback on earlier versions
            }
        }
        if (!fromrestPage){
        let app = AppDelegate()
        app.changeLang();
        }
    }
}
private var setBeforLoc: Bool = false
extension UILabel {
    var setBefor: Bool {
        get {
            return (objc_getAssociatedObject(self, &setBeforLoc) != nil) 
        }
        set(newValue) {
            objc_setAssociatedObject(self, &setBeforLoc, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    func doStringContainsNumber() -> Bool{
        
        if self.text == nil {
            return false
        }
        
        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let containsNumber = testCase.evaluate(with:self.text)
                return containsNumber
    }
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        
        
        if self.setBefor == true || self.tag == -1
        {
            return
        }
        else
        {
            self.setBefor = true
        }
       
        if ( !doStringContainsNumber() || self.tag == 23 || self.tag == 22  || self.tag == 60   || self.tag == 222 ){

        }
        
        
//
       
        
            if UIApplication.isRTL()  {
                if self.textAlignment == .center { return }

                if self.tag == 222 {
                    self.textAlignment = .left
                    return
                }
                
                if (self.superview?.tag == 909 || self.tag == 909 ){
                    self.textAlignment = .right
                    return
                }
                
                self.textAlignment = .right
                return
                
                
                
            } else {
                if self.tag == 222 {
                    self.textAlignment = .right
                    return
                }

                if (self.superview?.tag == 909 || self.tag == 909 ){
                    self.textAlignment = .left
                    return
                }
                
                if self.textAlignment == .center {
                    return
                }
                
                self.textAlignment = .left
                return

                
            }


    }
}
let NavButtonTag = 999
let backButtonTag = 666
let closeButtonTag = 777
let signBackButtonTag = 665

let rightButtonTag = 787
let leftButtonTag = 788


extension UIButton {
    var setBefor: Bool {
        get {
            return (objc_getAssociatedObject(self, &setBeforLoc) != nil)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &setBeforLoc, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    func loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: [UIView]) {
        if subviews.count > 0 {
            for subView in subviews {
                if (subView is UIImageView) && subView.tag < 0 {
                    let toRightArrow = subView as! UIImageView
                    if let _img = toRightArrow.image {
                        toRightArrow.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImageOrientation.upMirrored)
                    }
                }
                loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: subView.subviews)
            }
        }
    }

    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
        
        
        if self.setBefor == true
        {
            return
        }
        else
        {
            self.setBefor = true
        }
        
        self.isHighlighted = false;
        self.adjustsImageWhenHighlighted = false;
        if UIApplication.isRTL() {
           

            
// let toRightArrow = self.currentImage
        
            if self.tag == backButtonTag{
                let inset = 8
                self.imageEdgeInsets = UIEdgeInsetsMake(0, CGFloat(inset), 0, -CGFloat(inset));

            if let _img = self.currentImage {
//                let file_name = _img.accessibilityIdentifier
//                let file_name2 = self.accessibilityIdentifier
                let image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImageOrientation.upMirrored)
                self.setImage(image ,for: .normal)
                }
            }
            else if self.tag == signBackButtonTag{
                
                if let _img = self.currentImage {
                    //                let file_name = _img.accessibilityIdentifier
                    //                let file_name2 = self.accessibilityIdentifier
                    let image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImageOrientation.upMirrored)
                    self.setImage(image ,for: .normal)
                }
            }
            
            else if self.tag == NavButtonTag{
                //top,left,
               let inset = 15
                self.imageEdgeInsets = UIEdgeInsetsMake(0, CGFloat(inset), 0, -CGFloat(inset));
            }
            else if self.tag == closeButtonTag{
                
                let inset = 10
                self.imageEdgeInsets = UIEdgeInsetsMake(0, CGFloat(inset), 0, -CGFloat(inset));

            }
            else if self.tag == rightButtonTag{
            
                self.contentHorizontalAlignment = .left

            
            }
            else if self.tag == leftButtonTag{
                
                self.contentHorizontalAlignment = .right
                
                
            }

        }
        else
        {
            
        }
    }
}

extension UITextField
{
    var setBefor: Bool {
        get {
            return (objc_getAssociatedObject(self, &setBeforLoc) != nil)
        }
        set(newValue) {
            objc_setAssociatedObject(self, &setBeforLoc, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    @objc public func cstmlayoutSubviews() {
        self.cstmlayoutSubviews()
    
        if self.setBefor == true {
            return
        }
        else
        {
            self.setBefor = true
        }
      
        //
        self.text = "tttttt"
        self.text = ""
        self.layoutSubviews()
        self.layoutIfNeeded()
        if #available(iOS 9.0, *) {
            self.updateFocusIfNeeded()
        }
        if UIApplication.isRTL()  {
            if self.textAlignment == .center { return }
            
            if self.tag == 222 {
                self.textAlignment = .left
                return
            }
            
            if (self.superview?.tag == 909 || self.tag == 909 ){
                self.textAlignment = .right
                return
            }
            
            self.textAlignment = .right
            return
            
            //                if self.textAlignment == .right {
            //                   self.textAlignment = .left
            //                    return
            //                }
            
            
            
        } else {
            if self.tag == 222 {
                self.textAlignment = .right
                return
            }
            
            if (self.superview?.tag == 909 || self.tag == 909 ){
                self.textAlignment = .left
                return
            }
            
            if self.textAlignment == .center {
                return
            }
            
            self.textAlignment = .left
            return
            
            
        }

//        if UIApplication.isRTL()  {
//            if self.textAlignment == .center { return }
//            
//            if self.textAlignment == .right {
//                if self.tag == 909{
//                    //self.textAlignment = .right
//
//                    return
//                }
//            self.textAlignment = .left
//                return
//            }
//        } else {
//            if self.textAlignment == .center { return }
//            
//            if self.textAlignment == .left {
//                //self.textAlignment = .right
//                return
//            }
//        }
        if UIApplication.isRTL()  {
            self.textAlignment = .right
            self.text = ""

        } else {
             self.textAlignment = .left
        }
       
        
    }
}
//{
//    public func cstmlayoutSubviews() {
//        self.cstmlayoutSubviews()
//            if UIApplication.isRTL()  {
//                if self.textAlignment == .center { return }
//                if self.textAlignment == .right { return }
//                self.textAlignment = .right
//            } else {
//                if self.textAlignment == .center { return }
//                if self.textAlignment == .left { return }
//                self.textAlignment = .left
//            }
////        if UIApplication.isRTL() {
////            if self.textAlignment == NSTextAlignment.natural
////            {
////                self.textAlignment = NSTextAlignment.right
////            }
////            else if self.textAlignment == NSTextAlignment.left
////            {
////                self.textAlignment = NSTextAlignment.right
////            }
////            else if self.textAlignment == NSTextAlignment.right
////            {
////                self.textAlignment = NSTextAlignment.left
////            }
////        } else {
////            if self.textAlignment == NSTextAlignment.natural
////            {
////                self.textAlignment = NSTextAlignment.left
////            }
////            else if self.textAlignment == NSTextAlignment.right
////            {
////                self.textAlignment = NSTextAlignment.left
////            }
////            else if self.textAlignment == NSTextAlignment.left
////            {
////                self.textAlignment = NSTextAlignment.right
////            }
////        }
//
//    }
//}


var numberoftimes = 0
extension UIApplication {
    @objc var cstm_userInterfaceLayoutDirection : UIUserInterfaceLayoutDirection {
        get {
//            if (Utility.isArabicLanguage()) {
//                return .rightToLeft
//            }
//            else
//            {
//                return .leftToRight
//
//            }

            var direction = UIUserInterfaceLayoutDirection.leftToRight
            if L333Language.currentAppleLanguage() == "ar" {
                direction = .rightToLeft
            }
            return direction
        }
    }
}
extension Bundle {

    @objc func kd_localizedStringForKey(key: String, value: String?, table tableName: String?) -> String {
        
        let currentLanguage = L333Language.currentAppleLanguage()

        // default
        var valueToReturn : String = (value != nil && value != "") ? value! : key
        
       
        if currentLanguage == "ar"{

        
            
            
                    if let localizedStringsFilePath = Bundle.main.path(forResource: "ArabicStrings", ofType: "strings") {
                        
                        let localizedStringDictionary = NSDictionary(contentsOfFile: localizedStringsFilePath)
                        
                        if let value = localizedStringDictionary?[key] as? String {
                            valueToReturn = value
                        }
                    }
        
        return valueToReturn
        }
        else
        {
            
            
          
                    
                    if let localizedStringsFilePath = Bundle.main.path(forResource: "EnglishStrings", ofType: "strings") {
                        
                        let localizedStringDictionary = NSDictionary(contentsOfFile: localizedStringsFilePath)
                        
                        if let value = localizedStringDictionary?[key] as? String {
                            valueToReturn = value
                        }
                    }
           
            return valueToReturn
        }
    }
    func specialLocalizedStringForKey(_ key: String, value: String?, table tableName: String?) -> String {
       // return Language.get(key, alter: value)
        //if self == Bundle.main {
            let currentLanguage = L333Language.currentAppleLanguage()
            var bundle = Bundle();
            
            
//            return [[NSBundle mainBundle] localizedStringForKey:key
//                value:alternate
//                table:@"EnglishStrings"];ArabicStrings
            
//        if UIApplication.isRTL()  {
//           return Bundle.main.localizedString(forKey:key, value:value, table:"ArabicStrings")
//            }
//            else{
//                return Bundle.main.localizedString(forKey:key, value:value, table:"EnglishStrings")
//
//                return Bundle.main.specialLocalizedStringForKey(key, value: value, table: "EnglishStrings")
//
//            }
            
             if currentLanguage == "ar"{
                //return Language.get(key, alter: value)

              return (bundle.specialLocalizedStringForKey(key, value: value, table: "ArabicStrings"))

            }
             else{
               // return Language.get(key, alter: value)

                return (self.specialLocalizedStringForKey(key, value: value, table: "EnglishStrings"))

            }
            
//            if let _path = Bundle.main.path(forResource: L102Language.currentAppleLanguageFull(), ofType: "lproj") {
//                bundle = Bundle(path: _path)!
//            }else
//            if let _path = Bundle.main.path(forResource: currentLanguage, ofType: "lproj") {
//                bundle = Bundle(path: _path)!
//            } else {
//                let _path = Bundle.main.path(forResource: "Base", ofType: "lproj")!
//                bundle = Bundle(path: _path)!
//            }
//            return (bundle.specialLocalizedStringForKey(key, value: value, table: tableName))
//        } else {
//            return (self.specialLocalizedStringForKey(key, value: value, table: tableName))
//        }
    }
    
    
}
func disableMethodSwizzling() {
    
}


/// Exchange the implementation of two methods of the same Class
func MethodSwizzleGivenClassName(cls: AnyClass, originalSelector: Selector, overrideSelector: Selector) {
    let origMethod: Method = class_getInstanceMethod(cls, originalSelector)!;
    let overrideMethod: Method = class_getInstanceMethod(cls, overrideSelector)!;
    if (class_addMethod(cls, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(cls, overrideSelector, method_getImplementation(origMethod), method_getTypeEncoding(origMethod));
    } else {
        method_exchangeImplementations(origMethod, overrideMethod);
    }
}
